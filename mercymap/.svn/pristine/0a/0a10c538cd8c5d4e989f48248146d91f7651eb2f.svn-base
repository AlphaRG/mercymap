//
//  CommentTableViewController.m
//  MercyMap
//
//  Created by RainGu on 16/11/22.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "CommentTableViewController.h"
#import "CommentTextTableViewCell.h"
#import "CommentImgTableViewCell.h"
#import "ButtonAdd.h"
#import "ZLThumbnailViewController.h"
#import "ZLSelectPhotoModel.h"
#import "Masonry.h"
#import "LoginService.h"
#import "Single.h"
#import "MM_PersonObjectTableViewCell.h"
#import "MM_PersonViewController.h"
#define IMAGEWIDTH (kSCREENWIDTH-40-15)/4
@interface CommentTableViewController ()<ZZBaseTableViewCellDelegate,UITextViewDelegate>
{
    CommentTextTableViewCell *_textcell;
    CommentImgTableViewCell  *_imgcell;
    MM_PersonObjectTableViewCell *_personcell;
    ButtonAdd                *_addImgBtn;
    NSMutableArray           *_lightimgArray;
    LoginService             *_SerVice;
    NSNumber *PublicRole;
    
}
@end

@implementation CommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:@[@"CommentImgTableViewCell",@"MM_PersonObjectTableViewCell"]];
    [self.tableView registerNib:@[@"CommentTextTableViewCell"]];
    self.tableView.tableFooterView.backgroundColor = [UIColor redColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(naveLeftBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(naveRightClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor orangeColor];
    _lightimgArray = [NSMutableArray arrayWithCapacity:0];
    _SerVice = [[LoginService alloc]init];
    PublicRole =@0;
    self.title = @"评论";
}

-(void)naveRightClick{
    [self seninfo];
    
}

-(void)naveLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat heiht ;
    if (indexPath.section == 0) {
        heiht = 200;
    }else if(indexPath.section == 1){
        heiht = IMAGEWIDTH +40;
    }else{
        heiht =44;
    }
    return heiht;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section ==0) {
        CommentTextTableViewCell *textcell = [tableView dequeueReusableCellWithIdentifier:@"CommentTextTableViewCell" forIndexPath:indexPath];
        textcell.commentText.delegate = self;
        cell = textcell ;
        _textcell = textcell;
    }else if(indexPath.section ==1){
        CommentImgTableViewCell *imgcell = [tableView dequeueReusableCellWithIdentifier:@"CommentImgTableViewCell" forIndexPath:indexPath];
        imgcell.delegate = self;
        cell = imgcell;
        _imgcell = imgcell;
    }else{
        MM_PersonObjectTableViewCell *personcell = [tableView dequeueReusableCellWithIdentifier:@"MM_PersonObjectTableViewCell" forIndexPath:indexPath];
        _personcell = personcell;
        personcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [personcell configData:@"@全部"];
        cell = personcell;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==2) {
        MM_PersonViewController *pVC = [[MM_PersonViewController alloc]init];
        pVC.sendPersontag = ^(NSInteger tag){
            switch (tag) {
                case 0:
                    _personcell.personobjectLable.text =@"@全部";
                    PublicRole = @0;
                 break;
                    
                 case 1:
                    _personcell.personobjectLable.text =@"@私密";
                    PublicRole =@20;
                 break;
                 case 2:
                    _personcell.personobjectLable.text =@"@好友";
                    PublicRole=@10;
                 break;
    
                default:
                    break;
            }
        };
        [self.navigationController pushViewController:pVC animated:YES];
    }
}

- (NSInteger)stringLength:(NSString *)str{
    NSUInteger  character = 0;
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){ //判断是否为中文
            character +=1;
        }else{
            character +=1;
        }
    }
    return character;
}

-(void)textViewDidChange:(UITextView *)textView{
  NSInteger length = [self stringLength:textView.text];
    if (length ==0) {
        _textcell.signalLable.hidden = NO;
        _textcell.textNumber.text = @"你还没有评论呢";
    }else{
        _textcell.signalLable.hidden = YES;
        _textcell.textNumber.text= [NSString stringWithFormat:@"加油，已经评论了%ld字",(long)length];
    }
 
}

-(void)cell:(ZZBaseTableViewCell *)cell InteractionEvent:(id)clickInfo{
    NSInteger tag = [clickInfo integerValue];
    switch (tag) {
        case 1:
            [self addImgBtn];
            break;
            
        default:
            break;
    }
}

-(void)sendImgs:(NSMutableArray *)imageArray{
    
}

-(void)addImgBtn{
    ButtonAdd *addImg = [[ButtonAdd alloc]init];
    _addImgBtn = addImg;
    ZLThumbnailViewController *ZLVC = [[ZLThumbnailViewController alloc]initWithNibName:@"ZLThumbnailViewController" bundle:nil];
    ZLThumbnailViewController *__weak _weakZLVC = ZLVC;
    _weakZLVC.maxSelectCount = 4-_lightimgArray.count;
    if (_lightimgArray.count<4) {
        [_weakZLVC setDoneBlock:^(NSArray<ZLSelectPhotoModel *> *ZLelectPhotos) {
        for (ZLSelectPhotoModel *model in ZLelectPhotos){
            [_lightimgArray addObject:model.image];
            [self setlightimg];
            }
        }];
        addImg.Imgs = ^(UIImage *img){
            [_lightimgArray addObject:img];
            [self setlightimg];
        };
        [addImg CheckCammer:self andViewVC:ZLVC];
    }
}

-(void)setlightimg{
    int i=0;
    if (_lightimgArray.count==4) {
        _imgcell.CimageBtn.hidden =YES;
    }
    for (UIImage *image in _lightimgArray) {
        _imgcell.signalLable.hidden = YES;
        UIImageView *CimageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*(IMAGEWIDTH+5)+20,20, IMAGEWIDTH, IMAGEWIDTH)];
        CimageView.image =image;
        CGFloat cwinth = (i+1)*(IMAGEWIDTH+5)+20;
        [_imgcell.CimageBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo (_imgcell).offset(cwinth);
        }];
        [_imgcell addSubview: CimageView];
        i++;
    }
}

-(void)seninfo{
    Single *single =[Single Send];
    NSString *url =[NSString stringWithFormat:@"%@api/Common/FormPictureUpload?UID=%d&token=%@&FormPlatform=100&ClientType=10",URLM,single.ID,single.Token];
    [_SerVice sendImageurl:url imageArray:_lightimgArray Token:single.Token success:^(NSArray *successBlock) {
        NSMutableArray *ImgArray = [NSMutableArray arrayWithCapacity:0];
        [ImgArray addObjectsFromArray:successBlock];
        [_SerVice sendCommentShopID:_shopID UID:single.ID ParentID:0 ParentLevel1ID:0  Token:single.Token CommentInfo:_textcell.commentText.text imageArray:ImgArray PublicRole:PublicRole SuccessBlock:^(NSString *success){
            [self.navigationController popViewControllerAnimated:YES];
        } Failuer:^(NSString *error) {
            [CommoneTools alertOnView:self.view content:error];
        }];
//  [self.navigationController popViewControllerAnimated:YES];
    } Failuer:^(NSString *errorBlock) {
        [CommoneTools alertOnView:self.view content:errorBlock];
    }];
}

@end
