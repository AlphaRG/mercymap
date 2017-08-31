//
//  CommoneTools.h
//  tiangou
//
//  Created by mac on 14-2-21.
//  Copyright (c) 2014年 kedao. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CommoneTools : NSObject

typedef void (^ReloadRequestBlock)(UIView *view);

+ (CommoneTools *) sharedManager;

+ (void) alertOnView:(UIView*)view content:(NSString*)content;

+(float)adHeightWithText:(NSString *)text maxHeight:(float)maxHeight space:(float)space fontSize:(NSInteger)font;

@end
