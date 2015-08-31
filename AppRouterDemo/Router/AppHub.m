//
//  AppHub.m
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 4/14/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import "AppHub.h"

@implementation AppHub

static NSMutableDictionary /* array of AppEvent */ *allEvents;

+ (id)sharedInstance {
    static id instance = nil;
    if (!instance) {
        @synchronized(self) {
            if (!instance) instance = [[self alloc] init];
            
            NSString *jsonPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/%@", @"routerEvents.json"]];
            NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
            
            allEvents = [NSMutableDictionary dictionary];
            for (NSDictionary *jsonItemDict in jsonArray) {
                NSError *error;
                AppEvent *event = [MTLJSONAdapter modelOfClass:[AppEvent class] fromJSONDictionary:jsonItemDict error:&error];
                event.eventAction = [EnumParser eventActionFromString:[jsonItemDict objectForKey:JsonKeyEventAction]];
                if (!error) {
                    [allEvents setObject:event.router forKey:event];
                }
                else {
                    // log error
                }
            }
        }
    }
    return instance;
}

-(void)subscribAllEvents
{
    for (AppEvent *event in allEvents) {
        [[AppHub sharedInstance] sub:event];
    }
}

-(void)pub:(NSString *)router
{
    [self pub:router data:nil];
}

-(void)pub:(NSString *)router data:(BaseDataModel *)eventData
{
    NSString *urlStr;
    if (eventData) {
        urlStr = [NSString stringWithFormat:@"qx://%@?eventData=%@", router, [self stringFromEventData:eventData]];
    }
    else {
        urlStr = [NSString stringWithFormat:@"qx://%@", router];
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - Private Methods
-(void)sub:(AppEvent *)evt
{
    [JLRoutes addRoute:evt.router handler:^BOOL(NSDictionary *parameters) {
        UINavigationController *rootVC = (UINavigationController *)([[[[UIApplication sharedApplication] delegate] window] rootViewController]);
//        UIViewController *currentVC = [rootVC.viewControllers lastObject];
        
        NSString *vcName = evt.eventTargetClassName;
        BaseViewController *vc = [[NSClassFromString(vcName) alloc] init];
        BaseDataModel *eventData = [self parseEventData:evt.eventDataClassName fromRouterParameters:parameters];
        vc.dataModel = eventData;
        
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
        
        switch (evt.eventAction) {
            case EventActionPush:
                [rootVC pushViewController:vc animated:YES];
                break;
            case EventActionPop:
                [rootVC popViewControllerAnimated:YES];
                break;
            case EventActionPresent:
                [rootVC presentViewController:nc animated:YES completion:^{
                    //
                }];
            case EventActionDismiss:
                [rootVC dismissViewControllerAnimated:YES completion:nil];
            default:
                break;
        }
        return YES;
    }];
}

-(NSString *)stringFromEventData:(BaseDataModel *)eventData
{
    NSDictionary *eventDataDict = [MTLJSONAdapter JSONDictionaryFromModel:eventData];
    NSData *eventDataNSData = [NSJSONSerialization dataWithJSONObject:eventDataDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *encodedEventDataStr = [eventDataNSData base64EncodedStringWithOptions:0];
    NSString *urlEncodedEventDataStr = [self urlEncodeUsingEncoding:NSUTF8StringEncoding string:encodedEventDataStr];
    return urlEncodedEventDataStr;
}

-(BaseDataModel *)parseEventData:(NSString *)eventDataClassName fromRouterParameters:(NSDictionary *)parameters
{
    BaseDataModel *eventData;
    NSString *encodedEventDataStr = [parameters objectForKey:JsonKeyEventData];
    if (encodedEventDataStr) {
        NSData *decodedEventDataNSData = [[NSData alloc] initWithBase64EncodedString:encodedEventDataStr options:0];
        NSDictionary *eventDataDict = [NSJSONSerialization JSONObjectWithData:decodedEventDataNSData options:NSJSONReadingAllowFragments error:nil];
        Class eventDataClass = [MTLModel class];
        if (eventDataClassName) {
            eventDataClass = NSClassFromString(eventDataClassName);
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
