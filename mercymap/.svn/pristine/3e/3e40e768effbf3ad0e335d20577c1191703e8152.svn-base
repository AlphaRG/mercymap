//
//  CommentInputView.m
//  MercyMap
//
//  Created by zhangshupeng on 16/8/25.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "CommentInputView.h"
#import "Masonry.h"
@interface CommentInputView ()<UITextViewDelegate>
@end

@implementation CommentInputView


- (instancetype)init {
    if (self = [super init]) {
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.send];
//      [self.contentView addSubview:self.addImage];
        [self.contentView addSubview:self.pictureView];
        [self.contentView setNeedsUpdateConstraints];
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.3];
    }
    return self;
}
- (void)updateConstraints {
    [super updateConstraints];
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(kSCREENWIDTH, 0));
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(9);
        make.top.mas_equalTo(self.pictureView.mas_bottom).offset(9);
        make.bottom.mas_equalTo(self.send.mas_top).offset(-4);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-9);
    }];
    [self.send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 20));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-4);
    }];
    
//  [self.addImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(60, 20));
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-100);
//        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-4);
//    }];
}

- (void)showInView:(UIView *)view {
    self.frame = view.bounds;
    self.contentView.frame = CGRectMake(0, self.bounds.size.height - 80, kSCREENWIDTH,80);
    [self addSubview:self.contentView];
    [self.textView becomeFirstResponder];
    [view addSubview:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView endEditing:YES];
    [self removeFromSuperview];
}

- (void)sendAction:(UIButton *)button {
    if (self.textView.text.length <=0) {
        NSLog(@"输入为空");
        return;
    }
    if (self.sendText) {
        self.sendText(self.textView.text);
    }
    [self.lightImages removeAllObjects];
    [self removeFromSuperview];
}

-(void)addImageAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(addImgBtn)]) {
        [self.delegate addImgBtn];
    }
}

- (UIButton *)send {
    if (_send == nil) {
        _send = [UIButton buttonWithType:0];
        [_send addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
        _send.titleLabel.font = [UIFont systemFontOfSize:12];
        [_send setTitle:@"发送" forState:UIControlStateNormal];
        [_send setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_send setBackgroundColor:[UIColor colorWithRed:34/255.0 green:121/255.0 blue:238/255.0 alpha:1]];
        _send.layer.cornerRadius = 4;
    }
    return _send;
}

-(UIButton *)addImage{
    if (_addImage  == nil) {
        _addImage =  [UIButton buttonWithType:0];
        _addImage.titleLabel.font = [UIFont systemFontOfSize:12];
        [_addImage setTitle:@"图片" forState:UIControlStateNormal];
        _addImage.backgroundColor = [UIColor colorWithRed:34/255.0 green:121/255.0 blue:238/255.0 alpha:1.0];
        [_addImage addTarget:self action:@selector(addImageAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        _addImage.layer.cornerRadius = 4;
       [_addImage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
       return _addImage;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:246/255.0 alpha:1];
    }
    return _contentView;
}

-(UIView *)pictureView{
    if (_pictureView==nil) {
        _pictureView = [[UIView alloc]init];
        _pictureView.backgroundColor = [UIColor clearColor];
    }
    return _pictureView;
}

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc]init];
        _textView.layer.cornerRadius = 4;
    }
    return _textView;
}

-(NSMutableArray *)lightImages{
    if (_lightImages == nil) {
        _lightImages = [NSMutableArray arrayWithCapacity:0];
    }
    return _lightImages;
}
@end
