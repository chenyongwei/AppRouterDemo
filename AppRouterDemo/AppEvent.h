//
//  AppEvent.h
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 4/14/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "MTLValueTransformer.h"
#import "AppEnums.h"

@interface AppEvent : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *router;
@property (nonatomic) EventAction eventAction;
@property (nonatomic, strong) NSString *eventTargetClassName;
@property (nonatomic, strong) NSString *eventDataClassName;

@end
