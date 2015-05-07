//
//  ViewController.m
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 4/13/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import "ViewController.h"
#import "AppHub.h"
#import "SystemEnteraceModel.h"
#import "AccountEnteraceModel.h"
#import "PaymentEnteraceModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)goAccount:(id)sender {
    AccountEnteraceModel *model = [AccountEnteraceModel new];
    model.moduleName = @"账户模块";
    [[AppHub sharedInstance] pub:EnterAccountModuleEventTarget data:model];
}

- (IBAction)goPayment:(id)sender {
    PaymentEnteraceModel *model = [PaymentEnteraceModel new];
    model.moduleName = @"支付模块";
    [[AppHub sharedInstance] pub:EnterPaymentModuleEventTarget data:model];

}

- (IBAction)goSystem:(id)sender {
    SystemEnteraceModel *model = [SystemEnteraceModel new];
    model.moduleName = @"系统模块";
    [[AppHub sharedInstance] pub:EnterSystemModuleEventTarget data:model];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
