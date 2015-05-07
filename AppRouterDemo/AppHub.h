//
//  AppHub.h
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 4/14/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppEvent.h"
#import "AppConstants.h"
#import "JLRoutes.h"
#import "MTLJSONAdapter.h"
#import "EnumParser.h"
#import "BaseViewController.h"
#import "BaseDataModel.h"

@interface AppHub : NSObject

+(instancetype)sharedInstance;

-(void)subscribAllEvents;
-(void)pub:(NSString *)router;
-(void)pub:(NSString *)router data:(BaseDataModel *)eventData;

@end
