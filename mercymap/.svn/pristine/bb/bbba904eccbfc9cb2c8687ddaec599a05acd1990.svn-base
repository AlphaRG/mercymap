//
//  YMShopCommentUserDetailInfoViewController.m
//  MercyMap
//
//  Created by zhangshupeng on 16/8/25.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "YMShopCommentUserDetailInfoViewController.h"
#import "ShopCommentCell.h"
#import "CommentInputView.h"
#import "IQKeyboardManager.h"
#import "LoginService.h"
#import "MJRefresh.h"
#import "Single.h"
#import "ButtonAdd.h"
#import "ZLThumbnailViewController.h"
#import "ZLSelectPhotoModel.h"
#import "Masonry.h"
#import "ZLShowBigImgViewController.h"
#define IMAGEWIDTH (kSCREENWIDTH-75-15)/4

@interface YMShopCommentUserDetailInfoViewController ()<addImgBtnDelegate>
{
    ShopCommentCell *_cell;
    CommentInputView *__weak _commentView;
    Single *single;
    ButtonAdd *_addImgBtn;
    CGRect _rect;
    int i,contentHeight;
}
@end

@implementation YMShopCommentUserDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    _cell = [self.tableView dequeueReusableCellWithIdentifier:@"ShopCommentCell"];
    CGRect rect = self.tableView.frame;
    self.tableView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height  - 64);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    i = 0;
    single = [Single Send];
    self.tableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self performSelector:@selector(getCommentContent) withObject:self afterDelay:0];
    }];
    self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        i=0;
        [self getCommentContent];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    [self getCommentContent];
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyBoardChange:(NSNotification *)noti {
    if (_commentView.lightImages.count<=4&&_commentView.lightImages.count>=1) {
        contentHeight = 120;
        [_commentView.pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kSCREENWIDTH, 40));
        }];
    }else{
        contentHeight = 80;
        [_commentView.pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kSCREENWIDTH,0));
        }];
    }
    if (_commentView) {
         _rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        _commentView.contentView.frame = CGRectMake(0, _rect.origin.y -contentHeight- 64, kSCREENWIDTH,contentHeight);
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   //根据数据源来计算cell的高度
    CGFloat he ,imgH;
    id data = self.dataArray[indexPath.section][indexPath.row];
//  [_cell configData:data];
//     he = [_cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    CGSize size1 = [data[@"CommentInfo"] calculateSize:CGSizeMake(kSCREENWIDTH - 30, FLT_MAX) font:           [UIFont systemFontOfSize:14]];
    if (![data[@"Img1"]isKindOfClass:[NSNull class]]) {
        imgH = IMAGEWIDTH;
    }else{
        imgH = 0;
    }
    he = size1.height+40+65 +imgH;
    return he;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 20;
    }else{
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0,kSCREENWIDTH, 30.0)];
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    customView.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:247/255.0 alpha:1.0];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:14];
    if (section ==1) {
         headerLabel.text = @"全部评论";
    }
    headerLabel.frame = CGRectMake(10.0, 5.0, 300.0, 20.0);
    [customView addSubview:headerLabel];
    return customView;
}
   
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    ShopCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifyAtIndexPath:indexPath] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.section*10000 + indexPath.row;
    cell.delegate = self;
    dispatch_async(dispatch_get_main_queue(), ^{
    [cell configData:self.dataArray[indexPath.section][indexPath.row]];
    });
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    else{
        cell.backgroundColor =[UIColor colorWithRed:244/255.0 green:245/255.0 blue:247/255.0 alpha:1.0];
    }
    return cell;
}

- (NSString *)cellIdentifyAtIndexPath:(NSIndexPath *)indexPath {
    return @"ShopCommentCell";
}

- (NSArray<NSString *> *)registerCell {
    return @[@"ShopCommentCell"];
}

- (void)cell:(ZZBaseTableViewCell *)cell InteractionEvent:(id)clickInfo {
    NSInteger tag = [clickInfo integerValue];
    if (tag == 1) {
        //点击了头像
    } else if (tag == 2) {
        //点击了名字
    } else if (tag == 3) {
        //点击了评论按钮
        CommentInputView *view = [[CommentInputView alloc]init];
        view.sendText = ^(NSString *text){
        };
        _commentView = view;
        [view showInView:self.view];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentInputView *view = [[CommentInputView alloc]init];
    view.sendText = ^(NSString *text){
        
    int parentID = [self.dataArray [indexPath.section][indexPath.row][@"ID"] intValue];
    LoginService *SerVice = [[LoginService alloc]init];
        [SerVice sendCommentShopID:self.shopID UID:single.ID ParentID:parentID ParentLevel1ID:self.parentID Token:single.Token CommentInfo:text imageArray:nil PublicRole:@0 SuccessBlock:^(NSString *success) {
        i=0;
        [self getCommentContent];
        [self.tableView reloadData];
    } Failuer:^(NSString *error) {
            
        }];
    };
    view.delegate = self;
    _commentView = view;
    [view showInView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)getCommentContent{
    LoginService *SerVice = [[LoginService alloc]init];
    [SerVice GetSelfLightComment:self.shopID  ParentID:self.parentID ParentLevel1ID:1 PageIndex:i pageSize:40 SuccessBlock:^(NSArray *modelArray) {
        if (i==0) {
            [self.dataArray removeAllObjects];
            NSMutableArray *headArray = [NSMutableArray arrayWithCapacity:0];
            [headArray addObject:self.headCommentDic];
            [self.dataArray addObject:headArray];
        }
        i++;
        [self.dataArray addObject:modelArray];
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
@end
