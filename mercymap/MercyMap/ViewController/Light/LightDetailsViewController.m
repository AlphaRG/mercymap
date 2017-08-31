//
//  LightDetailsViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/9/20.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LightDetailsViewController.h"
#import "LoginService.h"
#import "MJRefresh.h"
#import "LightBaseInfoCell.h"
#import "LightAddreCell.h"
#import "LightStoryCell.h"
#import "ShopCommentCell.h"
#import "TabBarView.h"
#import "Single.h"
#import "RGshareView.h"
#import "ZLShowBigImgViewController.h"
#import "MapViewSet.h"
#import "YMShopCommentUserDetailInfoViewController.h"
#import "CommentInputView.h"
#import "LogViewController.h"
#import "IQKeyboardManager.h"
#import "DataBaseSet.h"
#import "MapViewSet.h"
#import "ButtonAdd.h"
#import "ZLThumbnailViewController.h"
#import "ZLSelectPhotoModel.h"
#import "CommentTableViewController.h"
#import "payViewController.h"
#define IMAGEWIDTH (kSCREENWIDTH-75-15)/4

@interface LightDetailsViewController ()<tabBarBtnDelegate,addImgBtnDelegate>
{
    UIButton *_collectionBtn;
    LoginService *_serVice;
    Single *_single;
    int pageNum,i,dianfag,signinfag;
    NSMutableArray *_finallyArray,*_dataA,*_dataB;
    LightBaseInfoCell    *_infoCell;
    LightAddreCell       *_AddreCell;
    LightStoryCell       *_storyCell;
    ShopCommentCell      *_shopCell;
//    MBProgressHUD        *_Hud ;
    TabBarView           *_view;
    NSMutableDictionary  *_dataDic;
    CommentInputView     *__weak  _commentView;
    ButtonAdd            *_addImgBtn;
}
@property (nonatomic) CLLocationCoordinate2D Mapcoordinate;

@end
@implementation LightDetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationView];
    _single = [Single Send];
    self.tableView.frame = CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGTH-64-44);
    _serVice = [[LoginService alloc]init];
    [self.tableView registerClass:@[@"LightBaseInfoCell",@"LightAddreCell",@"LightStoryCell",@"ShopCommentCell"]];
    _storyCell = [self.tableView dequeueReusableCellWithIdentifier:@"LightStoryCell"];
    _shopCell  = [self.tableView dequeueReusableCellWithIdentifier:@"ShopCommentCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name: UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardWillHideNotification object:nil];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    i =0;
    self.tableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self performSelector:@selector(GetComment) withObject:self afterDelay:0];
    }];
    self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            i=0;
            [self getLightInfo];
        });
    }];
    _dataA = [NSMutableArray arrayWithCapacity:0];
    _dataB = [NSMutableArray arrayWithCapacity:0];
    _finallyArray = [NSMutableArray arrayWithCapacity:0];
    _dataDic  = [NSMutableDictionary dictionaryWithCapacity:0];
}

-(void)addNavigationView{
    UIView *rightView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
     _collectionBtn    = [[UIButton alloc]initWithFrame:CGRectMake(40, 0, 30, 30)];
    UIButton *moreBtn  = [[UIButton alloc]initWithFrame:CGRectMake(80, 0, 30, 30)];
    [moreBtn setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    [_collectionBtn setImage:[UIImage imageNamed:@"collection-1"] forState:UIControlStateNormal];
    [_collectionBtn addTarget:self action:@selector(collectionLight) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:@"share-1.png"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareLight) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:_collectionBtn];
    [rightView addSubview:shareBtn];
    [rightView addSubview:moreBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(naveLeftBtnClick)];
}

