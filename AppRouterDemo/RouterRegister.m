//
//  RouterRegister.m
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 4/13/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import "RouterRegister.h"
#import "JLRoutes.h"
#import "AccountViewController.h"
#import "PaymentViewController.h"
#import "SystemViewController.h"

@implementation RouterRegister

-(void)registInternalRouters
{
    [JLRoutes addRoute:@"/account/:userID" handler:^BOOL(NSDictionary *parameters) {
        NSString *userID = parameters[@"userID"];
        UIViewController *vc = [[AccountViewController alloc] init];
        UINavigationController *nv = (UINavigationController *)([[[[UIApplication sharedApplication] delegate] window] rootViewController]);
        
        [nv pushViewController:vc animated:YES];
        
        return YES;
    }];
    
    [JLRoutes addRoute:@"/system/:userID" handler:^BOOL(NSDictionary *parameters) {
        NSString *userID = parameters[@"userID"];
        UIViewController *vc = [[SystemViewController alloc] init];
        UINavigationController *nv = (UINavigationController *)([[[[UIApplication sharedApplication] delegate] window] rootViewController]);
        [nv pushViewController:vc animated:YES];
        
        return YES;
    }];
    
    [JLRoutes addRoute:@"/payment/:paymentID" handler:^BOOL(NSDictionary *parameters) {
        NSString *userID = parameters[@"paymentID"];
        UIViewController *vc = [[PaymentViewController alloc] init];
        UINavigationController *nv = (UINavigationController *)([[[[UIApplication sharedApplication] delegate] window] rootViewController]);
        
        [nv pushViewController:vc animated:YES];
        
        return YES;
    }];

}

@end
