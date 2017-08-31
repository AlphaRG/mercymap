//
//  LightListTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/11.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LightListTableViewController.h"
#import "AppDelegate.h"
#import "LoginService.h"
#import "LightListKindTableViewCell.h"
#import "LightListInfoTableViewCell.h"
#import "LightListSecondTableViewCell.h"
#import "Single.h"
#import "MJRefresh.h"
#import "StarTableViewController.h"
#import "LogViewController.h"
#import "MapViewSet.h"
#import "DataBaseSet.h"
#import "ZLShowBigImgViewController.h"
#import "UIButton+WebCache.h"
#import "YMShopCommentUserDetailInfoViewController.h"
#import "CommentInputView.h"
#import "IQKeyboardManager.h"
#import "UMSocialUIManager.h"
#import <UMSocialCore/UMSocialCore.h>
@interface LightListTableViewController ()<dianzanDelegate,UITextViewDelegate>
{
    LoginService *SerVice;
    Single *single;
    
    int pageNum,i,dianfag,Fag;
    NSMutableArray *finallyArray;
    NSMutableDictionary *dataDic;
    CommentInputView *__weak _commentView;

}
@property(nonatomic,strong)LightListInfoTableViewCell *listInfoCell;
@property (nonatomic) CLLocationCoordinate2D Mapcoordinate;

@end

@implementation LightListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"店家资讯";
    SerVice =[[LoginService alloc]init];
    single = [Single Send];
    finallyArray=[[NSMutableArray alloc]initWithCapacity:0];
    dataDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    i=0;
    dianfag =0;
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //刷新数据
    self.tableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self performSelector:@selector(GetComment) withObject:self afterDelay:0];
    }];
    self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            i=0;
            [self performSelector:@selector(GetComment) withObject:self afterDelay:0];
            [self SelfLightList];
        }];
    self.tableView.footer.hidden =YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;

}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)keyBoardChange:(NSNotification *)noti {
    if (_commentView) {
        CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        _commentView.contentView.frame = CGRectMake(0, rect.origin.y - 80 - 64, kSCREENWIDTH, 80);
    }
}

-(void)sendDianzanDelegaet:(int)fag{
    MapViewSet *MapView =[[MapViewSet alloc]init];
    if (fag ==2){
        NSString *str =dataDic[@"ShopGPS"];
        if ([str isKindOfClass:[NSNull class]]) {
            [CommoneTools alertOnView:self.view content:@"无法获取地理坐标"];
            fag=0;
        }
        else{
        NSArray *array = [str componentsSeparatedByString:@","];
        float latitude = [array[0] floatValue];
        float longitude =[array[1] floatValue];
        _Mapcoordinate=CLLocationCoordinate2DMake(latitude, longitude);
        }
    }
    NSString *content = dataDic[@"ShopStory"];
    NSString *imageStr=[NSString stringWithFormat:@"%@uploadfiles/%@",URLM,dataDic[@"ShopImg1"]];
    NSString *Imgstr =[imageStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];

    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
        switch (fag) {
            case 1:
                [self stardianzan];
                break;
            case 2:
                [MapView rightBtnClick:_Mapcoordinate view:self fag:2];
                break;
            case 3:
                [self shareView:self Title:nil Content:content Image:Imgstr];
                break;
            case 4:
                [self sendComment];
                break;
            case 5:
                [self collectionInfo];
                break;
            default:
                break;
        }
    }
    else{
        if (fag==2){
            [MapView rightBtnClick:_Mapcoordinate view:self fag:2];
        }
        else{
          [self alterController];
        }
    }

}

-(void)sendComment{
    CommentInputView *view = [[CommentInputView alloc]init];
    view.sendText = ^(NSString *text){
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
            [SerVice sendCommentShopID:_ID UID:single.ID ParentID:0 ParentLevel1ID:0  Token:single.Token CommentInfo:text imageArray:nil PublicRole:@0 SuccessBlock:^(NSString *success){
                 i=0;
                 [self GetComment];
                 [self.tableView reloadData];
             } Failuer:^(NSString *error) {
            }];
        }
        else{
            [self alterController];
        }
    };
    _commentView = view;
    [view showInView:self.view];
}

