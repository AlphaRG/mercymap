//
//  AdviceTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/8/19.
//  Copyright © 2016年 Wispeed. All rights reserved.

#import "AdviceTableViewController.h"
#import "AdviceTableViewCell.h"
#import "ButtonAdd.h"
#import "ZLThumbnailViewController.h"
#import "ZLSelectPhotoModel.h"
#import "ZLShowBigImgViewController.h"
#import "IQKeyboardManager.h"
#import "LoginService.h"
#import "Single.h"
#define imageCount 4
#define kSpaceForCol 10
@interface AdviceTableViewController ()<UITextViewDelegate,sendInfoDelegate,ImageSendDelegate>
{
    AdviceTableViewCell *adviceCell;
    LoginService *SerVice;
    ButtonAdd   *_buttonAdd;
    BOOL   _showDeleteButton;
 }
@end

@implementation AdviceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助与反馈";
    SerVice =[[LoginService alloc]init];
    [self.tableView registerNib:@[@"AdviceTableViewCell"]];
    self.tableView.tableFooterView.backgroundColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(navleftBtnClick)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)navleftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =nil;
    AdviceTableViewCell * advicecell = [tableView dequeueReusableCellWithIdentifier:@"AdviceTableViewCell" forIndexPath:indexPath];
    adviceCell =  advicecell;
    advicecell.delegate = self;
    advicecell.textViewContent.delegate = self;
    advicecell.textViewContent.scrollEnabled = YES;
    advicecell.textViewContent.selectedRange = NSMakeRange(0,0);
    int i= 0;
    CGFloat width = (kSCREENWIDTH - 40 - 3*10) /imageCount;
    UIImageView *limageView;
    for (id view in advicecell.pictureView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    for(UIImage *img in self.lightImgs){
        int row = i / imageCount;
        int col = i % imageCount;
        limageView = [[UIImageView alloc]initWithFrame:CGRectMake(col * (width + kSpaceForCol)+20, row * (kSpaceForCol + width)+50, width, width)];
        limageView.image = img;
        if (_showDeleteButton) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
            btn.bounds = CGRectMake(0, 0, 20, 20);
            btn.center = CGPointMake((kSCREENWIDTH - 40 - 4*10)/4 - 5, 5);
            btn.tag = [self.lightImgs indexOfObject:img];
            [btn setBackgroundImage:[UIImage imageNamed:@"create_deleteImage"] forState:UIControlStateNormal];
            [limageView addSubview:btn];
        }
        [limageView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
        limageView.userInteractionEnabled =YES;
        advicecell.pictureView.userInteractionEnabled  = YES;
        [advicecell.pictureView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)]];
        
        limageView.contentScaleFactor = [[UIScreen mainScreen] scale];
        limageView.contentMode = UIViewContentModeScaleToFill;
        limageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        limageView.clipsToBounds = YES;
//      UITapGestureRecognizer *singleRecongnizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
//      limageView.tag =i;
//      singleRecongnizer.numberOfTapsRequired =1;
//      singleRecongnizer.numberOfTouchesRequired =1;
//      [limageView addGestureRecognizer:singleRecongnizer];
        i++;
        [advicecell.pictureView addSubview:limageView];
    }
    if (self.lightImgs.count<4) {
        advicecell.addimageBtn.hidden = NO;
        CGFloat LW = i%4 *(width +kSpaceForCol)+20;
        advicecell.leftConstraint.constant = LW;
    }
    else{
        advicecell.addimageBtn.hidden = YES;
    }
    advicecell.pictureCount.text =[NSString stringWithFormat:@"%lu/4",(unsigned long)_lightImgs.count];
    cell = advicecell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardDidHideNotification object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

-(void)keyBoardShown:(NSNotification *)notification{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
}

