//
//  CreateTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/6/21.
//  Copyright © 2016年 Wispeed. All rights reserved.
#import "CreateTableViewController.h"
#import "ZLThumbnailViewController.h"
#import "ZLShowBigImgViewController.h"
#import "CreateInfoTableViewCell.h"
#import "ButtonAdd.h"
#import "Single.h"
#import "LoginService.h"
#import "CreateLightTextCell.h"
#import "CreateLightImageCell.h"
#import "RSKImageCropViewController.h"
#import "SYMDateView.h"
#import "CreateLightTableViewCell.h"
#import "LocationMapViewController.h"
@class  locationMapViewModel;

@interface CreateTableViewController ()<ImageSendDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate,UITextFieldDelegate,UITextViewDelegate,LocationDelegate,AMapSearchDelegate>
{
    CreateInfoTableViewCell *Createinfocell;
    CreateLightTextCell     *TextCell;
    CreateLightImageCell    *Photocell;
    CreateLightTableViewCell *Lightcell,*Lightcell2,*Lightcell3,*Lightcell4,*Lightcell5;
    
    UITextField             *_currentTxtfield;
    UITextView              *_currentTextView;
    BOOL _showDeleteButton,mobilePhoneExist;
    UIImage *_bigImg;
    ButtonAdd *_buttonAdd;
    MAMapView   *mapView;
    NSMutableArray *lightInfoArr ,*_timeArray;
    NSString  *Mlocation;
    AMapSearchAPI *_search;
    CLLocationCoordinate2D _center;
}
@property(nonatomic,strong)NSString *CategoryText;
@property(nonatomic,strong)NSString *ItemsText;
@property(nonatomic,strong)NSString *timeText;
@property(nonatomic,strong)NSString *telephoneText;

@property (nonatomic, strong) NSMutableArray *lightImgs;
@end

@implementation CreateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    photosArray =[[NSMutableArray alloc]initWithCapacity:0];
    _timeArray  =[[NSMutableArray alloc]initWithCapacity:0];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"新增店家信息";
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"LocationAdress"];
    NSArray *array = [str componentsSeparatedByString:@","];
    float latitude = [array[0] floatValue];
    float longitude =[array[1] floatValue];
    _center = CLLocationCoordinate2DMake(latitude, longitude);
    Mlocation = str;
    
    self.edge = ^(NSIndexPath *indexPath){
        if (indexPath.section == 0) {
            return UIEdgeInsetsMake(0, kSCREENWIDTH, 0, 0);
        } else if (indexPath.section == 1&&indexPath.row == 0 ){
            return UIEdgeInsetsMake(0, kSCREENWIDTH, 0, 0);
        }else{
            return UIEdgeInsetsMake(0, 17, 0, 0);
        }
    };
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [self.tableView registerNib:@[@"CreateLightTableViewCell",@"CreateLightImageCell",@"CreateInfoTableViewCell",@"CreateLightTextCell",@"ItemTableViewCell"]];
    [self initNavBtn];
}

