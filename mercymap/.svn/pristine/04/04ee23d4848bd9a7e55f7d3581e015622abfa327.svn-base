//
//  DBSerVice.h
//  Wispeed
//
//  Created by sunshaoxun on 16/7/25.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^getDBInfoBlock)(NSString *info);

@interface DBSerVice : NSObject

-(NSString *)getDBpath:(NSString *)fileName;
-(void)getDBInfo:(NSString *)sql  getInfo:(getDBInfoBlock)getInfo;
-(void)getDBInfo:(NSString *)sql gettimeInfo:(getDBInfoBlock)gettime;

@end
