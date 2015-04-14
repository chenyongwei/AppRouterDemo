//
//  AppEnums.h
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 4/14/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

typedef NS_ENUM(NSInteger, EventType) {
    EventTypeEnter,
    EventTypeLeave
};

typedef NS_ENUM(NSInteger, EventAction) {
    EventActionPush,
    EventActionPresent,
    EventActionRoot
};