//
//  CommentTextTableViewCell.h
//  MercyMap
//
//  Created by RainGu on 16/11/23.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *commentText;
@property (weak, nonatomic) IBOutlet UILabel *signalLable;
@property (weak, nonatomic) IBOutlet UILabel *textNumber;

@end