-(void)getcollectionINfo{
    [SerVice CollectionInfo:single.ID FocusType:1 Token:single.Token PageSize:100 PageIndex:0 SuccesBlock:^(NSArray *modelArray) {
        if ([modelArray isKindOfClass:[NSNull class]]) {
        }
        else{
    for (int a=0 ;a<modelArray.count;a++){
        if ([modelArray[a][@"ShopID"] intValue]==_ID ){
             [_listInfoCell.shoucangBtn setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
                break;}
        else{
            [_listInfoCell.shoucangBtn setImage:[UIImage imageNamed:@"收藏1.png"] forState:UIControlStateNormal];
        }
     }}
        
    } FailuerBlock:^(NSString *error) {
    }];
}

-(void)collectionInfo{
    [self.listInfoCell.shoucangBtn setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
    [SerVice CollectionUser:_ID UID:single.ID FocusType:1 Token:single.Token SuccessBlock:^(NSString *success) {
        [CommoneTools alertOnView:self.view content:success];
    } Failuer:^(NSString *error) {
    }];
}

-(void)sendBigImage:(NSMutableArray<NSURL *> *)imagesArray imagetag:(int)tag{
    ZLShowBigImgViewController *svc = [[ZLShowBigImgViewController alloc] init];
    svc.imageA =imagesArray;
    svc.selectIndex    = tag;
    svc.fag =1;
    svc.maxSelectCount = 5;
    svc.showPopAnimate = NO;
    svc.shouldReverseAssets = NO;
    svc.titleName  = @"照片集";
    [self.navigationController pushViewController:svc animated:YES];
}

-(void)stardianzan{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date =[NSDate date];
    if (dianfag ==1) {
        [CommoneTools alertOnView:self.view content:@"你已经点过"];
    }
    else{
//    [SerVice dianzanLightShopID:_ID UID:single.ID Token:single.Token SuccessBlock:^(NSString *success){
//         dianfag=1;
//         NSString *sql =[NSString stringWithFormat:@"insert into dianzan (time,name) values ('%@',%d);",str1,_ID];
//         DataBaseSet *database = [[DataBaseSet alloc]init];
//         [database getDBInfo:sql gettimeInfo:^(NSString *info) {
//             if ([info isEqualToString:@"Success"]) {
//                 NSLog(@"goodjob");
//                }}];
//       [CommoneTools alertOnView:self.view content:success];
//       [self SelfLightList];
//    }
//    Failuer:^(NSString *error) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"您的网络不给力!";
//        [hud hide: YES afterDelay: 2];
//        }];
//    }
    }
}
-(void)shareView:(UIViewController *)view Title:(NSString *)title Content:(NSString *)content Image:(NSString *)img{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMShareMenuSelectionView *shareSelectionView, UMSocialPlatformType platformType) {
        [self shareWebPageToPlatformType:platformType Title:title Content:content Image:img];
    }];

}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType Title:(NSString*)title Content:(NSString *)content Image:(NSString *)img{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img]]]];
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
        }
    }];
}

//-(void)getTag:(int)tag View:(UIViewController *)view Title:(NSString *)title Content:(NSString *)content Image:(NSString *)img{
//          switch (tag) {
//         case 1:
//        // self shareWithTitle:nil content:dataDic[@"ShopStory"] image:dataDic[@"ShopImg1"] andWebUrl:@"http://baidu.com" viewController:<#(UIViewController *)#> type:<#(NSString *)#>
//            break;
//        case 2:
//            
//            [self shareWithTitle:title content:content image:img andWebUrl:@"http://baidu.com" viewController:view type:UMShareToWechatTimeline ];
//
//            break;
//            
//         case 3:
//               [self shareWithTitle:title content:content image:img andWebUrl:@"http://baidu.com" viewController:view type:UMShareToWechatSession];
//            break;
//            
//        default:
//            break;
//    }
//}


