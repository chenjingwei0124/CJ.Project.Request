//
//  JwDataService.h
//  CJ.Project.Request
//
//  Created by 陈警卫 on 2017/9/6.
//  Copyright © 2017年 陈警卫. All rights reserved.
//

#import "JwServiceBase.h"
#import "JwUser.h"

@interface JwDataService : JwServiceBase

+ (JwDataService *)shareData;

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^)(JwUser *user))success failure:(void (^)(NSError *error))failure;

@end
