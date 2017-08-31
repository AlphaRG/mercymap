//
//  BaseHttpRequest.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
typedef void (^RequestSuccessBlock)(NSDictionary *dicData);
typedef void  (^RequestSuccessBlockStr)(NSString *successInfo);
typedef void  (^RequestFaileBlock)(NSString *errorInfo);
typedef void  (^RequestImageSuccessBlock)(NSArray *successBlock);
typedef void  (^RequestImageFailurBlock)(NSString *errorBlock);

@interface BaseHttpRequest : NSObject
{
    Single *single;
}
-(AFNetworkReachabilityStatus)netStatus;

-(void)sendRequestHttp:(NSString *)url parameters:(NSDictionary *)dic Success:(RequestSuccessBlock)successBlock  Failuer:(RequestFaileBlock)errorBlock;

-(void)sendRequestHttpGet:(NSString *)url parameters:(NSDictionary *)dic Success:(RequestSuccessBlock)successBlock Failuer:(RequestFaileBlock)errorBlock;

-(void)sendImage:(NSString *)url  Sizeimage:(UIImage *)resizedImage iamgeName:(NSString *)fileName Token:(NSString *)Token  success:(RequestImageSuccessBlock)successBlock error:(RequestImageFailurBlock)errorBlock;


-(void)sendImageurl:(NSString *)url  imageArray:(NSArray *)imageArray Token:(NSString *)Token success:(RequestImageSuccessBlock)successBlock Failuer:(RequestImageFailurBlock)errorBlock;

-(void)GetSort:(NSString *)url parameters:(NSDictionary *)dic Success:(RequestSuccessBlock)successBlock Failuer:(RequestFaileBlock)errorBlock;
@end