- (void)initNavBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 44);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)navRightBtnClick{
    Single  *single =[Single Send];
    LoginService *serVice =[[LoginService alloc]init];
    NSString *url =[NSString stringWithFormat:@"%@api/Common/FormPictureUpload?token=%@",URLM,single.Token];
    ButtonAdd *length = [[ButtonAdd alloc]init];
    if ([length checkInput:Mlocation]){
        [CommoneTools alertOnView:self.view content:@"地理位置未获取"];
    }
    else if([length checkInput:Lightcell.lightInfoTextfield.text]){
         [CommoneTools alertOnView:self.view content:@"店家标题未填写"];
     }
    else if ([length checkInput:Lightcell2.lightInfoTextfield.text]){
        [CommoneTools alertOnView:self.view content:@"地图信息未获取"];
    }
    else if ([length checkInput:Lightcell3.lightInfoTextfield.text]){
        [CommoneTools alertOnView:self.view content:@"店家主题未选择"];
    }
    else if ([length checkInput:Lightcell4.lightInfoTextfield.text]){
        [CommoneTools alertOnView:self.view content:@"店家电话未填写"];
    }
    else if ([length checkInput:Lightcell5.lightInfoTextfield.text]){
        [CommoneTools alertOnView:self.view content:@"时间未选择"];
    }
    else if ([length checkInput:TextCell.textView.text]){
        [CommoneTools alertOnView:self.view content:@"店家详细信息未介绍"];
    }
    else{
        if (mobilePhoneExist) {
            [CommoneTools alertOnView:self.view content:@"手机号存在问题"];
        }
        else{
    [_lightImgs addObject:_bigImg];
    [serVice sendImageurl:url imageArray:_lightImgs Token:single.Token success:^(NSArray *successBlock){
         if (successBlock.count==0){
             [CommoneTools alertOnView:self.view content:@"上传失败"];
         }
         else{
             NSMutableArray *imageDataArray =[[NSMutableArray alloc]init];
             [imageDataArray addObjectsFromArray:successBlock];
             [imageDataArray removeObjectAtIndex:successBlock.count-1];
             [serVice CreateLight:Lightcell.lightInfoTextfield.text ShopCategoryID:_fag ShopMainImg:[successBlock lastObject] ShopAddr:Lightcell2.lightInfoTextfield.text ShopHours:Lightcell5.lightInfoTextfield.text ShopStory:TextCell.textView.text ShopImageArray:imageDataArray Token:single.Token ShopMobileNum:Lightcell4.lightInfoTextfield.text ShopGPS:Mlocation SuccessBlock:^(NSString *success){
                  if ([success isEqualToString:@"S"]){
                      [self.navigationController popToRootViewControllerAnimated:YES];
                  }
                  else{
                      [self.navigationController popToRootViewControllerAnimated:YES];
                  }
            } FailuerBlock:^(NSString *error) {
                  
              }];
            }}
       Failuer:^(NSString *errorBlock){
      }];
    }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage{
    _bigImg = croppedImage;
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sendphotos:(NSMutableArray *)ArraySelectphotos sendtag:(int)tag{
    if (tag == 11||tag == 10) {
    ButtonAdd *btn1 =[[ButtonAdd alloc]init];
    btn1.delegate = self;
    _buttonAdd = btn1;
    ZLThumbnailViewController *VC = [[ZLThumbnailViewController alloc]initWithNibName:@"ZLThumbnailViewController" bundle:nil];
        ZLThumbnailViewController *__weak weakVC = VC;
        if(tag == 10){
            VC.maxSelectCount = 1;
            [VC setDoneCustomBackBlock:^(NSArray<ZLSelectPhotoModel *> *ZLelectPhotos) {
                if (tag == 10) {
                    ZLSelectPhotoModel *model       = [ZLelectPhotos firstObject];
//                    RSKImageCropViewController *rsk = [[RSKImageCropViewController alloc]initWithImage:model.image cropMode:RSKImageCropModeCustom cropSize:CGSizeMake(kSCREENWIDTH, kSCREENWIDTH/2.0)];
//                    rsk.delegate  = self;
//                    NSMutableArray * arr = [NSMutableArray arrayWithArray:weakVC.navigationController.viewControllers];
//                    [arr removeLastObject];
//                    [arr addObject:rsk];
//                    [self.navigationController setViewControllers:arr animated:YES];
                    _bigImg = model.image;
                    [self.tableView reloadData];
                }else{
                    for (ZLSelectPhotoModel *model in ZLelectPhotos) {
                        [self.lightImgs addObject:model.image];
                    }
                    [self.tableView reloadData];
                }
            }];
        }
        else{
            VC.maxSelectCount = 5 - self.lightImgs.count;
            [VC setDoneBlock:^(NSArray<ZLSelectPhotoModel *> *ZLelectPhotos) {
                if (tag == 10) {
                    ZLSelectPhotoModel *model = [ZLelectPhotos firstObject];
                    RSKImageCropViewController *rsk = [[RSKImageCropViewController alloc]initWithImage:model.image cropMode:RSKImageCropModeCustom cropSize:CGSizeMake(kSCREENWIDTH, kSCREENWIDTH/2.0)];
                    rsk.delegate = self;
                    NSMutableArray * arr = [NSMutableArray arrayWithArray:weakVC.navigationController.viewControllers];
                    [arr removeLastObject];
                    [arr addObject:rsk];
                    [self.navigationController setViewControllers:arr animated:YES];
                }else{
                    for (ZLSelectPhotoModel *model in ZLelectPhotos) {
                        [self.lightImgs addObject:model.image];
                    }
                    [self.tableView reloadData];
                }
            }];
        }
        btn1.Imgs = ^(UIImage *img){
            if(tag == 10){
//                RSKImageCropViewController *rsk = [[RSKImageCropViewController alloc]initWithImage:img cropMode:RSKImageCropModeCustom cropSize:CGSizeMake(kSCREENWIDTH, kSCREENWIDTH/2.0)];
//                rsk.delegate = self;
//                [self.navigationController pushViewController:rsk animated:YES];
                _bigImg = img;
                [self.tableView reloadData];
            }
            else{
                [self.lightImgs addObject:img];
                [self.tableView reloadData];
            }
        };
        [btn1 CheckCammer:self andViewVC:VC];
    }
}

-(void)sendimages:(NSMutableArray *)imageArray{
    [photosArray removeAllObjects];
    [photosArray addObjectsFromArray:imageArray];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }
    else if (section==1){
    return 5;
    }
    else
        return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if (indexPath.section==0) {
        height = 115 + (kSCREENWIDTH - 40 - 4*10)/5;
    }
    else if (indexPath.section==1){
        height = 44 ;
    }
    else{
        height = 120;
    }
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

- (IBAction)addBigImage:(id)sender {
    [self sendphotos:nil sendtag:10];
}

- (void)deleteImage:(UIButton *)button{
    [self.lightImgs removeObjectAtIndex:button.tag];
    [self.tableView reloadData];
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan){
        _showDeleteButton = !_showDeleteButton;
        [self.tableView reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =nil;
    if (indexPath.section ==0){
            CreateLightImageCell *photocell =[tableView dequeueReusableCellWithIdentifier:@"CreateLightImageCell"forIndexPath:indexPath];
            if (_bigImg) {
                [photocell.bigImg setImage:_bigImg forState:UIControlStateNormal];
            }
            photocell.gridView.ClickView = ^(NSInteger index){
                if (self.lightImgs.count < 5 && index == self.lightImgs.count) {
                    //添加图片
                    [self sendphotos:nil sendtag:11];
                }
                else{
                    //查看图片
                }
            };
            photocell.gridView.rowCount = 5;
            photocell.gridView.rowElementDistance = 10;
            photocell.gridView.elementSize = CGSizeMake((kSCREENWIDTH - 40 - 4*10)/5, (kSCREENWIDTH - 40 - 4*10)/5);
            NSMutableArray * imgArr = [NSMutableArray arrayWithCapacity:0];
            for (UIImage *img in self.lightImgs) {
                UIView * view = [[UIView alloc]init];
                UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (kSCREENWIDTH - 40 - 4*10)/5, (kSCREENWIDTH - 40 - 4*10)/5)];
                CGFloat scale = ((kSCREENWIDTH - 40 - 4*10)/5)/MIN(img.size.width, img.size.height);
                UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, img.size.width*scale, img.size.height*scale)];
                imgV.center = CGPointMake((kSCREENWIDTH - 40 - 4*10)/10, (kSCREENWIDTH - 40 - 4*10)/10);
                imgV.image = img;
                view2.clipsToBounds = YES;
                [view2 addSubview:imgV];
                [view addSubview:view2];
                if (_showDeleteButton) {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
                    btn.bounds = CGRectMake(0, 0, 20, 20);
                    btn.center = CGPointMake((kSCREENWIDTH - 40 - 4*10)/5 - 5, 5);
                    btn.tag = [self.lightImgs indexOfObject:img];
                    [btn setBackgroundImage:[UIImage imageNamed:@"create_deleteImage"] forState:UIControlStateNormal];
                    [view addSubview:btn];
                }
                [view addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
                [imgArr addObject:view];
            }
            if (self.lightImgs.count < 5 &&self.lightImgs.count>0){
                [imgArr addObject:@"create_addImage.jpg"];
                photocell.tipsLabel.hidden =YES;
            }
            else{
                photocell.tipsLabel.hidden=NO;
                photocell.tipsLabel.text = @"添加图片";
                photocell.tipsLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
                [imgArr addObject:@"create_addImage.jpg"];
            }
            [photocell.gridView addElement:imgArr];
            Photocell = photocell;
            cell = photocell;
    }
   else if (indexPath.section ==1){
        CreateLightTableViewCell *lightcell = [tableView dequeueReusableCellWithIdentifier:@"CreateLightTableViewCell" forIndexPath:indexPath];
        if(indexPath.row == 0){
            [lightcell createCell:@"名称" tag:1];
            Lightcell = lightcell;
        }
        else if (indexPath.row ==1 ){
            [lightcell createCell:@"地址" tag:2];
            Lightcell2 = lightcell;
        }
        else if (indexPath.row ==2 ){
            [lightcell createCell:@"分类" tag:3];
            Lightcell3 = lightcell;
        }
        else if (indexPath.row ==3 ){
            [lightcell createCell:@"手机号" tag:4];
            Lightcell4 = lightcell ;
        }
        else {
             [lightcell createCell:@"营业时间" tag:5];
              Lightcell5 = lightcell;
              Lightcell5.lightInfoTextfield.userInteractionEnabled = NO;
        }
        if (lightcell.lightInfoTextfield.tag == 5) {
        [Lightcell5.lightInfoTextfield addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTimeTextField)]];
                }
        if (lightcell.lightInfoTextfield.tag == 3) {
            [Lightcell3.lightInfoTextfield addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseCategory:)]];
        }
        lightcell.lightInfoTextfield.delegate =self;
        lightcell.delegate =self;
        cell = lightcell;
    }
    else{
            CreateLightTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:@"CreateLightTextCell"forIndexPath:indexPath];
            TextCell =  textCell;
            TextCell.textView.scrollEnabled = YES;
            TextCell.textView.tag =4 ;
            TextCell.textView.delegate  = self;
            cell = textCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row ==4) {
            [self clickTimeTextField];
        }
    }
    if (indexPath.section ==1) {
        if(indexPath.row ==2){
            [self chooseCategory:nil];
        }
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    _currentTextView = textView;
    TextCell.textViewPlaceholder.hidden = YES;
    textView.text = [textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([textView.text isEqualToString:@""]) {
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    _currentTextView = nil;
    textView.text = [textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([textView.text isEqualToString:@""]) {
        TextCell.textViewPlaceholder.hidden = NO;
    }else{
        TextCell.textViewPlaceholder.hidden = YES;
        }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag ==1 ||textField.tag==2||textField.tag==4) {
        if (textField.tag==2) {
        }
    }
    else{
        [textField resignFirstResponder];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 4) {
        NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:textField.text];
        if (!isMatch){
           if([textField.text isEqualToString:@""]){
            mobilePhoneExist = YES;
           }
           else{
           [CommoneTools alertOnView:self.view content:@"您输入的手机号有误"];
            mobilePhoneExist = YES;
          }
        }
    else{
         mobilePhoneExist = NO;
        }
    }
    if (textField.tag ==2) {
        [self searchPlace];
        }
}


-(void)setinfoCell:(CreateInfoTableViewCell *)cell{
    UIButton *textBtn =[[UIButton alloc]init];
    textBtn.frame =cell.CategoryTextfield.frame;
    [textBtn addTarget:self action:@selector(chooseCategory:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:textBtn];
}


-(void)chooseCategory:(UIGestureRecognizer *)gesture{
    UIAlertController *alterC =[UIAlertController alertControllerWithTitle:@"类别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction  *zhuaction =[UIAlertAction actionWithTitle:@"主食" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Lightcell3.lightInfoTextfield.text = @"主食";
        _fag =2;
    }];
    UIAlertAction *xiaochiA =[UIAlertAction actionWithTitle:@"小吃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         Lightcell3.lightInfoTextfield.text =@"小吃";
         _fag=3;
    }];
    UIAlertAction *tianA =[UIAlertAction actionWithTitle:@"甜点" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    Lightcell3.lightInfoTextfield.text =@"甜点";
    _fag=1;
    }];
    UIAlertAction *qitaA =[UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Lightcell3.lightInfoTextfield.text =@"其他";
       _fag=4;
    }];
    [alterC addAction:zhuaction];
    [alterC addAction:xiaochiA];
    [alterC addAction:tianA];
    [alterC addAction:qitaA];
    [self presentViewController:alterC animated:YES completion:nil];
}

