//
//  TestViewController.m
//  JMM
//
//  Created by njw on 2019/1/31.
//  Copyright © 2019 hanqiyuan. All rights reserved.
//

#import "TestViewController.h"
#import "TestRequest.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)net_request:(id)sender {
    TestRequest *userRequest = [[TestRequest alloc] init];
    [userRequest startRequestWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        User *user = (User *)userRequest.data;
        DLog(@"====================User=======================");
        DLog(@"name:%@ gender:%@", user.username, user.gender);
        DLog(@"====================User=======================");
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
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
