//
//  AppHub.m
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 4/14/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import "AppHub.h"
#import "JLRoutes.h"
#import "MTLJSONAdapter.h"
#import "BaseViewController.h"

@implementation AppHub

static NSMutableDictionary *routerMapDict;

+ (id)sharedInstance {
    static id state = nil;
    if (!state) {
        @synchronized(self) {
            if (!state) state = [[self alloc] init];
            routerMapDict = [NSMutableDictionary dictionary];
            
            NSString *jsonPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/%@", @"routerMap.json"]];
            NSData *routerMapData = [NSData dataWithContentsOfFile:jsonPath];
            NSArray *routerMapArray = [NSJSONSerialization JSONObjectWithData:routerMapData options:NSJSONReadingAllowFragments error:nil];
            for (NSDictionary *routerMap in routerMapArray) {
                NSString *key = [routerMap objectForKey:@"routerPath"];
                NSString *value = [routerMap objectForKey:@"entraceViewController"];
                [routerMapDict setValue:value forKey:key];
            }
            
        }
    }
    return state;
}

-(void)sub:(AppEvent *)evt
{

    [JLRoutes addRoute:evt.eventTarget handler:^BOOL(NSDictionary *parameters) {
        UINavigationController *nv = (UINavigationController *)([[[[UIApplication sharedApplication] delegate] window] rootViewController]);

        BaseDataModel *eventData = [self parseEventData:evt fromRouterParameters:parameters];
        
        if (evt.eventType == EventTypeEnter) {
            NSString *vcName = [routerMapDict objectForKey:evt.eventTarget];
            BaseViewController *vc = [[NSClassFromString(vcName) alloc] init];
            vc.dataModel = eventData;

            switch (evt.eventAction) {
                case EventActionPush:
                    [nv pushViewController:vc animated:YES];
                    break;
                default:
                    break;
            }

        }
        else if (evt.eventType == EventTypeLeave) {
            
        }
        return YES;
    }];

}

-(void)pub:(AppEvent *)evt
{
    NSDictionary *eventDataDict = [MTLJSONAdapter JSONDictionaryFromModel:evt.eventData];
    NSData *eventDataNSData = [NSJSONSerialization dataWithJSONObject:eventDataDict options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *eventDataStr = [[NSString alloc] initWithData:eventDataNSData encoding:NSUTF8StringEncoding];
    NSString *encodedEventDataStr = [eventDataNSData base64EncodedStringWithOptions:0];
    NSString *urlEncodedEventDataStr = [self urlEncodeUsingEncoding:NSUTF8StringEncoding string:encodedEventDataStr];
    NSString *urlStr = [NSString stringWithFormat:@"qx://%@?eventData=%@", evt.eventTarget, urlEncodedEventDataStr];
    NSURL *url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - Private Methods
-(BaseDataModel *)parseEventData:(AppEvent *)evt fromRouterParameters:(NSDictionary *)parameters
{
    BaseDataModel *eventData;
    NSString *encodedEventDataStr = [parameters objectForKey:@"eventData"];
    if (encodedEventDataStr) {
        NSData *decodedEventDataNSData = [[NSData alloc] initWithBase64EncodedString:encodedEventDataStr options:0];
        NSDictionary *eventDataDict = [NSJSONSerialization JSONObjectWithData:decodedEventDataNSData options:NSJSONReadingAllowFragments error:nil];
        Class eventDataClass = [MTLModel class];
        if ([evt.eventData class]) {
            eventDataClass = [evt.eventData class];
        }
        eventData = [MTLJSONAdapter modelOfClass:eventDataClass fromJSONDictionary:eventDataDict error:nil];
    }
    return eventData;
}

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding string:(NSString *)str {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)str,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}

@end
