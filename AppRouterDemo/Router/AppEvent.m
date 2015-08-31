//
//  AppEvent.m
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 4/14/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import "AppEvent.h"
#import "EnumParser.h"


@implementation AppEvent

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"eventTargetClassName":@"eventTarget",
             @"eventDataClassName":@"eventData"
             };
}

@end
