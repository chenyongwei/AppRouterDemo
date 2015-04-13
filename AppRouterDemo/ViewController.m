//
//  ViewController.m
//  AppRouterDemo
//
//  Created by Yongwei.Chen on 4/13/15.
//  Copyright (c) 2015 DCF. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)goAccount:(id)sender {
    NSURL *url = [NSURL URLWithString:@"qx://account/1234"];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)goPayment:(id)sender {
    NSURL *url = [NSURL URLWithString:@"qx://payment/2345"];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)goSystem:(id)sender {
    NSURL *url = [NSURL URLWithString:@"qx://system/3456"];
    [[UIApplication sharedApplication] openURL:url];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
