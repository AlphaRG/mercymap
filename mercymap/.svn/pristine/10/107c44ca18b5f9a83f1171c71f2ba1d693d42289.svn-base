//
//  AppDelegate.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/7.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "BaseHttpRequest.h"
#import "Single.h"
#import "LoginService.h"
#import "MapViewSet.h"
#import "LogViewController.h"
#import "DBSerVice.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <UMMobClick/MobClick.h>
#import <UMSocialCore/UMSocialCore.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()<AMapLocationManagerDelegate>
{
    BaseHttpRequest *firstLogin;
    LoginService *loginService;
    MapViewSet *mapSet;
}

@end

@implementation AppDelegate
- (void)umengTrack {
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"5760be2367e58e334f003e5c";
    [MobClick startWithConfigure:UMConfigInstance];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self umengTrack];
    [MAMapServices sharedServices].apiKey = @"8c136b29c6b5808b60128bf548dff050";
    [AMapSearchServices sharedServices].apiKey = @"8c136b29c6b5808b60128bf548dff050";
    [[IQKeyboardManager sharedManager] setEnable:YES];//控制整个功能是否可用
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;//控制点击背景是否手气键盘
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;//控制键盘上的工具条颜色是否
    
    mapSet =[[MapViewSet alloc]init];
    [mapSet setcity];
    [self getURL];
    [self setLogin];
    [SMSSDK registerApp:appkey withSecret:appsecret];
    [self setUmeng];
    //支付
    [WXApi registerApp:@"wx7a811780f82a006e" withDescription:@"mercymap"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if ([url.host isEqualToString:@"safepay"]){
        [self aliPayCallBack:url];
    }
    if ([url.host isEqualToString:@"pay"]) {
        [self wechatCallBack];
    }
    if (!result) {
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if ([url.host isEqualToString:@"safepay"]){
    }
    if ([url.host isEqualToString:@"pay"]) {
    }
    if (!result) {
    }
    return result;
}

-(void)setLogin{
  if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"newUser"]boolValue]){
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
            Single *sing = [[Single alloc]init];
            sing = [Single Send];
            NSInteger newID =[[NSUserDefaults standardUserDefaults]integerForKey:@"ID"];
            sing.ID =[[NSString stringWithFormat:@"%ld",(long)newID] intValue];
            sing.Token = [[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
            sing.wechaturl = [[NSUserDefaults standardUserDefaults]objectForKey:@"wechaturl"];
            sing.alipayurl = [[NSUserDefaults standardUserDefaults]objectForKey:@"alipayurl"];
         }
        else{
            Single *sing = [Single Send];
            NSInteger newID =[[NSUserDefaults standardUserDefaults]integerForKey:@"ID"];
            sing.ID =[[NSString stringWithFormat:@"%ld",(long)newID]intValue];
        }
    }
    else{
        loginService =[[LoginService alloc]init];
        [loginService firstLogin];
    }
}

-(void)setUmeng{
    //打开日志
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:umengkey];
    //第三方登录与分享
    //设置微信AppId，设置分享url
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx7a811780f82a006e"  appSecret:@"c3b5d877d8299119d27fc864ed1f9102" redirectURL:@"http://mobile.umeng.com/social"];
    //打开新浪微博的SSO开关
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1315388692" appSecret:@"8295e2acb6555ceb8d2c6fa799319d2f" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    //设置领英的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"811i782htjqagm"  appSecret:@"8SaKsmGhYJ3v1INt" redirectURL:@"https://api.linkedin.com/v1/people"];
}

-(void)getURL{
    DBSerVice  *DBService  = [[DBSerVice alloc]init];
    NSString *path  = [DBService getDBpath:@"URL.sqlite"];
    
    NSFileManager *filemanager =[NSFileManager defaultManager];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if ([filemanager fileExistsAtPath:path]) {
        NSString *sql = [NSString stringWithFormat:@"select * from URL"];
        [DBService getDBInfo:sql getInfo:^(NSString *info) {
            if ([info isEqualToString:@"F"]){
                [self getRequestURL];
            }
            else{
                NSDate *date = [formatter dateFromString:info];
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *dCom = [calendar components:NSCalendarUnitDay fromDate:date toDate:[NSDate date] options:0];
                if (dCom.day>0){
                    NSString *sql2 = [NSString stringWithFormat:@"DELETE * FROM table_name"];
                    [DBService getDBInfo:sql2 gettimeInfo:^(NSString *info) {
                    if ([info isEqualToString:@"S"]) {
                            [self getRequestURL];
                      }
                    }];
                }
                else{
                }
            }
        }];
    }
    else{
        NSString *sql =[NSString stringWithFormat:@"CREATE TABLE URL (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,time varchar NOT NULL);"];
        [DBService getDBInfo:sql gettimeInfo:^(NSString *info) {
            if ([info isEqualToString:@"S"]) {
                [self getRequestURL];
            }
        }];
    }
}

