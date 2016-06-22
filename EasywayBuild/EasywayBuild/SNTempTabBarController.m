//
//  SNTempTabBarController.m
//  EasywayBuild
//
//  Created by stone on 16/6/21.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "SNTempTabBarController.h"
#import "ViewController.h"

@interface SNTempTabBarController ()

@end

@implementation SNTempTabBarController

- (void)viewDidLoad {

    // Do any additional setup after loading the view.
    [super viewDidLoad];

    self.fullScreenBack = YES;

    self.customViewControllers = @[
        [[ViewController alloc] initWithTitle:@"车源" normalIcon:[UIImage imageNamed:@"cy"] seletedIcon:[UIImage imageNamed:@"cy_h"]],
        [[UIViewController alloc] initWithTitle:@"寻车" normalIcon:[UIImage imageNamed:@"xc"] seletedIcon:[UIImage imageNamed:@"xc_h"]],
        [[UIViewController alloc] initWithTitle:@"我的" normalIcon:[UIImage imageNamed:@"my"] seletedIcon:[UIImage imageNamed:@"my_h"]]
    ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
