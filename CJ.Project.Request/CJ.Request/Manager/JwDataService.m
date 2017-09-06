//
//  JwDataService.m
//  CJ.Project.Request
//
//  Created by 陈警卫 on 2017/9/6.
//  Copyright © 2017年 陈警卫. All rights reserved.
//

#import "JwDataService.h"

@implementation JwDataService

+ (JwDataService *)shareData{
    static JwDataService *dataService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataService = [[JwDataService alloc] init];
    });
    return dataService;
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^)(JwUser *user))success failure:(void (^)(NSError *error))failure{
    
    //设置参数
    NSDictionary *param = @{@"username": username,
                            @"password": password};
    param = [self deviceParam:param];
    
    //设置节点
    NSString *point = @"login";
    
    [self.httpManager POST:param point:point success:^(id data) {
        
        NSDictionary *userinfo = data[@"data"];
        JwUser *user = [[JwUser alloc] initWithDictionary:userinfo error:nil];
        
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
