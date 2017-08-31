//
//  CommentInputView.h
//  MercyMap
//
//  Created by zhangshupeng on 16/8/25.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol addImgBtnDelegate <NSObject>
-(void)addImgBtn;
@end
@interface CommentInputView : UIView
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *send;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic,strong)  UIButton *addImage;
@property (nonatomic,strong)  UIView  *pictureView;
@property (nonatomic,strong)NSMutableArray *lightImages;
@property (nonatomic, copy) void(^sendText)(NSString *text);
@property (nonatomic,weak)id <addImgBtnDelegate> delegate;
- (void)showInView:(UIView *)view;
@end
