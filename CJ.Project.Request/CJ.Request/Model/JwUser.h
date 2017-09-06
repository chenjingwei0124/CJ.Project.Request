//
//  JwUser.h
//  CJ.Project.Request
//
//  Created by 陈警卫 on 2017/9/6.
//  Copyright © 2017年 陈警卫. All rights reserved.
//

#import "JwModelBase.h"

@interface JwUser : JwModelBase

@property (nonatomic, strong) NSString<Optional> *username;
@property (nonatomic, strong) NSString<Optional> *token_type;
@property (nonatomic, strong) NSString<Optional> *access_token;

@end
