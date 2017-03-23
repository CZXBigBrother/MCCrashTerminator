//
//  UICrashView.m
//  MCCrashSafe
//
//  Created by marco chen on 2017/3/23.
//  Copyright © 2017年 marco chen. All rights reserved.
//

#import "UICrashView.h"

@implementation UICrashView
- (void)setNeedsDisplay {
    [super setNeedsDisplay];
    NSLog(@"setNeedsDisplay");
}

@end
