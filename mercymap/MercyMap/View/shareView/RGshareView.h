//
//  RGshareView.h
//  MercyMap
//
//  Created by sunshaoxun on 16/9/27.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RGshareView : NSObject
-(void)shareView:(UIViewController *)view Title:(NSString *)title Content:(NSString *)content Image:(NSString *)img;

-(void)selfView:(UIViewController *)selfView destinationView:(NSMutableArray *)destinationView andDataTitle:(NSMutableArray *)datatitle;
@end