//-(void)shareWithTitle:(NSString *)title content:(NSString *)content image:(id)image andWebUrl:(NSString *)url viewController:(UIViewController *)vc type:(NSString *)type{
//    id img ,urlResource;
//    if ([image isKindOfClass:[NSString class]]) {
//        UMSocialUrlResource * resource = [[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeImage url:image];
//        urlResource = resource;
//    }else{
//        img = image;
//    }
//    if ([type isEqualToString:UMShareToWechatSession]) {
//        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
//        [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
//        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
//        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:content image:img location:nil urlResource:urlResource presentedController:vc completion:^(UMSocialResponseEntity *response){
//            if (response.responseCode == UMSResponseCodeSuccess) {
//                NSLog(@"分享成功！");
//            }
//        }];
//    }
//    else if ([type isEqualToString:UMShareToWechatTimeline]){
//        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
//        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
//        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
//        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:content image:img location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
//            if (response.responseCode == UMSResponseCodeSuccess) {
//                NSLog(@"分享成功！");
//                
//            }
//        }];
//    }
//    else if ([type isEqualToString:UMShareToSina]){
//        [[UMSocialControllerService defaultControllerService] setShareText:[NSString stringWithFormat:@"%@%@ %@",title,url,content] shareImage:img socialUIDelegate:vc];
//        //设置分享内容和回调对象
//        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(vc,[UMSocialControllerService defaultControllerService],YES);
//        
//    }else if ([type isEqualToString:UMShareToQQ]){
//        
//        [UMSocialData defaultData].extConfig.qqData.url = url;
//        [UMSocialData defaultData].extConfig.qqData.title = title;
//        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:content image:img location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
//            if (response.responseCode == UMSResponseCodeSuccess) {
//                NSLog(@"分享成功！");
//                
//            }
//        }];
//    }
//    
//}

-(void)alterController{
    UIAlertController *alterController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请到用户认证登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    LogViewController *logVC =[[LogViewController alloc]initWithNibName:@"LogViewController" bundle:nil];
    [logVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:logVC animated:YES];
    }];
    [alterController addAction:OK];
    [self presentViewController:alterController animated:YES completion:nil];
}

-(void)SelfLightList{
   [SerVice GetSelfLightInfo:_ID SuccessBlock:^(NSMutableDictionary *dic){
    [dataDic addEntriesFromDictionary:dic];
    [self.tableView reloadData];
    }
  FailuerBlock:^(NSString *error){
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      hud.mode = MBProgressHUDModeText;
      hud.labelText = @"您的网络不给力!";
      [hud hide: YES afterDelay: 2];
   }];
}

-(void)GetComment{
    [SerVice GetSelfLightComment:_ID ParentID:0 ParentLevel1ID:0 PageIndex:i pageSize:20 SuccessBlock:^(NSArray *modelArray) {
         if (i==0) {
             [finallyArray removeAllObjects];
          }
         i++;
         [finallyArray addObjectsFromArray:modelArray];
         [self.tableView reloadData];
         [self.tableView.footer endRefreshing];
         [self.tableView.header endRefreshing];
         if (modelArray.count==0){
             [self.tableView.footer endRefreshingWithNoMoreData];
         }
    }
    FailuerBlock:^(NSString *error){
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         hud.mode = MBProgressHUDModeText;
         hud.labelText = @"您的网络不给力!";
         [hud hide: YES afterDelay: 2];
    }];
}

