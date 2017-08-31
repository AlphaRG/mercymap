//
//  LightHeadTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/8.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LightHeadTableViewCell.h"
#import "AppDelegate.h"
#import "LightListTableViewController.h"
#import "LightListTableViewCell.h"
#import "LoginService.h"
@implementation LightHeadTableViewCell{
    int page,pageNum;
    NSTimer *timer;
    LoginService *Service;
//  NSMutableArray *dataArray;
    int headID;
    SDCycleScrollView *_cycleScrollView;
    UIScrollView *_demoContainerView;

}

-(void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configData:(NSArray *)data {
    _dataArray = data;
}

-(void)addImageView{
    for (UIView *view in self.pageScrollView.subviews ) {
        [view removeFromSuperview];
    }
    self.pageScrollView.contentSize =CGSizeMake(MainScreen.size.width*_dataArray.count,0);
    self.pageScrollView.maximumZoomScale =4;
    self.pageScrollView.minimumZoomScale=1;
    self.pageScrollView.bounces =NO;
    self.pageScrollView.pagingEnabled =YES;
    self.pageScrollView.delegate=self;
    float windth = MainScreen.size.width;
    for (int i=0; i<_dataArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*windth,0, windth, 200)];
        NSString *imageStr=[NSString stringWithFormat:@"%@uploadfiles/%@",URLM,_dataArray[i][@"ShopMainImg"]];
        NSString *Imgstr =[imageStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
       NSURL *imageUrl =[NSURL URLWithString:Imgstr];
       [imageView sd_setImageWithURL:imageUrl];
        self.introduceLable.text = _dataArray[i][@"ShopStory"];
        [self.pageScrollView addSubview:imageView];
        UITapGestureRecognizer *singleRecongnizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
        singleRecongnizer.numberOfTapsRequired =1;
        singleRecongnizer.numberOfTouchesRequired =1;
        imageView.userInteractionEnabled =YES;
        [imageView addGestureRecognizer:singleRecongnizer];
    }
    page=0;
}
-(void)singleTap{
//  NSInteger b= self.pagePageControl.currentPage;
    headID =[_dataArray[pageNum][@"ID"]intValue];
    [self.delegate singleTaps:headID];
}
-(void)changePage{
    if (page == 3){
        page = 0;
    }
   [self.pageScrollView setContentOffset:CGPointMake([[UIScreen mainScreen]bounds].size.width*page, 0) animated:YES];
    page++;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   int jude=(int)scrollView.contentOffset.x/(int)[UIScreen mainScreen].bounds.size.width;
    if (jude<_dataArray.count){
        pageNum = jude;
        self.introduceLable.text =_dataArray[jude][@"ShopStory"];
     }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];
}

@end
