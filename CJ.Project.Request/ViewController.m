//
//  ViewController.m
//  CJ.Project.Request
//
//  Created by 陈警卫 on 2017/9/5.
//  Copyright © 2017年 陈警卫. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //直接调用请求方法
    [self.dataService loginWithUsername:@"username" password:@"password" success:^(JwUser *user) {
        
        //直接返回解析JSON数据model -->user
        
    } failure:^(NSError *error) {
        
        //已做同一处理 不用再做判断
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Getter
- (JwDataService *)dataService{
    _dataService = [JwDataService shareData];
    return _dataService;
}

@end