- (void)clickTimeTextField{
    [Lightcell5.lightInfoTextfield resignFirstResponder];
    SYMDateView *dateView = [[SYMDateView alloc]init];
    dateView.workTime = ^(NSDictionary *time){
    NSString *amHour,*amMin,*pmHour,*pmMin;
    if ([time[@"amhour"] integerValue]<10){
        amHour =[NSString stringWithFormat:@"0%@",time[@"amhour"]];
        [_timeArray addObject:time[@"amhour"]];
     }
    else{
            amHour = time[@"amhour"];
         [_timeArray addObject:time[@"amhour"]];
       }
    if ([time[@"pmhour"] integerValue]<10){
            pmHour =[NSString stringWithFormat:@"0%@",time[@"pmhour"]];
           [_timeArray addObject:time[@"pmhour"]];
        }
    else{
            pmHour = time[@"pmhour"];
        [_timeArray addObject:time[@"pmhour"]];

        }
    if ([time[@"ammin"] integerValue]<10){
            amMin =[NSString stringWithFormat:@"0%@",time[@"ammin"]];
           [_timeArray addObject:time[@"ammin"]];

        }
    else{
            amMin = time[@"ammin"];
        [_timeArray addObject:time[@"ammin"]];

        }
    if ([time[@"pmmin"] integerValue]<10){
        pmMin =[NSString stringWithFormat:@"0%@",time[@"pmmin"]];
        [_timeArray addObject:time[@"pmmin"]];

        }
    else{
            pmMin = time[@"pmmin"];
        [_timeArray addObject:time[@"pmmin"]];

        }
        if (Lightcell5.lightInfoTextfield.tag == 5) {
             Lightcell5.lightInfoTextfield.text = [NSString stringWithFormat:@"%@:%@--%@:%@",amHour,amMin,pmHour,pmMin];
        }
    };
    [dateView show:_timeArray];
    [_timeArray removeAllObjects];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    self.tableView.contentInset = UIEdgeInsetsZero;
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
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
    if (!CGRectContainsPoint(aRect, _currentTextView.superview.frame.origin) ) {
        CGRect rect = _currentTextView.superview.frame;
        rect.origin.y = TextCell.frame.origin.y;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView scrollRectToVisible:rect animated:YES];
        });
     }
}

