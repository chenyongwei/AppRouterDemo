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
    AppEvent *accountModuleEnteraceEvent = ({
        AppEvent *evt = [AppEvent new];
        evt.eventTarget = AccountModuleEventTarget;
        evt.eventType = EventTypeEnter;
        evt.eventAction = EventActionPush;
        evt.eventData = ({
            AccountEnteraceModel *model = [AccountEnteraceModel new];
            model.moduleName = @"账户模块";
            model;
        });
        evt;
    });
    [[AppHub sharedInstance] pub:accountModuleEnteraceEvent];
}

- (IBAction)goPayment:(id)sender {
    AppEvent *paymentModuleEnteraceEvent = ({
        AppEvent *evt = [AppEvent new];
        evt.eventTarget = PaymentModuleEventTarget;
        evt.eventType = EventTypeEnter;
        evt.eventAction = EventActionPush;
        evt.eventData = ({
            PaymentEnteraceModel *model = [PaymentEnteraceModel new];
            model.moduleName = @"支付模块";
            model;
        });
        evt;
    });
    [[AppHub sharedInstance] pub:paymentModuleEnteraceEvent];
}

- (IBAction)goSystem:(id)sender {
    AppEvent *systemModuleEnteraceEvent = ({
        AppEvent *evt = [AppEvent new];
        evt.eventTarget = SystemModuleEventTarget;
        evt.eventType = EventTypeEnter;
        evt.eventAction = EventActionPush;
        evt.eventData = ({
            SystemEnteraceModel *model = [SystemEnteraceModel new];
            model.moduleName = @"系统模块";
            model;
        });
        evt;
    });
    [[AppHub sharedInstance] pub:systemModuleEnteraceEvent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
