//
//  JwServiceBase.m
//  CJ.Project.Request
//
//  Created by 陈警卫 on 2017/9/5.
//  Copyright © 2017年 陈警卫. All rights reserved.
//

#import "JwServiceBase.h"
#import "JwServiceDefine.h"

@implementation JwServiceBase

//HttpManagerDelegate
- (BOOL)httpManager:(id)hepler response:(id)response{
    NSDictionary *result = response;
    if ([result[@"code"] intValue] == kErrorCodeSuccess) {
        if ([result[@"status"] intValue] == kErrorCodeStausSuccess) {
            return YES;
        }else{
            return NO;
        }
    }else {
        return NO;
    }
}

- (void)httpManager:(id)helper response:(id)response error:(NSError *)error{
    if (error && response == nil) {
        
        NSHTTPURLResponse *response = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.response"];
        
        switch (response.statusCode) {
            case kErrorCodeInvalidateAccess_toke:
                if ([[response.allHeaderFields objectForKey:@"Www-Authenticate"] isEqualToString:@"Bearer error=\"invalid_token\""]) {
                    // access_token失效，请重新登录。
                    //[JGProgressHelper showError:@"上次登录超过有效期，请重新登录!"];
                }else{
                    //[JGProgressHelper showError:@"用户名或密码错误!"];
                }
                break;
                
            default:
                //[JGProgressHelper showError:[NSString stringWithFormat:@"请求出错了!\n%@", error.localizedDescription]];
                break;
        }
    }else if(error) {
        switch (error.code) {
            case kErrorCodeInvalidateAccess_toke:
                //[JGProgressHelper showError:@"上次登录超过有效期，请重新登录!"];
                break;
            case kErrorCodeWrongOperatorPower:
                //[JGProgressHelper showLongWarning:@"超出制单权限"];
                break;
            case kErrorCodeWrongReviewerPower:
                //[JGProgressHelper showLongWarning:@"超出复核权限"];
                break;
            case kErrorCodeWrongPattern:
                //[JGProgressHelper showError:@"验证手势密码错误"];
                break;
            case kErrorCodeWrongOldPin:
                //[JGProgressHelper showError:@"支付密码错误"];
                break;
            case kErrorCodeWrongOldPassword:
                //[JGProgressHelper showError:@"登录密码错误"];
                break;
            case kErrorCodeWrongNewOldPin:
                //[JGProgressHelper showError:@"新旧支付密码相同"];
                break;
            case kErrorCodeWrongNewOldPassword:
                //[JGProgressHelper showError:@"新旧登录密码相同"];
                break;
            case kErrorCodeUserAlreadyExists:
                //[JGProgressHelper showError:@"该用户已经存在"];
                break;
            case kErrorCodeUserAlreadyDeleted:
                //[JGProgressHelper showError:@"该用户不存在"];
                break;
            default:
                break;
        }
    }
}

- (NSDictionary *)deviceParam:(NSDictionary *)param{
    
    NSMutableDictionary *deviceParam = [NSMutableDictionary dictionaryWithDictionary:param];
    //UUID
    deviceParam[@"deviceId"] = [[UIDevice currentDevice].identifierForVendor UUIDString];
    //Type
    deviceParam[@"platform"] = @"iOS";
    //Version
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    deviceParam[@"ver"] = appVersion;
    
    return deviceParam;
}

#pragma mark -- GET
- (JwHttpManager *)httpManager{
    if (!_httpManager) {
        _httpManager = [JwHttpManager sharedManager];
        _httpManager.delegate = self;
    }
    return _httpManager;
}

@end
