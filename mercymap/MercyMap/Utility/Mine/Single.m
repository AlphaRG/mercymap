//
//  Single.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/18.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "Single.h"

@implementation Single

static Single *s =nil;
+(Single *)Send
{
    if (s ==nil) {
        s = [[Single alloc]init];
    }
    return s;
}
@end
