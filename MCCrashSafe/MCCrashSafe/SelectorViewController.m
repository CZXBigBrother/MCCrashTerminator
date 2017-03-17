//
//  SelectorViewController.m
//  MCCrashSafe
//
//  Created by marco chen on 2017/3/17.
//  Copyright © 2017年 marco chen. All rights reserved.
//

#import "SelectorViewController.h"
#import "SelectorCrashObject.h"
@interface SelectorViewController ()

@end

@implementation SelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * lblTip = [[UILabel alloc]initWithFrame:self.view.frame];
    lblTip.text = @"click crash";
    lblTip.enabled = NO;
    lblTip.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblTip];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SelectorCrashObject * crash = [[SelectorCrashObject alloc]init];
    [crash performSelector:@selector(asdf)];
}

@end
