//
//  CreatePhotoTableViewCell.h
//  MercyMap
//
//  Created by sunshaoxun on 16/6/22.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSelectphotoModel.h"
@protocol sendphotosDelegate <NSObject>
-(void)sendphotos:(NSMutableArray *)ArraySelectphotos sendtag:(int)tag;
-(void)sendtextInfo:(NSString *)str;
-(void)sendimages:(NSMutableArray *)imageArray;
@end

@interface CreatePhotoTableViewCell : UITableViewCell<UITextViewDelegate>
{
    UIButton *addimageBtn;
    UITextView *MtextView;
    NSMutableArray *imagedataArray;
    UILabel *textBtn;
    NSString *textStr;
}

@property (weak, nonatomic) IBOutlet UIView *photoView;

@property(nonatomic,weak) id <sendphotosDelegate>delegate;

@property (nonatomic, strong) NSMutableArray<ZLSelectPhotoModel *> *ArrSelectPhotos;

-(void)getcellInfo: (NSMutableArray *) arraySelectPhotos;


@end
