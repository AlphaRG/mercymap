//
//  CreateLightTextCell.m
//  MercyMap
//
//  Created by zhangshupeng on 16/7/9.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "CreateLightTextCell.h"

@interface CreateLightTextCell ()<UITextViewDelegate>

@end

@implementation CreateLightTextCell


- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.textView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(self.textView.isFirstResponder){
    
    self.textViewPlaceholder.hidden = YES;
        
    }
    else{
        self.textViewPlaceholder.hidden = NO;
        }
    return YES;
    
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    if (_textView.text.length == 0) {
        
        self.textViewPlaceholder.hidden = NO;
    }
    return YES;
}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    
//    if ([text isEqualToString:@"\n"]) {
//        if (_textView.text.length == 0) {
//            self.textViewPlaceholder.hidden = NO;
//        }
//        [textView endEditing:YES];
//        return NO;
//    }else{
//        return YES;
//    }
//}

@end
