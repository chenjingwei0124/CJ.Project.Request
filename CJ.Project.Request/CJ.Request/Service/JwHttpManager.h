//
//  JwHttpManager.h
//  CJ.Project.Request
//
//  Created by 陈警卫 on 2017/9/5.
//  Copyright © 2017年 陈警卫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@protocol HttpManagerDelegate <NSObject>

@required

//
- (BOOL)httpManager:(id)hepler response:(id)response;

- (void)httpManager:(id)helper response:(id)response error:(NSError *)error;

@end

@interface JwHttpManager : NSObject

@property (weak, nonatomic) id<HttpManagerDelegate> delegate;

+ (JwHttpManager *)sharedManager;

- (void)GET:(NSDictionary *)params point:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure;

- (void)POST:(NSDictionary *)params point:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure;

- (void)DELETE:(NSDictionary *)params point:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure;

//单个图片
- (void)upload:(NSDictionary *)params point:(NSString *)point image:(UIImage *)image success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//多个图片
- (void)upload:(NSDictionary *)params point:(NSString *)point images:(NSArray *)images imageNames:(NSArray *)imageNames success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;

@end
