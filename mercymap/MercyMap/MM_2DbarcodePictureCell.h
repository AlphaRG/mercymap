//
//  MM_2DbarcodePictureCell.h
//  MercyMap
//
//  Created by RainGu on 17/2/17.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "ZZBaseTableViewCell.h"

@interface MM_2DbarcodePictureCell : ZZBaseTableViewCell
@property(nonatomic,strong)UIView *scanView;
@property(nonatomic,strong)UIImageView *scanPicture;
@property(nonatomic,strong)UIButton *wechatpayBtn;
@property(nonatomic,strong)UIButton *aplipayBtn;
@property(nonatomic,strong)UIView   *wechatView;
@property(nonatomic,strong)UIView   *alipayView;
@property(nonatomic,strong)UILabel  *wechatText;
@property(nonatomic,strong)UILabel  *alipayText;
@end
