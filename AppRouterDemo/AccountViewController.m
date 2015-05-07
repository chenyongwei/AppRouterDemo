//
//  AccountViewController.m
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 4/13/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import "AccountViewController.h"
#import "AppHub.h"
#import "AppConstants.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnBack =({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(100, 100, 200, 100);
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:btnBack];
}

-(void)goback
{
    [[AppHub sharedInstance] pub:LeaveAccountModuleEventTarget];
}

@end
