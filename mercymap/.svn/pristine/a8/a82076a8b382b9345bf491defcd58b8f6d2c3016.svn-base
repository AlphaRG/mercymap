//
//  StarUserFTableViewCell.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/18.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImageDelegate<NSObject>
-(void)HeadImagePicture;
@end

@interface StarUserFTableViewCell : UITableViewCell<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,weak)id<ImageDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *UserNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *UserTextLable;
@property (weak, nonatomic) IBOutlet UILabel *CityName;
-(void)initWithUserFirstCell:(NSString *)url cellName:(NSString *)cellName textName:(NSString *)textName indexpath:(int)code;
@end
