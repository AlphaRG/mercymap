//
//  LightListInfoTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/26.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LightListInfoTableViewCell.h"
#define imageCount 5
#define kSpaceForCol 5
#import "LoginService.h"
@implementation LightListInfoTableViewCell
{
    LoginService *service;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO  animated:NO];

    // Configure the view for the selected state
}

- (IBAction)LightenjoyBtnClick:(id)sender {
    
    if([self.Ddelegaet respondsToSelector:@selector(sendDianzanDelegaet:)])
    {
        [self.Ddelegaet sendDianzanDelegaet:3];
    }
  
}

- (IBAction)LightdianzanBtnClick:(id)sender {
    
    if ([self.Ddelegaet respondsToSelector:@selector(sendDianzanDelegaet:)]) {
        
        [_LightdianzanBtn setImage:[UIImage imageNamed:@"dianzan1"] forState:UIControlStateNormal];
        
        [self.Ddelegaet sendDianzanDelegaet:1];
    }
    
}

- (IBAction)LightpinglunBtnClick:(id)sender {
    
    if([self.Ddelegaet respondsToSelector:@selector(sendDianzanDelegaet:)])
    {
        [self.Ddelegaet sendDianzanDelegaet:2];
    }

}

- (IBAction)commentBtnClick:(id)sender {
    if([self.Ddelegaet respondsToSelector:@selector(sendDianzanDelegaet:)])
    {
        [self.Ddelegaet sendDianzanDelegaet:4];
    }

    
}

- (IBAction)shoucangBtnClick:(id)sender {
    
    if ([self.Ddelegaet respondsToSelector:@selector(sendDianzanDelegaet:)]) {
        [self.Ddelegaet sendDianzanDelegaet:5];
    }
}

-(void)setCellInfo:(NSDictionary *)dic fag:(int)fag Collectionfag:(int)collectFag{
if (![dic[@"ShopMainImg"] isKindOfClass:[NSNull class]]) {
        NSString *str =[NSString stringWithFormat:@"%@uploadfiles/%@",URLM,dic[@"ShopMainImg"]];
        NSString *imgS =[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSURL *URL =[NSURL URLWithString:imgS];
        [_LightHeadImageView sd_setImageWithURL:URL];
}
    self.LightNameLable.text =dic[@"ShopName"];
    self.commentNum.text =[NSString stringWithFormat:@"%d",[dic[@"CommentCount"] intValue]];
    self.dianzanNum.text =[NSString stringWithFormat:@"%d",[dic[@"LikedCount"] intValue]];
    NSString *str1 = dic[@"ShopGPS"];
    if([str1 isKindOfClass:[NSNull class]]){
    self.LightdistanceLable.text =[NSString stringWithFormat:@"无法获取距离"];
    }
    else{
        NSArray *array = [dic[@"ShopGPS"] componentsSeparatedByString:@","];
        float latitude = [array[0] floatValue];
        float longitude =[array[1] floatValue];
        
        NSString * str  =[[NSUserDefaults standardUserDefaults]objectForKey:@"LocationAdress"];
        NSArray  *array1 =[str componentsSeparatedByString:@","];
        float latitude1  = [array1[0] floatValue];
        float longitude1 = [array1[1] floatValue];
        CLLocation *current=[[CLLocation alloc] initWithLatitude:longitude1 longitude:latitude1];
        //第二个坐标
        CLLocation *before=[[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        CLLocationDistance meters = [current distanceFromLocation:before];
        if(meters >=1000)
        {
            self.LightdistanceLable.text =[NSString stringWithFormat:@"%.2lf km",meters/1000];
        }
        else
        {
        self.LightdistanceLable.text =[NSString stringWithFormat:@"%d m",(int)meters];
        }
    }
    
    self.LightstoryLable.text =dic[@"ShopStory"];
    if (fag ==1)
    {
        [_LightdianzanBtn setImage:[UIImage imageNamed:@"dianzan1"] forState:UIControlStateNormal];
    }
    else
    {
        
        [_LightdianzanBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    }

    
    if (dic[@"ShopAddr"]==[NSNull null]||dic[@"ShopHours"]==[NSNull null])
    {
        
    }
    else
    {
      self.LightHomeLable.text =dic[@"ShopAddr"];
      self.LightworkTimeLable.text =dic[@"ShopHours"];
    }
    
    
    NSArray *subViews = [self.LightPhotoView subviews];
    for (UIImageView *imageView in subViews) {
        [imageView removeFromSuperview];
    }
    CGFloat width = (self.frame.size.width - 26 - 20) /imageCount;
    arrImage =[NSMutableArray array];
    for (int i=0; i<5; i++){
        int row = i / imageCount;
        int col = i % imageCount;
       UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(col * (width + kSpaceForCol), row * (kSpaceForCol + width), width, width);
        NSString *str =[NSString stringWithFormat:@"ShopImg%d",i+1];
        NSString *imgeStr =[dic objectForKey:str];
        if (![dic[str] isKindOfClass:[NSNull class]]){
            NSString *imageStr =[NSString stringWithFormat:@"%@uploadfiles/%@",URLM,imgeStr];
            NSString *Imgstr =[imageStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            NSURL *imageUrl =[NSURL URLWithString:Imgstr];
            [imgView sd_setImageWithURL:imageUrl];
            [arrImage addObject:imageUrl];
            UITapGestureRecognizer *singleRecongnizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
            imgView.tag =i;
            imgView.userInteractionEnabled =YES;
            singleRecongnizer.numberOfTapsRequired =1;
            singleRecongnizer.numberOfTouchesRequired =1;
            
            
            [imgView addGestureRecognizer:singleRecongnizer];
            
            [self.LightPhotoView addSubview:imgView];
        }
       
        
    
    }
}

-(void)singleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    UIView *viewClicked=[gestureRecognizer view];
    [self.Ddelegaet sendBigImage:arrImage imagetag:(int)viewClicked.tag ];
}
@end