-(void)keyBoardHidden:(NSNotification *)notification{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}

-(void)sendLocationView{
    LocationMapViewController *lVC = [[LocationMapViewController alloc]initWithNibName:@"LocationMapViewController" bundle:nil];
    lVC.sendAdres =^(locationMapViewModel *model){
        Lightcell2.lightInfoTextfield.text = model.locationText;
        Mlocation = model.Molocation;
    };
    lVC.center = _center;
    [self.navigationController pushViewController:lVC animated:YES];
}

- (NSMutableArray *)lightImgs{
    if (_lightImgs == nil) {
        _lightImgs = [NSMutableArray arrayWithCapacity:0];
    }
    return _lightImgs;
}

-(void)searchPlace{
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    //构造AMapGeocodeSearchRequest对象，address为必选项，city为可选项
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords =Lightcell2.lightInfoTextfield.text;
    
    NSString *str =[[NSUserDefaults standardUserDefaults]objectForKey:@"CityName"];
    if (str==nil){
        NSString *Lstr =[[NSUserDefaults standardUserDefaults]objectForKey:@"LocationCityName"];
        request.city = Lstr;
    }
    else{
        request.city = str;
    }
    //关键字搜索
    [_search AMapPOIKeywordsSearch: request];
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if(response.pois.count == 0){
        [CommoneTools alertOnView:self.view content:@"请选择正确的地址"];
        return;
    }
    AMapPOI *p =[response.pois firstObject];
    Mlocation = [NSString stringWithFormat:@"%f,%f",p.location.latitude,p.location.longitude];
    _center = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _showDeleteButton = NO;
}
@end
