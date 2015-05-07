//
//  EnumParser.m
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 5/7/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import "EnumParser.h"

@implementation EnumParser

+(EventAction)eventActionFromString:(NSString *)string
{
    if ([@"push" isEqualToString:string]) {
        return EventActionPush;
    }
    else if ([@"pop" isEqualToString:string]) {
        return EventActionPop;
    }
    else if ([@"present" isEqualToString:string]) {
        return EventActionPresent;
    }
    else if ([@"dismiss" isEqualToString:string]) {
        return EventActionDismiss;
    }
    else if ([@"root" isEqualToString:string]) {
        return EventActionRoot;
    }
    else {
        return EventActionNone;
    }
}

@end
