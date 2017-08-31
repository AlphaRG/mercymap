//
//  LightModel.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/25.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "BaseModel.h"

@interface LightModel : BaseModel
/**
 *  灯的标识
 */
@property(nonatomic,assign)int ID;
/**
 *摊贩标题
 */
@property(nonatomic,strong)NSString *ShopName;
/**
 *   摊贩类别
 */
@property(nonatomic,assign)int ShopCategoryID;
/**
 *  摊贩详情
 */
@property(nonatomic,strong)NSString *ShopDetail;
/**
 *  摊贩故事
 */
@property(nonatomic,strong)NSString *ShopStory;
/**
 *  摊贩手机号
 */
@property(nonatomic,strong)NSString *ShopMobileNum;
/**
 *  故事封面
 */
@property(nonatomic,strong)NSString *ShopHeadImg;
/**
 *  图片1
 */
@property(nonatomic,strong)NSString *ShopImg1;
/**
 *  图片2
 */
@property(nonatomic,strong)NSString *ShopImg2;
/**
 *  图片3
 */
@property(nonatomic,strong)NSString *ShopImg3;
/**
 *  图片4
 */
@property(nonatomic,strong)NSString *ShopImg4;
/**
 *  图片5
 */
@property(nonatomic,strong)NSString *ShopImg5;
/**
 *  用户ID
 */
@property(nonatomic,assign)int UID;
/**
 *  是否封面故事
 */
@property(nonatomic,assign)Boolean  IsCoverStory;
/**
 *  GPS位置
 */
@property(nonatomic,strong)NSString *Location;
/**
 *  是否删除
 */
@property(nonatomic,assign)Boolean CDel;
/**
 *  创建时间
 */
@property(nonatomic,strong)NSData *data;
/**
 *  创建人
 */
@property(nonatomic,strong)NSString *CreateBy;
/**
 *  最后更新日期
 */
@property(nonatomic,strong)NSData *LastUpdated;
/**
 *  最后更新人
 */
@property(nonatomic,strong)NSString *LatUpdateBy;

@end