-(void)getDB:(NSString *)sql{
    DataBaseSet *database = [[DataBaseSet alloc]init];
    [database getDBInfo:sql getInfo:^(NSString *info){
        if ([info isEqualToString:@"failuer"]||[info isEqualToString:@"DSuccess"]){
        }
        else{
             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            NSDate *Date= [dateFormatter dateFromString:info];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *dCom = [calendar components:NSCalendarUnitDay fromDate:Date toDate:[NSDate date] options:0];
           if (dCom.day>0){
           NSString *sql =[NSString stringWithFormat:@"delete from dianzan where name = %d",_ID];
           [database getDBInfo:sql gettimeInfo:^(NSString *info) {
           if ([info isEqualToString:@"Success"]){
                   dianfag =0;
               }
               }];
            }
           else{
                dianfag =1;
            }
        }
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[IQKeyboardManager sharedManager]setEnable:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    NSString *sql =[NSString stringWithFormat:@"select * from dianzan  where name = %d",_ID];
    [self SelfLightList];
    [self GetComment];
    [self getDB:sql];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]) {
    [self getcollectionINfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUInteger rowNumber =0;
    if (section==0){
        rowNumber = 1;
    }
   else{
       rowNumber =finallyArray.count;
   }
    return rowNumber;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat contentHight=0.0f;
    CGFloat imageHight=0.0f;
    CGFloat otherHight=0.0f;
    NSInteger Cellheight =0;
    NSString *str =dataDic[@"ShopStory"];
    CGSize size = [str calculateSize:CGSizeMake(self.view.frame.size.width-10, FLT_MAX) font:[UIFont systemFontOfSize:14]];
    contentHight = size.height;
    CGFloat width = (self.view.frame.size.width-10- 30) / 5.0;
    imageHight = width;
    otherHight =150+100+20+50+30+30;
    if(indexPath.section==0){
        Cellheight =contentHight+imageHight+otherHight;
    }
    if (indexPath.section==1){
        if (![finallyArray[indexPath.row][@"CommentInfo"] isKindOfClass:[NSNull class]]){
            NSString *str =finallyArray[indexPath.row][@"CommentInfo"];
            CGSize size1 = [str calculateSize:CGSizeMake(kSCREENWIDTH - 82, FLT_MAX) font:[UIFont systemFontOfSize:14]];
            Cellheight = size1.height+60;
        }else{
            Cellheight = 60;
        }
    }
    return Cellheight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell =nil;
     if(indexPath.section==0){
      self.listInfoCell=[tableView dequeueReusableCellWithIdentifier:@"ListInfo" forIndexPath:indexPath];
      [_listInfoCell setCellInfo:dataDic fag:dianfag Collectionfag:Fag];
      _listInfoCell.Ddelegaet =self;
       cell = self.listInfoCell;
     }
    else{
         NSDictionary * comments = finallyArray[indexPath.row];
         LightListSecondTableViewCell *secondCell =[tableView dequeueReusableCellWithIdentifier:@"SecondLight" forIndexPath:indexPath];
         self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
         if (![comments[@"CommentInfo"] isKindOfClass:[NSNull class]]){
             secondCell.StarcommentLable.text =comments[@"CommentInfo"];
             secondCell.StarNameLable.text = comments[@"NickName"];
             NSString *imageStr =[NSString stringWithFormat:@"%@",comments[@"HeadImg"]];
             NSString *Imgstr =[imageStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            NSURL *imageUrl =[NSURL URLWithString:Imgstr];
            [secondCell.HeadBtn sd_setBackgroundImageWithURL:imageUrl forState:UIControlStateNormal placeholderImage:nil];
             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
             [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
             NSDate *Date= [dateFormatter dateFromString:comments[@"CommentTIme"]];
             NSCalendar *calendar = [NSCalendar currentCalendar];
             NSDateComponents *dCom = [calendar components:NSCalendarUnitDay fromDate:Date toDate:[NSDate date] options:0];
             if (dCom.day ==0){
                 secondCell.timeLable.text=@"今天";
             }
             else if (dCom.day==1){
                 secondCell.timeLable.text =@"昨天";
             }
             else{
                 NSArray *array = [comments[@"CommentTIme"] componentsSeparatedByString:@" "];
                 secondCell.timeLable.text=[NSString stringWithFormat:@"%@",array[0]];
             }
         }
         cell =secondCell;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YMShopCommentUserDetailInfoViewController *shop = [[YMShopCommentUserDetailInfoViewController alloc]init];
    shop.shopID = _ID;
    shop.parentID = [finallyArray[indexPath.row][@"ID"] intValue];
    shop.headCommentDic = finallyArray[indexPath.row];
    [self.navigationController pushViewController:shop animated:YES];
}
@end
