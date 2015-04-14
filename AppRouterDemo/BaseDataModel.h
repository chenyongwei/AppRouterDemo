//
//  BaseDataModel.h
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 4/14/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface BaseDataModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *moduleName;

@end