-(void)keyBoardHidden:(NSNotification *)notification{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    adviceCell.textViewPacehoder.hidden =YES;
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
    if (length >200) {
        textView.textColor = [UIColor redColor];
        adviceCell.textViewCount.textColor  = [UIColor redColor];
        adviceCell.textViewCount.text = [NSString stringWithFormat:@"%ld/200",(long)length];
    }
    else{
        textView.textColor = [UIColor blackColor];
        adviceCell.textViewCount.textColor = [UIColor blackColor];
        adviceCell.textViewCount.text = [NSString stringWithFormat:@"%ld/200",(long)length];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    textView.text = [textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([textView.text isEqualToString:@""]) {
        adviceCell.textViewPacehoder.hidden = NO;
        }
    else{
        adviceCell.textViewPacehoder.hidden = YES;
   }
    [self.tableView reloadData];
}

-(void)sendInfo:(int)fag{
    _showDeleteButton = NO;
    if (fag ==1){
       [self sendphotos:nil sendtag:11];
    }
    else{
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
            NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:0];
            Single *single =[Single Send];
            if (_lightImgs.count == 0) {
                imageArray =nil;
            }
            else{
                for ( UIImage *img in _lightImgs) {
                    [imageArray addObject:img];
                }
            }
               NSString *url =[NSString stringWithFormat:@"%@api/Common/FormPictureUpload?Token=%@&UID=%d&FormPlatform=%@&ClientType=%@",URLM,single.Token,single.ID,@100,@10];
                adviceCell.textViewContent.text = [adviceCell.textViewContent.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                if ([adviceCell.textViewContent.text isEqualToString:@""]) {
                    [CommoneTools alertOnView:self.view content:@"你的问题还未填写"];
                }
                else{
                [SerVice sendImageurl:url imageArray:imageArray Token:single.Token success:^(NSArray *successBlock) {
                    NSMutableArray *ImgArray = [NSMutableArray arrayWithCapacity:0];
                    [ImgArray addObjectsFromArray:successBlock];
                    
                    [SerVice sendCommentShopID:45 UID:single.ID ParentID:0 ParentLevel1ID:0  Token:single.Token CommentInfo:adviceCell.textViewContent.text imageArray:ImgArray PublicRole:@0 SuccessBlock:^(NSString *success){
                        } Failuer:^(NSString *error) {
                    }];
                    [self.navigationController popViewControllerAnimated:YES];
                } Failuer:^(NSString *errorBlock) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                }
        }
        else{
             [CommoneTools alertOnView:self.view content:@"请先登录"];
             return;
            }
       }
}

-(void)sendphotos:(NSMutableArray *)ArraySelectphotos sendtag:(int)tag{
    ButtonAdd *btn1 =[[ButtonAdd alloc]init];
    _buttonAdd = btn1;
     ZLThumbnailViewController *VC = [[ZLThumbnailViewController alloc]initWithNibName:@"ZLThumbnailViewController" bundle:nil];
    VC.maxSelectCount = 4;
    [VC setDoneCustomBackBlock:^(NSArray<ZLSelectPhotoModel *> *ZLelectPhotos){
      for (ZLSelectPhotoModel *model in ZLelectPhotos) {
          [self.lightImgs addObject:model.image];
      }
        [self.tableView reloadData];
    }];
    btn1.delegate =self;
    btn1.Imgs =^(UIImage *img){
        [self.lightImgs addObject:img];
        [self.tableView reloadData];
    };
    [btn1 CheckCammer:self andViewVC:VC];
}

-(void)singleTap:(UITapGestureRecognizer *)gestureRecognizer{
//    UIView *ClickView=[gestureRecognizer view];
//    ZLShowBigImgViewController *svc = [[ZLShowBigImgViewController alloc] init];
//    svc.assets         = _dataImgs;
//    svc.arraySelectPhotos = self.lightImgs.mutableCopy;
//    svc.selectIndex    =ClickView.tag;
//    svc.showPopAnimate = NO;
//    svc.shouldReverseAssets = NO;
//    svc.titleName  = @"照片集";
//    [svc setOnSelectedPhotos:^(NSArray<ZLSelectPhotoModel *> *selectedPhotos) {
//        [self.lightImgs removeAllObjects];
//        [self.dataImgs removeAllObjects];
//        for (ZLSelectPhotoModel *model in selectedPhotos) {
//            [self.lightImgs addObject:model];
//            [self.dataImgs addObject:model.asset];
//        }
//        [self.tableView reloadData];
//    }];
//    [self.navigationController pushViewController:svc animated:YES];
    _showDeleteButton = NO;
    [self.tableView reloadData];
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan){
        _showDeleteButton = !_showDeleteButton;
        [self.tableView reloadData];
    }
}
- (void)deleteImage:(UIButton *)button{
    [self.lightImgs removeObjectAtIndex:button.tag];
    [self.tableView reloadData];
}

- (NSMutableArray *)lightImgs{
    if (_lightImgs == nil) {
        _lightImgs = [NSMutableArray arrayWithCapacity:0];
    }
    return _lightImgs;
}

-(NSMutableArray *)dataImgs{
    if (_dataImgs ==nil) {
        _dataImgs =[NSMutableArray arrayWithCapacity:0];
    }
    return _dataImgs;
}
@end
