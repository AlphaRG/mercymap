//
//  MM_PayWayViewController.m
//  MercyMap
//
//  Created by RainGu on 17/3/7.
//  Copyright © 2017年 Wispeed. All rights reserved.

#import "MM_PayWayViewController.h"
#import "LightAddreCell.h"
#import "MM2DbarcodePicture.h"
#import "LoginService.h"
#import "Single.h"
@interface MM_PayWayViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    NSUInteger _paytag;
    LoginService *_servince;
    Single       *single;
    LightAddreCell *_addrecell;
}
@end

@implementation MM_PayWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"支付方式";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]style:UIBarButtonItemStylePlain target:self action:@selector(navleftBtnClick)];
    [self.tableView registerClass:@[@"LightAddreCell"]];
    single = [Single Send];
    NSArray *array = @[@{@"title":@"微信二维码图片",@"image":@"wechat",@"fag":single.wechaturl},
                       @{@"title":@"支付宝二维码图片",@"image":@"alipay",@"fag":single.alipayurl}];
    [self.dataArray addObject:array];
    _servince = [[LoginService alloc]init];
}

-(void)navleftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    LightAddreCell *addrecell = [tableView dequeueReusableCellWithIdentifier:@"LightAddreCell" forIndexPath:indexPath];
    addrecell.delegate =self;
    addrecell.cellSepter.hidden = YES;
    addrecell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [addrecell configData:self.dataArray[indexPath.section][indexPath.row]];
    cell = addrecell;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            _paytag = indexPath.row;
            [self blind];
            break;
            case 1:
            _paytag = indexPath.row;
            [self blind];
            break;
        default:
            break;
    }
}

-(void)blind{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    _addrecell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([_addrecell.noOryes.text isEqualToString:@"绑定"]) {
        UIAlertView *okView = [[UIAlertView alloc]initWithTitle:@"是否解绑" message:@"该账号已经被绑定是否解绑" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [okView show];
    }else{
        [self HeadImagePicture];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [self HttpRequest];
            break;
        default:
            break;
    }
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage  *image =[info objectForKey:UIImagePickerControllerOriginalImage];
    [self sendCamer:picker Image:image tag:_paytag];
}

-(void)sendCamer:(UIImagePickerController *)picker Image:(UIImage *)image tag:(NSUInteger)tag{
    
    NSDictionary *dic ;
    NSString * imagestr = [MM2DbarcodePicture readQRCodeFromImage:image];
    if (tag==0) {
        dic= @{@"weixinPayer":imagestr};
    }else{
        dic= @{@"alipayer":imagestr};
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
    [_servince getDicData:url Dic:lastdic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
        [picker dismissViewControllerAnimated:YES completion:nil];
        if ([dic[@"Flag"]isEqualToString:@"S"]) {
            single.alipayurl = imagestr;
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"alipayurl"];
            [[NSUserDefaults standardUserDefaults]setObject:single.alipayurl forKey:@"alipayurl"];
            _addrecell.noOryes.textColor = [UIColor lightGrayColor];
            _addrecell.noOryes.text = @"绑定";
        }
        [CommoneTools alertOnView:self.view content:dic[@"Msg"]];
    } FailuerBlock:^(NSString *str) {
        [picker dismissViewControllerAnimated:YES completion:nil];
        [CommoneTools alertOnView:self.view content:str];
    }];
}

-(void)HttpRequest{
    NSDictionary *dic ;
    if (_paytag==0) {
        dic= @{@"weixinPayer":@""};
    }else{
        dic= @{@"alipayer":@""};
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
    [_servince getDicData:url Dic:lastdic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
        if ([dic[@"Flag"]isEqualToString:@"S"]) {
           single.alipayurl = @"";
         _addrecell.noOryes.textColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.6];
         _addrecell.noOryes.text = @"未绑定";
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"alipayurl"];
        [[NSUserDefaults standardUserDefaults]setObject:single.alipayurl forKey:@"alipayurl"];
        }
        [CommoneTools alertOnView:self.view content:dic[@"Msg"]];
    } FailuerBlock:^(NSString *str) {
        [CommoneTools alertOnView:self.view content:str];
    }];
}
@end
