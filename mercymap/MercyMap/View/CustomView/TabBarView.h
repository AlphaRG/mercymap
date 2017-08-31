//
//  TabBarView.h
//  MercyMap
//
//  Created by sunshaoxun on 16/9/26.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol tabBarBtnDelegate<NSObject>
-(void)tabBarBtnClick:(id)tag;
@end
@interface TabBarView : UIView
- (IBAction)dianzanClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dianzanBtn;
- (IBAction)signinClick:(id)sender;
- (IBAction)commentClick:(id)sender;
- (IBAction)uploadClick:(id)sender;
-(instancetype)initWithFrame:(CGRect)frame;
@property (weak, nonatomic) IBOutlet UIButton *signinBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property(nonatomic,weak)id <tabBarBtnDelegate>delegate;
@end
