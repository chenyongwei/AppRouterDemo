//
//  AppEvent.h
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 4/14/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "AppEnums.h"

@interface AppEvent : MTLModel<MTLJSONSerializing>

@property (nonatomic) EventType eventType;
@property (nonatomic) EventAction eventAction;
@property (nonatomic, strong) NSString *eventTarget;
@property (nonatomic, strong) MTLModel<MTLJSONSerializing> *eventData;

@end
