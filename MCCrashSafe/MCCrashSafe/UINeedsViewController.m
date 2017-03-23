//
//  UINeedsViewController.m
//  MCCrashSafe
//
//  Created by marco chen on 2017/3/23.
//  Copyright © 2017年 marco chen. All rights reserved.
//

#import "UINeedsViewController.h"
#import "UICrashView.h"

@interface UINeedsViewController ()
@property (weak, nonatomic) UICrashView *myCrash;

@end

@implementation UINeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSLog(@"viewDidLoad %s",dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));


    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UICrashView * crash = [[UICrashView alloc]init];
        self.myCrash = crash;
        [self.view addSubview:crash];
        crash.frame = CGRectMake(0, 0, 300, 300);
        crash.backgroundColor = [UIColor redColor];
    });
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint position = [touch locationInView:touch.view];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        self.myCrash.center = position;
//
//    });
    
}
@end
