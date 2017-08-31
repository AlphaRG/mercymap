//
//  StarUserFTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/18.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "StarUserFTableViewCell.h"

@implementation StarUserFTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
         
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

-(void)initWithUserFirstCell:(NSString *)url cellName:(NSString *)cellName textName:(NSString *)textName  indexpath:(int)code
{
    self.UserNameLable.text = [NSString stringWithFormat:@"%@",cellName];
    if (code ==0){
        self.headImageView.hidden =YES;
        self.UserTextLable.hidden =NO;
         _CityName.hidden =YES;
        if (textName ==nil||[textName isKindOfClass:[NSNull class]]){
            self.UserTextLable.hidden =YES;
        }
        else
        {
            self.UserTextLable.hidden = NO;
            self.UserTextLable.text =textName;
            CGSize cellNameSize = [textName calculateSize:CGSizeMake(self.bounds.size.width - 100, FLT_MAX) font:[UIFont systemFontOfSize:14]];
            [self.UserTextLable setFrame:CGRectMake(204, 19,cellNameSize.width, cellNameSize.height)];
        }
        self.UserTextLable.textAlignment =NSTextAlignmentRight;
    }
 else if(code==1){
        self.headImageView.hidden =NO;
        self.UserTextLable.hidden =YES;
        _CityName.hidden =YES;
        if ([textName isKindOfClass:[NSNull class]]) {
            _headImageView.image =[UIImage imageNamed:@"youke.jpg"];
        }
        else{
            NSString *Imgstr;
            if([textName rangeOfString:@"http"].length>0)  {
                Imgstr= [textName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            }else{
                NSString *str = [NSString stringWithFormat:@"%@/%@",IMGURL,textName];
                Imgstr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            }
            NSURL *imageURL = [NSURL URLWithString:Imgstr];
            [_headImageView sd_setImageWithURL:imageURL];
        }

        UITapGestureRecognizer *tapGest =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(send)];
        tapGest.numberOfTapsRequired=1;
        tapGest.numberOfTouchesRequired =1;
        _headImageView.userInteractionEnabled =YES;
        [_headImageView addGestureRecognizer:tapGest];
        
    }
   else{
       
       if ([textName boolValue]==true){
           self.headImageView.hidden =YES;
            _CityName.hidden =YES;
           self.UserTextLable.text =[NSString stringWithFormat:@"%@",@"男"];
           self.UserTextLable.textAlignment =NSTextAlignmentRight;
       }
       else
       {
           self.headImageView.hidden =YES;
            _CityName.hidden =YES;
           self.UserTextLable.text =[NSString stringWithFormat:@"%@",@"女"];
           self.UserTextLable.textAlignment =NSTextAlignmentRight;

}
   }
    
}

-(void)send
{
    [self.delegate HeadImagePicture];
}
@end