-(void)naveLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)keyBoardChange:(NSNotification *)notic{
    if (_commentView) {
        CGRect rect = [notic.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        _commentView.contentView.frame = CGRectMake(0, rect.origin.y - 80, kSCREENWIDTH, 80);
    }
}
-(void)keyBoardHide{
//  [_commentView removeFromSuperview];
    _view.hidden = NO;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)getLightInfo{
  [_serVice GetSelfLightInfo:_ID SuccessBlock:^(NSMutableDictionary *dic){
      [self.dataArray removeAllObjects];
      [_dataDic addEntriesFromDictionary:dic];
      [_dataA removeAllObjects];
      [_dataB removeAllObjects];
      [_dataA addObject:dic];
      [_dataB addObject:dic];
      [_dataB addObject:dic];
      [_dataB addObject:dic];
      [_dataB addObject:dic];
      [_dataB addObject:dic];
      
      [self.dataArray addObject:_dataA];
      [self.dataArray addObject:_dataB];
      [self.dataArray addObject:_dataA];
      [self GetComment];
    }
    FailuerBlock:^(NSString *error){
                     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                     hud.mode = MBProgressHUDModeText;
                     hud.labelText = @"您的网络不给力!";
                     [hud hide: YES afterDelay: 2];
                 }];
}

-(void)GetComment{
    [_serVice GetSelfLightComment:_ID ParentID:0 ParentLevel1ID:0 PageIndex:i pageSize:20 SuccessBlock:^(NSArray *modelArray) {
        if (i==0) {
            [_finallyArray removeAllObjects];
        }
        i++;
        if(self.dataArray.count<= 3){
          [_finallyArray addObjectsFromArray:modelArray];
          [self.dataArray addObject:_finallyArray];
        }else{
            [_finallyArray addObjectsFromArray:modelArray];
            [self.dataArray removeLastObject];
            [self.dataArray addObject:_finallyArray];
        }
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
        if (modelArray.count==0){
            [self.tableView.footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    }
    FailuerBlock:^(NSString *error){
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"您的网络不给力!";
                        [hud hide: YES afterDelay: 2];
                    }];
}

-(void)getcollectionINfo{
    [_serVice CollectionInfo:_single.ID FocusType:1 Token:_single.Token PageSize:100 PageIndex:0 SuccesBlock:^(NSArray *modelArray) {
        if ([modelArray isKindOfClass:[NSNull class]]) {
        }
        else{
            for (int a=0 ;a<modelArray.count;a++){
                if ([modelArray[a][@"ShopID"] intValue]==_ID ){
                    [_collectionBtn setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
                    break;
                }
                else{
                    [_collectionBtn setImage:[UIImage imageNamed:@"collection-1"] forState:UIControlStateNormal];
                }
            }}
        
    } FailuerBlock:^(NSString *error) {
    }];
}

-(void)collectionInfo{
    [_serVice CollectionUser:_ID UID:_single.ID FocusType:1 Token:_single.Token SuccessBlock:^(NSString *success) {
        [CommoneTools alertOnView:self.view content:success];
        [_collectionBtn setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
     } Failuer:^(NSString *error) {
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [[IQKeyboardManager sharedManager] setEnable:NO];
    MapViewSet *mapSet =[[MapViewSet alloc]init];
    [mapSet setcity];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
        [self getcollectionINfo];
   }
    _view = [[TabBarView alloc]initWithFrame:CGRectMake(0, kSCREENHEIGTH-44,kSCREENWIDTH,44)];
    _view.delegate = self;
    [self.tabBarController.view addSubview:_view];
    NSString *sql =[NSString stringWithFormat:@"select * from  dianzan  where name = %d",_ID];
    NSString *sql2 =[NSString stringWithFormat:@"select * from signin  where name = %d",_ID];
    [self getDB:sql tag:1];
    [self getDB:sql2 tag:2];
    i=0;
    [self getLightInfo];
}

-(void)viewWillDisappear:(BOOL)animated{
    [_view removeFromSuperview];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if (indexPath.section ==0) {
        height = 90;
    }
    else if (indexPath.section ==1){
        height =44;
    }
    else if(indexPath.section==2){
      id data = self.dataArray[indexPath.section][indexPath.row];
      CGSize size1 = [data[@"ShopStory"] calculateSize:CGSizeMake(kSCREENWIDTH - 30, FLT_MAX) font:           [UIFont systemFontOfSize:14]];
      CGFloat he = size1.height+36+10+70;
       height = he;
    }else{
        CGFloat he ,imgH;
        if (indexPath.section<self.dataArray.count)
        {
            id data = self.dataArray[indexPath.section][indexPath.row];
            CGSize size1 = [data[@"CommentInfo"] calculateSize:CGSizeMake(kSCREENWIDTH - 75, FLT_MAX) font:           [UIFont systemFontOfSize:14]];
            if (![data[@"Img1"]isKindOfClass:[NSNull class]]) {
                imgH = IMAGEWIDTH;
            }else{
                imgH = 0;
            }
            he = size1.height+105 +imgH;
            height = he;
        }
    }
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height ;
    if (section==0) {
        height = 0;
    }else{
        height =10;
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    if (indexPath.section ==0) {
        LightBaseInfoCell *basecell = [tableView dequeueReusableCellWithIdentifier:@"LightBaseInfoCell" forIndexPath:indexPath];
        basecell.delegate =self;
        [basecell configData:self.dataArray[indexPath.section][indexPath.row]];
        cell = basecell;
    }
    else if (indexPath.section ==1){
        LightAddreCell *addrecell = [tableView dequeueReusableCellWithIdentifier:@"LightAddreCell" forIndexPath:indexPath];
        addrecell.delegate =self;
        addrecell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        addrecell.noOryes.hidden = YES;
        if (indexPath.row == 0) {
            [addrecell.cellSepter setHidden:YES];
            [addrecell.addreBtn setImage:[UIImage imageNamed:@"android-pin.png"] forState:UIControlStateNormal];
            addrecell.addreText.text = self.dataArray[indexPath.section][indexPath.row][@"ShopAddr"];
        }
        else if(indexPath.row==1){
             [addrecell.addreBtn setImage:[UIImage imageNamed:@"tel.png"] forState:UIControlStateNormal];
             addrecell.addreText.text = self.dataArray[indexPath.section][indexPath.row][@"ShopMobileNum"];
        }else if(indexPath.row ==2){
            [addrecell.addreBtn setImage:[UIImage imageNamed:@"businesstime.png"] forState:UIControlStateNormal];
            addrecell.addreText.text = self.dataArray[indexPath.section][indexPath.row][@"ShopHours"];
        }else if(indexPath.row == 3){
            [addrecell.addreBtn setImage:[UIImage imageNamed:@"paygray.png"] forState:UIControlStateNormal];
             addrecell.addreText.text = @"支付";
        }else{
            [addrecell.addreBtn setImage:[UIImage imageNamed:@"alipay.png"] forState:UIControlStateNormal];
            addrecell.addreText.text = @"支付宝直接支付";
        }
        cell = addrecell ;
    }
    else if (indexPath.section == 2){
        LightStoryCell *storycell = [tableView dequeueReusableCellWithIdentifier:@"LightStoryCell" forIndexPath:indexPath];
        [storycell configData:self.dataArray[indexPath.section][indexPath.row]];
        storycell.delegate =self;
        cell = storycell;
    }
    else{
         ShopCommentCell *shopcell  =[tableView dequeueReusableCellWithIdentifier:@"ShopCommentCell" forIndexPath:indexPath];
        if (indexPath.section< self.dataArray.count) {
            dispatch_async(dispatch_get_main_queue(), ^{
            [shopcell configData:self.dataArray[indexPath.section][indexPath.row]];
            });
        }
         shopcell.delegate = self;
         cell = shopcell;
        }
      cell.tag = indexPath.section*10000 + indexPath.row;
      [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
      return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1){
        if (indexPath.row == 0) {
            NSString *str =_dataDic[@"ShopGPS"];
            if ([str isKindOfClass:[NSNull class]]) {
                [CommoneTools alertOnView:self.view content:@"无法获取地理坐标"];
            }
            else{
                NSArray *array = [str componentsSeparatedByString:@","];
                float latitude = [array[0] floatValue];
                float longitude =[array[1] floatValue];
                _Mapcoordinate=CLLocationCoordinate2DMake(latitude, longitude);
            }
            MapViewSet *MapView = [[MapViewSet alloc]init];
            [MapView rightBtnClick:_Mapcoordinate view:self fag:2];
        }else if(indexPath.row==1){
            NSString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_dataDic[@"ShopMobileNum"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else if(indexPath.row == 2){
            
        }else if(indexPath.row == 3){
            payViewController *payVC = [[payViewController alloc]init];
            payVC.payName  = _dataDic[@"ShopName"];
            payVC.payImg   = _dataDic[@"ShopMainImg"];
            payVC.payID    = _ID;
            [self.navigationController pushViewController:payVC animated:YES];
        }else{
            NSString *str = [NSString stringWithFormat:@"%@/mercymappay/index?ruid=%d",@"http://www.wispeed.com",[_dataDic[@"UID"] intValue]];
            NSURL *url = [NSURL URLWithString:str];
            if([[UIApplication sharedApplication]canOpenURL:url]){
                [[UIApplication sharedApplication] openURL: url];
            }
        }
    }
    if (indexPath.section == 3) {
        YMShopCommentUserDetailInfoViewController *shop = [[YMShopCommentUserDetailInfoViewController alloc]init];
        if(indexPath.row<_finallyArray.count){
           shop.shopID = _ID;
           shop.parentID = [_finallyArray[indexPath.row][@"ID"] intValue];
           shop.headCommentDic = _finallyArray[indexPath.row];
           [self.navigationController pushViewController:shop animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)getDB:(NSString *)sql tag:(int)tag{
    dispatch_async(dispatch_get_main_queue(), ^{
    DataBaseSet *database = [[DataBaseSet alloc]init];
    [database getDBInfo:sql getInfo:^(NSString *info){
        if ([info isEqualToString:@"failuer"]||[info isEqualToString:@"DSuccess"]){
        }
        else{
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat: @"yyyy-MM-dd"];
            NSDate *Date= [dateFormatter dateFromString:info];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDate *now = [NSDate date];
            unsigned int unitFlags=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
            NSDateComponents *dCom = [calendar components:unitFlags fromDate:Date toDate:now options:0];
            if (dCom.day>0){
                NSString *sql;
                if (tag==1) {
                    sql =[NSString stringWithFormat:@"delete from dianzan where name =%d;",_ID];
                }else{
                    sql = [NSString stringWithFormat:@"delete from signin where name =%d;",_ID];
                }
                [database getDBInfo:sql gettimeInfo:^(NSString *info) {
                    if ([info isEqualToString:@"Success"]){
                        if (tag ==1) {
                            dianfag =0;
                        }else{
                            signinfag = 0;
                        }
                    }
                }];
            }
            else{
                if (tag == 1) {
                    dianfag =1;
                    [_view.dianzanBtn setImage:[UIImage imageNamed:@"dianzan-2"] forState:UIControlStateNormal];
                }else{
                    signinfag  =1;
                    [_view.signinBtn setImage:[UIImage imageNamed:@"signin-1"] forState:UIControlStateNormal];
                }
            }
        }
    }];
    });
}

-(void)stardianzan:(int)fag{
    if (fag==1) {
       if (dianfag ==1) {
          [CommoneTools alertOnView:self.view content:@"你已经点赞了"];
       }
      else{
           [self getinfo:fag];
          }
     }
    else{
           if (signinfag ==1) {
              [CommoneTools alertOnView:self.view content:@"你已经签到了"];
              }
         else{
              [self getinfo:fag];
            }
    }
}

-(void)getinfo:(int)fag{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date =[NSDate date];
    NSString * str1 = [formatter stringFromDate:date];
    if (fag !=1) {
    NSArray *array = [_dataDic[@"ShopGPS"] componentsSeparatedByString:@","];
    float latitude = [array[0] floatValue];
    float longitude =[array[1] floatValue];
    NSString * str  =[[NSUserDefaults standardUserDefaults]objectForKey:@"LocationAdress"];
    NSArray  *array1 =[str componentsSeparatedByString:@","];
    float latitude1  = [array1[0] floatValue];
    float longitude1 = [array1[1] floatValue];
    CLLocation *current=[[CLLocation alloc] initWithLatitude:latitude1 longitude:longitude1];
    //第二个坐标
    CLLocation *before=[[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLLocationDistance meters = [current distanceFromLocation:before];
    if (meters>=500) {
        [CommoneTools alertOnView:self.view content:@"您当前的位置太远"];
        return;
    }}
    [_serVice dianzanLightShopID:_ID UID:_single.ID Token:_single.Token Time:str1 Tag:fag SuccessBlock:^(NSString *success){
        NSString *sql;
        if (fag==1) {
            sql =[NSString stringWithFormat:@"insert into dianzan (time,name) values ('%@',%d);",str1,_ID];
        }else{
            sql =[NSString stringWithFormat:@"insert into signin (time,name) values ('%@',%d);",str1,_ID];
        }
        DataBaseSet *database = [[DataBaseSet alloc]init];
        [database getDBInfo:sql gettimeInfo:^(NSString *info) {
            if ([info isEqualToString:@"Success"]) {
                NSLog(@"goodjob");
            }}];
        if (fag==1) {
            dianfag=1;
            [_view.dianzanBtn setImage:[UIImage imageNamed:@"dianzan-2"] forState:UIControlStateNormal];
        }else{
            signinfag =1;
            [_view.signinBtn setImage:[UIImage imageNamed:@"signin-1"] forState:UIControlStateNormal];
        }
        [self getLightInfo];
      }
     Failuer:^(NSString *error) {
                             MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                             hud.mode = MBProgressHUDModeText;
                             hud.labelText = @"您的网络不给力!";
                             [hud hide: YES afterDelay: 2];
                         }];
}

-(void)tabBarBtnClick:(id)tag{
    NSInteger index = [tag integerValue];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
    switch (index) {
        case 1:
            [self stardianzan:1];
        break;
        case 2:
            [self stardianzan:2];
        break;
        case 3:
//          [self sendComment];
            [self sendCommettwo];
        break;
        case 4:
            [CommoneTools alertOnView:self.view content:@"暂未开放"];
        break;
        default:
        break;
    }
    }else{
        [self alterController];
    }
}

-(void)cell:(ZZBaseTableViewCell *)cell InteractionEvent:(id)clickInfo{
    NSInteger tag = [clickInfo integerValue];
    switch (tag) {
        case 1:
            break;
        case 2:
            [self showBigImg];
        break;
        default:
            
        break;
    }
}

-(void)sendImgs:(NSMutableArray *)imageArray{
    ZLShowBigImgViewController *svc = [[ZLShowBigImgViewController alloc] init];
    svc.imageA = imageArray;
    svc.selectIndex    = 0;
    svc.fag =1;
    svc.maxSelectCount = 5;
    svc.showPopAnimate = NO;
    svc.shouldReverseAssets = NO;
    svc.titleName  = @"照片集";
    [self.navigationController pushViewController:svc animated:YES];
}

-(void)showBigImg{
    NSMutableArray *imgArr = [NSMutableArray arrayWithCapacity:0];
    NSString *str =[NSString stringWithFormat:@"%@/%@",IMGURL,_dataDic[@"ShopMainImg"]];
    NSString *Imgstr =[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *imageUrl =[NSURL URLWithString:Imgstr];
    [imgArr addObject:imageUrl];
    
    for (int y =0; y<5;y++) {
        NSString *str =[NSString stringWithFormat:@"ShopImg%d",y+1];
        NSString *imgeStr =[_dataDic objectForKey:str];
        if (![imgeStr isKindOfClass:[NSNull class]]){
            NSString *imageStr =[NSString stringWithFormat:@"%@/%@",IMGURL,imgeStr];
            NSString *Imgstr =[imageStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            NSURL *imageUrl =[NSURL URLWithString:Imgstr];
            [imgArr addObject:imageUrl];
        }
    }
    ZLShowBigImgViewController *svc = [[ZLShowBigImgViewController alloc] init];
    svc.imageA = imgArr;
    svc.selectIndex    = 0;
    svc.fag =1;
    svc.maxSelectCount = 5;
    svc.showPopAnimate = NO;
    svc.shouldReverseAssets = NO;
    svc.titleName  = @"照片集";
    [self.navigationController pushViewController:svc animated:YES];
}

-(void)collectionLight{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
        [self collectionInfo];
    }else{
        [self alterController];
    }
}

-(void)shareLight{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
    NSString *content = _dataDic[@"ShopStory"];
    NSString *name    = _dataDic[@"ShopName"];
    NSString *imageStr=[NSString stringWithFormat:@"%@/%@",IMGURL,_dataDic[@"ShopImg1"]];
    NSString *Imgstr =[imageStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    RGshareView *view = [[RGshareView alloc]init];
        [view shareView:self Title:name Content:content Image:Imgstr];
    }else{
        [self alterController];
    }
}

-(void)moreClick{
    RGshareView *view2 = [[RGshareView alloc]init];
    NSMutableArray *dataTitle = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *destinationView = [NSMutableArray arrayWithCapacity:0];
    [view2 selfView:self destinationView:destinationView andDataTitle:dataTitle];
}

-(void)sendCommettwo{
    CommentTableViewController *CVC = [[CommentTableViewController alloc]init];
    CVC.shopID = _ID;
    [self.navigationController pushViewController:CVC animated:YES];
}

-(void)sendComment{
    CommentInputView *view = [[CommentInputView alloc]init];
    _view.hidden = YES;
    view.sendText = ^(NSString *text){
        [_serVice sendCommentShopID:_ID UID:_single.ID ParentID:0 ParentLevel1ID:0  Token:_single.Token CommentInfo:text imageArray:nil PublicRole:@0 SuccessBlock:^(NSString *success){
                i=0;
                [self GetComment];
                [self.tableView reloadData];
            } Failuer:^(NSString *error) {
            }];
        };
     view.delegate =self;
    _commentView = view;
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [view showInView:window];
}

-(void)addImgBtn{
    ButtonAdd *addImg = [[ButtonAdd alloc]init];
    _addImgBtn = addImg;
    ZLThumbnailViewController *ZLVC = [[ZLThumbnailViewController alloc]initWithNibName:@"ZLThumbnailViewController" bundle:nil];
    ZLThumbnailViewController *__weak _weakZLVC = ZLVC;
    _weakZLVC.maxSelectCount = 4-_commentView.lightImages.count;
    if (_commentView.lightImages.count<4) {
        [_weakZLVC setDoneBlock:^(NSArray<ZLSelectPhotoModel *> *ZLelectPhotos) {
            for (ZLSelectPhotoModel *model in ZLelectPhotos){
                [_commentView.lightImages addObject:model.image];
            }
        }];
        addImg.Imgs = ^(UIImage *img){
        [_commentView.lightImages addObject:img];
        };
        [addImg CheckCammer:self andViewVC:ZLVC];
    }
}

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

@end