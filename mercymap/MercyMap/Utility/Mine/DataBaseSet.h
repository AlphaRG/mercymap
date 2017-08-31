//
//  DataBaseSet.h
//  MercyMap
//
//  Created by sunshaoxun on 16/6/16.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^getDBInfoBlock)(NSString *info);

@interface DataBaseSet : NSObject
-(NSString *)getDBpath;
-(void)getDBInfo:(NSString *)sql  getInfo:(getDBInfoBlock)getInfo;
-(void)getDBInfo:(NSString *)sql gettimeInfo:(getDBInfoBlock)gettime;
@end
