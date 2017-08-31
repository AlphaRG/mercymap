//
//  AboutUSViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/6/13.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "AboutUSViewController.h"
#import "BaseHttpRequest.h"
#import "IQKeyboardManager.h"
#import "Masonry.h"
@interface AboutUSViewController ()<UITextViewDelegate>
{
    NSMutableArray *dataArray ;
}
@end

@implementation AboutUSViewController

-(instancetype)init{
    if (self =[super init]) {
     
    }
    return self;
}

-(void)updateConstraints{
    [self.view updateConstraints];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(20);
        make.top.mas_equalTo (self.aboutInfoLable.mas_right).offset(160);
        make.height.mas_equalTo(20);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"通知";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    [self setinfo];
}
-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)getMercyInfo:(int)fag{

}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
}
-(void)setinfo{
    self.aboutInfoLable.text =@"暂无消息";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UITextView *)textView{
    if (_textView ==nil) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 160, 160, 80)];
        _textView.backgroundColor = [UIColor redColor];
    }
    return _textView;
}
@end
