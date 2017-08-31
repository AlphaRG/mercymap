//
//  CommoneTools.m
//  tiangou
//
//  Created by mac on 14-2-21.
//  Copyright (c) 2014年 kedao. All rights reserved.
//


#import "CommoneTools.h"


@implementation CommoneTools

+ (CommoneTools *) sharedManager
{
    static CommoneTools *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}



//提示
+ (void) alertOnView:(UIView*)view content:(NSString*)content{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:content delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil,nil];
    [alertView show];
//  alertView.backgroundColor = [UIColor redColor];
}


+(float)adHeightWithText:(NSString *)text maxHeight:(float)maxHeight space:(float)space fontSize:(NSInteger)font
{
    CGFloat mainHeight;
  
    CGSize maxSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - space*2, maxHeight);
    NSDictionary *attribute = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
    CGSize textSize = [text boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    mainHeight = textSize.height ;
    
    return mainHeight;
}

@end
