//
//  MM_CollectionsViewController.m
//  MercyMap
//
//  Created by RainGu on 17/2/17.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import "MM_CollectionsViewController.h"
#import "MM2DbarcodePicture.h"
#import "MM_2DbarcodePictureCell.h"
#import "Single.h"
#import "LoginService.h"
#import "MM_PayWayViewController.h"
@interface MM_CollectionsViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    Single *single;
    NSUInteger _paytag;
    LoginService *_service;
}
@end

@implementation MM_CollectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getscanPicture];
    self.title =@"收钱";
    _service = [[LoginService alloc]init];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(naveLeftBtnClick)];
    [self.tableView registerClass:@[@"MM_2DbarcodePictureCell"]];
    single = [Single Send];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
   self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67/255.0 green:131/255.0 blue:81/255.0 alpha:1.0];
}

-(void)viewWillDisappear:(BOOL)animated{
     self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.6];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSCREENHEIGTH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    MM_2DbarcodePictureCell *scancell = [tableView dequeueReusableCellWithIdentifier:@"MM_2DbarcodePictureCell" forIndexPath:indexPath];
    scancell.delegate = self;
    [scancell configData:self.dataArray[indexPath.row]];
    cell = scancell;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)naveLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getscanPicture{
    NSString *str = [NSString stringWithFormat:@"%@/mercymappay/index?ruid=%d",@"http://www.wispeed.com",_ruid];
    CGFloat  size = kSCREENWIDTH -40;
    UIImage  *scanimage =[MM2DbarcodePicture createQRimageString:str sizeWidth:size fillColor:[UIColor blackColor]];
    NSData   *_data = UIImageJPEGRepresentation(scanimage, 1.0);
    NSString *imagestr  = [_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSArray  *imageA = @[@{@"scanImage":imagestr}];
    [self.dataArray addObject:imageA];
}

-(void)cell:(ZZBaseTableViewCell *)cell InteractionEvent:(id)clickInfo{
    NSInteger tag = [clickInfo integerValue];
    NSArray  *imageA;
    switch (tag) {
        case 1:
            imageA = @[@{@"scanImage":single.wechaturl}];
            [self.dataArray addObject:imageA];
            [self.tableView reloadData];
            break;
        case 2:
            imageA = @[@{@"scanImage":single.alipayurl}];
            [self.dataArray addObject:imageA];
            [self.tableView reloadData];
        break;
            
        case 3:
            [self payWay];
        break;
            
        case 4:
            _paytag = tag;
            [self HeadImagePicture];
        break;
            
        default:
            NSLog(@"%ld",tag);
            break;
    }
}

-(void)payWay{
    MM_PayWayViewController *VC = [[MM_PayWayViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)HeadImagePicture{
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:@"图片选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    BOOL isCamera =[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    UIImagePickerController *imagePicker =[[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing =NO;
    imagePicker.modalTransitionStyle =UIModalTransitionStyleCoverVertical;
    if (isCamera){
        UIAlertAction *CameraAction =[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }];
        UIAlertAction *PhotoAction =[UIAlertAction actionWithTitle:@"从手机里选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         imagePicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
                                         [self presentViewController:imagePicker animated:YES completion:nil];
                                     }];
        
        UIAlertAction *canceAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alterController addAction:CameraAction];
        [alterController addAction:PhotoAction];
        [alterController addAction:canceAction];
        [self presentViewController:alterController animated:YES completion:nil];
    }
    else{
        UIAlertAction *PhotoAction =[UIAlertAction actionWithTitle:@"从手机里选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         imagePicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
                                         [self presentViewController:imagePicker animated:YES completion:nil];
                                     }];
        UIAlertAction *canceAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alterController addAction:PhotoAction];
        [alterController addAction:canceAction];
        [self presentViewController:alterController animated:YES completion:nil];
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage  *image =[info objectForKey:UIImagePickerControllerOriginalImage];
    [self sendCamer:picker Image:image tag:_paytag];
}

-(void)sendCamer:(UIImagePickerController *)picker Image:(UIImage *)image tag:(NSUInteger)tag{
    
    NSDictionary *dic ;
    NSString * str = [MM2DbarcodePicture readQRCodeFromImage:image];
    if (tag==3) {
        dic= @{@"weixinPayer":str};
    }else{
        dic= @{@"alipayer":str};
    }
    NSNumber *uid = [NSNumber numberWithInt:single.ID];
    NSDictionary *lastdic =@{
                             @"_Members":dic,
                             @"Token":single.Token,
                             @"UID":uid,
                             @"FormPlatform":@100,
                             @"ClientType":@10
                             };
    NSString *url = [NSString stringWithFormat:@"%@api/Account/MemberUpdate",USERURL];
    [_service getDicData:url Dic:lastdic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
        [picker dismissViewControllerAnimated:YES completion:nil];
        [CommoneTools alertOnView:self.view content:dic[@"Msg"]];
    } FailuerBlock:^(NSString *str) {
        [picker dismissViewControllerAnimated:YES completion:nil];
        [CommoneTools alertOnView:self.view content:str];
    }];
}
@end
