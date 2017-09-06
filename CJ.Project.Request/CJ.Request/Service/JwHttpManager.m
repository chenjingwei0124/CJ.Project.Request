//
//  JwHttpManager.m
//  CJ.Project.Request
//
//  Created by 陈警卫 on 2017/9/5.
//  Copyright © 2017年 陈警卫. All rights reserved.
//

#import "JwHttpManager.h"
#import "JwServiceDefine.h"
#import "MacroUtility.h"

@interface JwHttpManager ()

@property (nonatomic, strong) AFHTTPSessionManager *session;

@end

@implementation JwHttpManager

+ (JwHttpManager *)sharedManager{
    static JwHttpManager *httpManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpManager = [[JwHttpManager alloc] init];
    });
    return httpManager;
}

- (void)GET:(NSDictionary *)params point:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure{
    DLog(@"%@---%@", point, params);
    //数据请求
    [self.session GET:point parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DLog(@"%@", responseObject);
        
        if ([self.delegate httpManager:self response:responseObject]) {
            success(responseObject);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:nil];
            }
        }else{
            NSDictionary *ret = responseObject;
            NSError *error = [NSError errorWithDomain:(ret[@"message"] == nil ? @"" : ret[@"message"])
                                                 code:[ret[@"status"] integerValue]
                                             userInfo:responseObject];
            failure(error);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:error];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@", error);
        failure(error);
        if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
            [self.delegate httpManager:self response:nil error:error];
        }
    }];
}

- (void)POST:(NSDictionary *)params point:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure{
    
    DLog(@"%@---%@", point, params);
    
    self.session.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [self.session POST:point parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DLog(@"%@", responseObject);
        //通过代理方法判断请求数据是否成功
        if ([self.delegate httpManager:self response:responseObject]) {
            success(responseObject);
        }else{
            NSDictionary *ret = responseObject;
            NSError *error = [NSError errorWithDomain:(ret[@"message"] == nil ? @"" : ret[@"message"])
                                                 code:[ret[@"status"] integerValue]
                                             userInfo:responseObject];
            failure(error);
            //通过代理方法统一处理失败数据
            [self.delegate httpManager:self response:responseObject error:error];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@", error);
        
        failure(error);
        //通过代理方法统一处理失败数据
        [self.delegate httpManager:self response:nil error:error];
    }];
}

- (void)DELETE:(NSDictionary *)params point:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure{
    
    DLog(@"%@---%@", point, params);
    [self.session DELETE:point parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DLog(@"%@", responseObject);
        
        if ([self.delegate httpManager:self response:responseObject]) {
            success(responseObject);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:nil];
            }
        }else{
            NSDictionary *ret = responseObject;
            NSError *error = [NSError errorWithDomain:(ret[@"message"] == nil ? @"" : ret[@"message"])
                                                 code:[ret[@"status"] integerValue]
                                             userInfo:responseObject];
            failure(error);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:error];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DLog(@"%@", error);
        failure(error);
        if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
            [self.delegate httpManager:self response:nil error:error];
        }
    }];
}

- (void)upload:(NSDictionary *)params point:(NSString *)point image:(UIImage *)image success:(void(^)(id data))success failure:(void(^)(NSError *error))failure{
    
    DLog(@"%@---%@---%@", point, params, image);
    
    [self.session POST:point parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         NSData *data = UIImageJPEGRepresentation(image, 0.5f);
         // 上传时使用当前的系统时间做为文件名
         NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
         formatter.dateFormat  = @"yyyyMMddHHmmssSSS";
         NSString *fileName = [NSString stringWithFormat:@"%@.png", [formatter stringFromDate:[NSDate date]]];
         /**
          *  appendPartWithFileData  //  指定上传的文件
          *  name                    //  指定在服务器中获取对应文件或文本时的key
          *  fileName                //  指定上传文件的原始文件名
          *  mimeType                //  指定上传文件的MIME类型
          */
         [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
         
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         if ([self.delegate httpManager:self response:responseObject]) {
             success(responseObject);
             
             if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                 [self.delegate httpManager:self response:responseObject error:nil];
             }
         }else{
             NSDictionary *ret = responseObject;
             NSError *error = [NSError errorWithDomain:(ret[@"message"] == nil ? @"" : ret[@"message"])
                                                  code:[ret[@"status"] integerValue]
                                              userInfo:responseObject];
             failure(error);
             
             if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                 [self.delegate httpManager:self response:responseObject error:error];
             }
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         failure(error);
         if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
             [self.delegate httpManager:self response:nil error:error];
         }
     }];
}


- (void)upload:(NSDictionary *)params point:(NSString *)point images:(NSArray *)images imageNames:(NSArray *)imageNames success:(void(^)(id data))success failure:(void(^)(NSError *error))failure{
    
    DLog(@"%@---%@---%@---%@", point, params, imageNames, images);
    [self.session POST:point parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         for (NSInteger i = 0; i < images.count; i++) {
             
             NSData *data = UIImageJPEGRepresentation(images[i], 1.0f);
             for (float j = 1.0; j > 0.1; j = j - 0.1) {
                 data = UIImageJPEGRepresentation(images[i], j);
                 if (data.length/1024 < 90) {
                     break;
                 }
             }
             // 上传时使用当前的系统时间做为文件名
             DLog(@"%lu", (unsigned long)data.length);
             NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
             formatter.dateFormat  = @"yyyyMMddHHmmssSSS";
             NSString *fileName = [NSString stringWithFormat:@"%@.jpeg", [formatter stringFromDate:[NSDate date]]];
             /**
              *  appendPartWithFileData  //  指定上传的文件
              *  name                    //  指定在服务器中获取对应文件或文本时的key
              *  fileName                //  指定上传文件的原始文件名
              *  mimeType                //  指定上传文件的MIME类型
              */
             [formData appendPartWithFileData:data name:imageNames[i] fileName:fileName mimeType:@"image/jpeg"];
         }
         
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         DLog(@"%@", responseObject);
         if ([self.delegate httpManager:self response:responseObject]) {
             success(responseObject);
             
             if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                 [self.delegate httpManager:self response:responseObject error:nil];
             }
         }else{
             NSDictionary *ret = responseObject;
             NSError *error = [NSError errorWithDomain:(ret[@"message"] == nil ? @"" : ret[@"message"])
                                                  code:[ret[@"status"] integerValue]
                                              userInfo:responseObject];
             failure(error);
             [self.delegate httpManager:self response:responseObject error:error];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         DLog(@"%@", error);
         failure(error);
         if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
             [self.delegate httpManager:self response:nil error:error];
         }
     }];
}

#pragma mark -- GET

- (AFHTTPSessionManager *)session{
    if (!_session) {
        NSURL *baseURL = [NSURL URLWithString:kServiceBaseURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
        session.requestSerializer.timeoutInterval = 30;
        //申明返回的结果可接收类型
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"application/json", @"text/plain", @"text/javascript", nil];
        
        
        //信任非法证书
        session.securityPolicy.allowInvalidCertificates = YES;
        //校验证书域名
        session.securityPolicy.validatesDomainName = YES;
        //关闭缓存避免干扰测试
        session.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        //证书校验
        /*
        //证书验证模式
        session.securityPolicy = [AFSecurityPolicy policyWithPinningMode:(AFSSLPinningModeCertificate)];
        //证书字符
        //把证书的cer文件放入到项目中
        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"certificate" ofType:@"cer"];
        NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
        //检测证书
        session.securityPolicy.pinnedCertificates = [NSSet setWithObject:cerData];
        */
        _session = session;
    }
    return _session;
}

@end
