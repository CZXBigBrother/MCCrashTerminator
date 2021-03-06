//
//  ViewController.m
//  MCCrashSafe
//
//  Created by marco chen on 2017/3/17.
//  Copyright © 2017年 marco chen. All rights reserved.
//

#import "ViewController.h"
#import "SelectorViewController.h"
#import "UINeedsViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSArray *myArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.myArr = @[@"unrecognized selector",@"UI not on Main Thread"];
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.myArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SelectorViewController * select = [[SelectorViewController alloc]init];
        [self.navigationController pushViewController:select animated:YES];
    }else if(indexPath.row == 1) {
        UINeedsViewController * ui = [[UINeedsViewController alloc]init];
        [self.navigationController pushViewController:ui animated:YES];
    }
}

@end
