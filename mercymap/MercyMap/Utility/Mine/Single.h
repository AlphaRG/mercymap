//
//  Single.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/18.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Single : NSObject
@property(nonatomic,assign)int ID;
@property(nonatomic,strong)NSString *MobileNum;
@property(nonatomic,strong)NSString *Password;
@property(nonatomic,strong)NSString *Token;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *payResult;
@property(nonatomic,strong)NSString *wechaturl;
@property(nonatomic,strong)NSString *alipayurl;
+(Single *)Send;
@end
