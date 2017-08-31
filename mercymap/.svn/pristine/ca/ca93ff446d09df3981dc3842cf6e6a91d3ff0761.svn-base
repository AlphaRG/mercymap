//
//  RGshareView.m
//  MercyMap
//
//  Created by sunshaoxun on 16/9/27.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "RGshareView.h"
#import "AdviceTableViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialUIManager.h"
@implementation RGshareView

-(void)shareView:(UIViewController *)view Title:(NSString *)title Content:(NSString *)content Image:(NSString *)img{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMShareMenuSelectionView *shareSelectionView, UMSocialPlatformType platformType) {
        [self shareWebPageToPlatformType:platformType Title:title Content:content Image:img];
    }];
}

//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType Title:(NSString*)title Content:(NSString *)content Image:(NSString *)img{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSString *array = [[content componentsSeparatedByString:@"。"]objectAtIndex:0];
    messageObject.text = array;
    //创建网页内容对象
    UMShareWebpageObject *shareObject;
    if([title isEqualToString:@"乐善地图"]){
      shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:[UIImage imageNamed:@"LOGO120.png"]];
   }else{
     shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img]]]];
    }
    //设置网页地址
    shareObject.webpageUrl =img;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
            [[UMSocialManager defaultManager]cancelAuthWithPlatform:platformType completion:^(id result, NSError *error) {
            }];

        }
    }];
}

-(void)selfView:(UIViewController *)selfView destinationView:(NSMutableArray *)destinationView andDataTitle:(NSMutableArray *)datatitle{
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:@"更多" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"报错" style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * _Nonnull action) {
        AdviceTableViewController *desView = [[AdviceTableViewController alloc]init];
        [selfView.navigationController pushViewController:desView animated:YES];
    }];
    UIAlertAction *canceAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alterController addAction:action];
    [alterController addAction:canceAction];
    [selfView presentViewController:alterController animated:YES completion:nil];
}
//-(int *)stardianzan{
//    int dianfag;
//    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate * date =[NSDate date];
//    NSString * str1 = [formatter stringFromDate:date];
//    if (dianfag ==1) {
//        [CommoneTools alertOnView:self.view content:@"你已经点过"];
//    }
//    else{
//        [SerVice dianzanLightShopID:_ID UID:single.ID Token:single.Token SuccessBlock:^(NSString *success){
//            dianfag=1;
//            NSString *sql =[NSString stringWithFormat:@"insert into dianzan (time,name) values ('%@',%d);",str1,_ID];
//            DataBaseSet *database = [[DataBaseSet alloc]init];
//            [database getDBInfo:sql gettimeInfo:^(NSString *info) {
//                if ([info isEqualToString:@"Success"]) {
//                    NSLog(@"goodjob");
//                }}];
//            [CommoneTools alertOnView:self.view content:success];
//            [self SelfLightList];
//        }
//                            Failuer:^(NSString *error) {
//                                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                                hud.mode = MBProgressHUDModeText;
//                                hud.labelText = @"您的网络不给力!";
//                                [hud hide: YES afterDelay: 2];
//                            }];
//    }
//}
@end
