//
//  SYMGridView.h
//  MercyMap
//
//  Created by zhangshupeng on 16/7/9.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYMGridView : UIView

@property(nonatomic,assign)BOOL clipSubViews;

///上下左右边距
@property(nonatomic,assign)UIEdgeInsets elementEdgeInsets;



@property (nonatomic, copy) void(^ClickView)(NSInteger index);


//@property(nonatomic,assign)BOOL elementUserInteractionEnabled;

///自己的size
//@property(nonatomic,assign,readonly)CGRect viewSize;

///控件的size
@property(nonatomic,assign)CGSize elementSize;

///每行两个控件之间的距离
@property(nonatomic,assign)CGFloat rowElementDistance;

///行间距
@property(nonatomic,assign)CGFloat lineDistance;


///每行控件的个数
@property(nonatomic,assign)NSInteger rowCount;

///用来添加控件

-(void)addElement:(NSArray*)elements;


@end