-(void)getRequestURL{
    loginService = [[LoginService alloc]init];
    DBSerVice  *DBService  = [[DBSerVice alloc]init];

    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date =[NSDate date];
    NSString * str1 = [formatter stringFromDate:date];
    [loginService getAppURL:@"" SuccessBlock:^(NSMutableDictionary *dic) {
    if ([dic[@"Flag"]isEqualToString:@"S"]){
        for (NSDictionary *urldic in dic[@"ListAppIUrls"]) {
            if ([urldic[@"UrlType"]isEqualToString:@"usercenter"]) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userURL"];
                [[NSUserDefaults standardUserDefaults]setObject:urldic[@"Url"] forKey:@"userURL"];
            }if ([urldic[@"UrlType"]isEqualToString:@"mercymap"]) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"mercymapURL"];
                [[NSUserDefaults standardUserDefaults]setObject:urldic[@"Url"] forKey:@"mercymapURL"];
            }if ([urldic[@"UrlType"]isEqualToString:@"pay"]) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"PayURL"];
                [[NSUserDefaults standardUserDefaults]setObject:urldic[@"Url"] forKey:@"PayURL"];
            }if ([urldic[@"UrlType"]isEqualToString:@"usercenter_img"]) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"imgURL"];
                [[NSUserDefaults standardUserDefaults]setObject:urldic[@"Url"] forKey:@"imgURL"];
            }
        }
    [self setLogin];
    NSString *sql1 = [NSString stringWithFormat:@"insert into URL(time) values ('%@');",str1];
    [DBService getDBInfo:sql1 gettimeInfo:^(NSString *info) {
    }];
    }
    } FailuerBlock:^(NSString *str) {
    }];
}

//获取版本号
-(void)getVersion{
    BaseHttpRequest *serVice  =[[BaseHttpRequest alloc]init];
    NSString *url =[NSString stringWithFormat:@"%@api/Common/MercymapConfig",URLM];
    [serVice sendRequestHttp:url parameters:nil Success:^(NSDictionary *dicData) {
        NSDictionary *dicInfo = [[NSBundle mainBundle]infoDictionary];
        NSString *AppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
        if (![dicData[@"MercyMapConfig"][@"VersionNumber"]isEqualToString:AppVersion]) {
            UILocalNotification *localNoti = [[UILocalNotification alloc]init];
            localNoti.applicationIconBadgeNumber = 1;
            [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
        }
    } Failuer:^(NSString *errorInfo) {
        
    }];
}

//微信支付回调
-(void)wechatCallBack{
  LoginService *_serVice = [[LoginService alloc]init];
   NSString *str = [Single Send].payResult;
   NSDictionary *paydic =@{@"out_trade_no":str,@"appid":@"wx7a811780f82a006e"};
   NSString *url = [NSString stringWithFormat:@"%@api/Pay/OrderQuery?transaction_id={transaction_id}&out_trade_no=%@&appid=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"PayURL"],str,@"wx7a811780f82a006e"];
  NSString *URL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [_serVice getDicData:URL Dic:paydic Title:@"return_info" SuccessBlock:^(NSMutableDictionary *dic) {
            if ([dic[@"trade_state"]isEqualToString:@"NOTPAY"]) {
                [CommoneTools alertOnView:self.window content:@"支付失败"];
            }else{
                [CommoneTools alertOnView:self.window content:@"支付成功"];
            }
        } FailuerBlock:^(NSString *str) {
        }];
}

//支付宝回调
-(void)aliPayCallBack:(NSURL *)url{
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        if ([resultDic[@"resultStatus"]isEqualToString:@"9000"]) {
            [CommoneTools alertOnView:self.window content:@"订单支付成功"];
        }else{
            [CommoneTools alertOnView:self.window content:@"订单支付失败"];
        }
    }];
}
@end
