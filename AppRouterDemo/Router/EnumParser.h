//
//  EnumParser.h
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 5/7/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppEnums.h"

@interface EnumParser : NSObject

+(EventAction)eventActionFromString:(NSString *)string;

@end
