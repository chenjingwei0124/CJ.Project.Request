//
//  JwServiceDefine.h
//  CJ.Project.Request
//
//  Created by 陈警卫 on 2017/9/6.
//  Copyright © 2017年 陈警卫. All rights reserved.
//

#ifndef JwServiceDefine_h
#define JwServiceDefine_h


typedef enum : NSUInteger {
    
    kErrorCodeStausSuccess             = 0,
    kErrorCodeSuccess                  = 200,
    
    kErrorCodeInvalidateAccess_toke    = 401,
    kErrorCodeWrongVerificationCode    = 402,
    
    kErrorCodeWrongOperatorPower       = 102,
    kErrorCodeWrongReviewerPower       = 103,
    kErrorCodeWrongPattern             = 104,
    kErrorCodeWrongOldPin              = 101,
    kErrorCodeWrongNewOldPin           = 107,
    kErrorCodeWrongOldPassword         = 105,
    kErrorCodeWrongNewOldPassword      = 106,
    kErrorCodeUserAlreadyExists        = 201,
    kErrorCodeUserAlreadyDeleted       = 202,
    
} ErrorCode;

#define kServiceBaseURL @"http://www.baidu.com"


//关于数据统一处理
//针对于所有的返回都遵循如下格式。其中message字段并非必选。本文档描述的数据结构是DATA所代表的数据。
/*
 {
 "code": 200
 "status": 0,
 "message": "some msg",
 "data": "[DATA]"
 }
 */
//如数据结构不同 可作相应更改


#endif /* JwServiceDefine_h */
