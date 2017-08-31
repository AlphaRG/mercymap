//
//  CreateTableViewController.h
//  MercyMap
//
//  Created by sunshaoxun on 16/6/21.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSelectPhotoModel.h"
@interface CreateTableViewController : UITableViewController
{
    NSMutableArray *photosArray;
    NSString *storyText;
    
}
//@property (nonatomic, strong) NSMutableArray<ZLSelectPhotoModel *> *arraySelectPhotos;

@property(nonatomic,assign)int fag;

@end
