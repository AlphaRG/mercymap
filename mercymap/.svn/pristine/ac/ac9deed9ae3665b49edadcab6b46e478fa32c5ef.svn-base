//
//  ButtonAdd.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "ButtonAdd.h"
#import "LogViewController.h"
#import "ZLThumbnailViewController.h"
@implementation ButtonAdd
/**
 *  添加按钮
 *
 *  @param Btn
 *  @param str
 */
-(void)setButton:(UIButton *)Btn BtnTitile:(NSString *)str
{
   [Btn setTitle:str forState:UIControlStateNormal];
    Btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    Btn.titleLabel.textAlignment = NSTextAlignmentLeft;
   [Btn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
}

/**
 *  判断字符串是否为空
 *
 *  @param str
 *
 *  @return
 */
-(BOOL)checkInput:(NSString *)str
{
    BOOL fag = YES;
    if (str.length) {
        fag = NO;
    }
    return fag;
}

-(void)CheckCammer:(UIViewController *)View andViewVC:(UIViewController *)VC{
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:@"照片选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    BOOL isCamera =[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    UIImagePickerController *imagePicker =[[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.modalTransitionStyle =UIModalTransitionStyleCoverVertical;    
    if (isCamera){
        UIAlertAction *CameraAction =[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//          [self.delegate sendCammerImage];
            imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
            [View presentViewController:imagePicker animated:YES completion:nil];
        }];
        UIAlertAction *PhotoAction =[UIAlertAction actionWithTitle:@"从手机里选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
             [View.navigationController pushViewController:VC animated:YES];
            }];
        UIAlertAction *canceAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alterController addAction:CameraAction];
        [alterController addAction:PhotoAction];
        [alterController addAction:canceAction];
        [View presentViewController:alterController animated:YES completion:nil];
    }
    else{
        UIAlertAction *PhotoAction =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [View.navigationController pushViewController:VC animated:YES];
        }];
        UIAlertAction *canceAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alterController addAction:PhotoAction];
        [alterController addAction:canceAction];
        [View presentViewController:alterController animated:YES completion:nil];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage  *image =[info objectForKey:UIImagePickerControllerOriginalImage];
    //UIImage  *resizedImage = [UIImage scaleToSize:image size:CGSizeMake(480,480)];
    [picker dismissViewControllerAnimated:YES completion:^{
        if (self.Imgs) {
            self.Imgs(image);
        }
    }];
}

-(void)AlterView:(UIViewController *)view{
    UIAlertController *alterController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请到用户认证登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    LogViewController *logVC =[[LogViewController alloc]initWithNibName:@"LogViewController" bundle:nil];
        [logVC setHidesBottomBarWhenPushed:YES];
        [view.navigationController pushViewController:logVC animated:YES];
    }];
    [alterController addAction:OK];
    [view presentViewController:alterController animated:YES completion:nil];
}

@end
