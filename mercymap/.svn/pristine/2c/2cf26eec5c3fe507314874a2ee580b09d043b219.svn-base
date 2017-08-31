//
//  DataBaseSet.m
//  MercyMap
//
//  Created by sunshaoxun on 16/6/16.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "DataBaseSet.h"

@implementation DataBaseSet

-(NSString *)getDBpath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"data.sqlite"];
    return dbPath;
}

-(void)getDBInfo:(NSString *)sql getInfo:(getDBInfoBlock)getInfo{
    NSFileManager *filemanager =[NSFileManager defaultManager];
    NSString *path  = [self getDBpath];
    if ([filemanager fileExistsAtPath:path]){
        FMDatabase *database =[FMDatabase databaseWithPath:path];
        [database open];
        FMResultSet *result = [database executeQuery:sql];
        if([result next]){
            NSString *success =[result stringForColumn:@"time"];
            [database close];
            getInfo(success);
        }
        else{
            NSString *str =@"failuer";
            [database close];
            getInfo(str);
        }
    }
    else{
        FMDatabase *database =[FMDatabase databaseWithPath:path];
        [database open];
        NSString *sql1 =[NSString stringWithFormat:@"CREATE TABLE dianzan (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,time varchar NOT NULL,name integer NOT NULL);"];
        NSString *sql2 =[NSString stringWithFormat:@"CREATE TABLE signin(id integer PRIMARY KEY AUTOINCREMENT NOT NULL,time varchar NOT NULL,name integer NOT NULL);"];
            BOOL issuccess  =[database executeUpdate:sql1];
            [database executeUpdate:sql2];
            if (issuccess){
                NSString *success =@"DSuccess";
                getInfo(success);
            }
            else{
                NSLog(@"获取数据库失败");
            }
         [database close];
    }
}

-(void)getDBInfo:(NSString *)sql gettimeInfo:(getDBInfoBlock)gettime{
    NSFileManager *filemager =[NSFileManager defaultManager];
    if ([filemager fileExistsAtPath:[self getDBpath]]){
        FMDatabase *database =[FMDatabase databaseWithPath:[self getDBpath]];
        [database open];
        BOOL isSuccess = [database executeUpdate:sql];
        if (isSuccess){
            [database close];
            gettime(@"Success");
      }
      [database close];
     }
}
@end
