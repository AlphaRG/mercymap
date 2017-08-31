//
//  CreatePhotoTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/6/22.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "CreatePhotoTableViewCell.h"
#import "ButtonAdd.h"
#import "CreateTableViewController.h"
#import "ZLThumbnailViewController.h"

@interface CreatePhotoTableViewCell ()<UITextViewDelegate>

@end

@implementation CreatePhotoTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    if ([MtextView.text isEqualToString:@""]) {
        [textBtn setHidden:YES];
    }
    else{
        [textBtn setHidden:NO];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

}

-(void)getcellInfo:(NSMutableArray *)arraySelectPhotos
{
    CGFloat windth = (self.photoView.frame.size.width/5)-3;
    CGFloat height =(self.photoView.frame.size.height/4)-3;

    textBtn = [[UILabel alloc]initWithFrame:CGRectMake(0,5, self.photoView.frame.size.width,10)];
    textBtn.backgroundColor =[UIColor whiteColor];
    textBtn.font =[UIFont fontWithName:@"STHeiti-Medium" size:5];

    textBtn.text =[NSString stringWithFormat:@"请编辑内容"];
    [textBtn setTextColor:[UIColor grayColor]];
    

    MtextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 0, self.photoView.frame.size.width,height*1.2)];
    MtextView.delegate =self;
    MtextView.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    MtextView.editable = YES;        //是否允许编辑内容，默认为“YES”
    MtextView.font=[UIFont fontWithName:@"Arial" size:14.0]; //设置字体名字和字体大小;
    MtextView.returnKeyType = UIReturnKeyDone;//return键的类型
    MtextView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    MtextView.textAlignment = NSTextAlignmentLeft;
    [MtextView addSubview:textBtn];
//    UIImageView *imageView2 =[[UIImageView alloc]initWithFrame:CGRectMake(2,MtextView.frame.size.height, windth*2, windth*1.2)];
//
//    UITapGestureRecognizer *singleRecongnizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap2)];
//    
//    singleRecongnizer.numberOfTapsRequired =1;
//    singleRecongnizer.numberOfTouchesRequired =1;
//    imageView2.userInteractionEnabled =YES;
//    
//    [imageView2 addGestureRecognizer:singleRecongnizer];
//    

    if(arraySelectPhotos.count ==0)
    {
        
     MtextView.text =textStr;
     addimageBtn =[[UIButton alloc]initWithFrame:CGRectMake(5, height*1.6, windth, windth)];
    [addimageBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    
    [addimageBtn addTarget:self action:@selector(addimage) forControlEvents:UIControlEventTouchUpInside];
    [self.photoView addSubview:addimageBtn];
    [self.photoView addSubview:MtextView];
        
    }
    
    else
    {
        int i =0;
        _ArrSelectPhotos = [NSMutableArray array];
        
        imagedataArray =[NSMutableArray arrayWithCapacity:0];
        
        for (UIView *subV in [_photoView subviews]) {
            [subV removeFromSuperview];
            
        }
        
        [imagedataArray removeAllObjects];
        
        for (ZLSelectPhotoModel *model in arraySelectPhotos)
        {
//            UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(i%5*(windth+3)+2,imageView2.frame.origin.y+imageView2.frame.size.height+2, windth, windth)];
            UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(i%5*(windth+3)+2, i/5*(windth+3)+height*2, windth, windth)];
            
            imageView1.image = model.image;
            
            [_ArrSelectPhotos addObject:model];
            
            [imagedataArray addObject:imageView1.image];
            
            
            UITapGestureRecognizer *singleRecongnizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
            singleRecongnizer.numberOfTapsRequired =1;
            singleRecongnizer.numberOfTouchesRequired =1;
            imageView1.userInteractionEnabled =YES;
            [imageView1 addGestureRecognizer:singleRecongnizer];
            
            i++;
            
            [self.photoView addSubview:imageView1];
        }
        
        [self.delegate sendimages:imagedataArray];
        
//        imageView2.image =[UIImage imageNamed:@"picture.png"];
        
        if (imagedataArray.count<5)
         {
          //[addimageBtn setFrame:CGRectMake(i%5*(windth+3)+2,imageView2.frame.origin.y+imageView2.frame.size.height+2, windth, windth)];

              addimageBtn.hidden =NO;
             [addimageBtn setFrame:CGRectMake(i%5*(windth+3)+2,i/5*(windth+3)+height*2, windth, windth)];
         }
        else
        {
            addimageBtn.hidden =YES;
        }
        
        MtextView.text =textStr;
        [self textViewjudge];
        [self.photoView addSubview:addimageBtn];
//      [self.photoView addSubview:imageView2];
        [self.photoView addSubview:MtextView];
        [self addSubview:self.photoView];
        
 
    }
    

}


-(void)addimage
{
    if ([self.delegate respondsToSelector:@selector(sendphotos:sendtag:)])
    {
        [self.delegate sendphotos:_ArrSelectPhotos sendtag:0];
    }

    
}

-(void)singleTap
{
    if ([self.delegate respondsToSelector:@selector(sendphotos:sendtag:)])
    {
        [self.delegate sendphotos:_ArrSelectPhotos sendtag:1];
    }

}
-(void)singleTap2
{
    if ([self.delegate respondsToSelector:@selector(sendphotos:sendtag:)])
    {
        [self.delegate sendphotos:_ArrSelectPhotos sendtag:2];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [textBtn setHidden:YES];
    [MtextView becomeFirstResponder];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
   if ([MtextView.text isEqualToString:@""])
    {
        [textBtn setHidden:NO];

    }
    else
    {
        textStr =MtextView.text;
        [self.delegate sendtextInfo:textStr];

    }
}
-(void)textViewjudge
{
    if ([MtextView.text isEqualToString:@""]) {
        [textBtn setHidden:NO];
    }
    else
    {
        [textBtn setHidden:YES];
    }
    

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView endEditing:YES];
        return NO;
    }else{
        return YES;
    }
}


@end
