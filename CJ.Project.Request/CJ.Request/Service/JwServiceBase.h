//
//  JwServiceBase.h
//  CJ.Project.Request
//
//  Created by 陈警卫 on 2017/9/5.
//  Copyright © 2017年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwHttpManager.h"


@interface JwServiceBase : NSObject<HttpManagerDelegate>

@property (nonatomic, strong) JwHttpManager *httpManager;

- (NSDictionary *)deviceParam:(NSDictionary *)param;

@end
