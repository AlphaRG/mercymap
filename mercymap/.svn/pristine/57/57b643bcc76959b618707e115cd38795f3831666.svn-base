//
//  StarInfornationTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/19.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "StarInfornationTableViewController.h"
#import "StarUserFTableViewCell.h"
#import "LoginService.h"
#import "Single.h"
#import "StarFirstViewController.h"
#import "LogViewController.h"
#import "UIImage+Addition.h"
#import "CityTableViewCell.h"
#import "CityTableViewController.h"
#import "ThirdAccountRegisterTableViewCell.h"
#import <UMSocialCore/UMSocialCore.h>
#import "MM_UnbildViewController.h"
#import "MM2DbarcodePicture.h"
@interface StarInfornationTableViewController ()<ImageDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>{
    LoginService *Service;
    Single *single;
    NSMutableDictionary *userdic,*paydic;
    
    NSArray      *_thirdRegisterA;
    NSMutableArray *_bindListA;
    NSDictionary *requestdic ;
    int  Bindtag,paytag;
    ThirdAccountRegisterTableViewCell *TCell,*_tirdBindTableView;
}
@end

@implementation StarInfornationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableFooterView = view;
    Service = [[LoginService alloc]init];
    single =[Single Send];
    _bindListA  = [[NSMutableArray alloc]init];

    self.title =@"个人设置";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    userdic =[[NSMutableDictionary alloc]initWithCapacity:0];
    paydic = [[NSMutableDictionary alloc]initWithCapacity:0];
    UINib *nib = [UINib nibWithNibName:@"StarUserFTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"StarUserID"];
    UINib *nib2 =[UINib nibWithNibName:@"CityTableViewCell" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"CityID"];
    [self.tableView registerClass:@[@"ThirdAccountRegisterTableViewCell"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _thirdRegisterA = @[@{@"image":@"tel.png",@"name":@"手机号",@"BindType":@"10"},@{@"image":@"wexin.png",@"name":@"微信",@"BindType":@"20"},@{@"image":@"weibo.png",@"name":@"微博",@"BindType":@"30"}];
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getInforNation];
    [self getbindlist];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self sendCamer:picker Image:image tag:paytag];
}


-(void)sendCamer:(UIImagePickerController *)picker Image:(UIImage *)image tag:(int)tag{
    if (tag == 0) {
        UIImage  *resizedImage = [UIImage scaleToSize:image size:CGSizeMake(480,480)];
        NSString *fileName =[NSString stringWithFormat:@"%d_HeadImage.jpg",single.ID];
        NSString *url =[NSString stringWithFormat:@"%@api/Common/FormPictureUpload?Token=%@&UID=%d&FormPlatform=%@&ClientType=%@",USERURL,single.Token,single.ID,@100,@10];
        
        [Service sendImage:url Sizeimage:resizedImage iamgeName:fileName Token:single.Token success:^(NSArray *successBlock){
            NSString *str =successBlock[0];
            NSDictionary *dic = @{@"HeadImg":str};
            NSNumber *uid = [NSNumber numberWithInt:single.ID];
            NSDictionary *lastdic =@{
                                     @"_Members":dic,
                                     @"Token":single.Token,
                                     @"UID":uid,
                                     @"FormPlatform":@100,
                                     @"ClientType":@10
                                     };
            NSString *url = [NSString stringWithFormat:@"%@api/Account/MemberUpdate",USERURL];
            [Service getDicData:url Dic:lastdic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
                [picker dismissViewControllerAnimated:YES completion:nil];
            } FailuerBlock:^(NSString *str) {
                
            }];
        } error:^(NSString *errorBlock) {
            [picker dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)getInforNation{
    dispatch_async(dispatch_get_main_queue(), ^{
        [Service getUser:single.ID Token:single.Token successBlock:^(NSDictionary *model) {
            [userdic removeAllObjects];
            [paydic removeAllObjects];
            [userdic setDictionary:model];
            [paydic addEntriesFromDictionary:model];
            [self.tableView reloadData];
        } Failuer:^(NSString *error) {
            NSLog(@"Wrong");
        }];
    });
}

-(void)getbindlist{
    NSDictionary *binddic;
    NSString     *url = [NSString stringWithFormat:@"%@api/Bind/MemberBindList",USERURL];
    NSNumber *ID  = [NSNumber numberWithInt:single.ID];
    binddic = @{@"UID":ID ,@"Token":single.Token,@"ClientType":@10};
    [Service getArrayData:binddic Url:url Title:@"IlistMembers_Bind" SuccessBlock:^(NSArray *modelArray){
        [_bindListA removeAllObjects];
        [_bindListA addObjectsFromArray:modelArray];
        [self.tableView reloadData];
    } FailuerBlock:^(NSString *str) {
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 4;
    }else if (section==1){
        return 2;
    }
    else{
        return 3;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 66;
        }
    }
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
   if (indexPath.section==0){
       StarUserFTableViewCell *FCell = [tableView dequeueReusableCellWithIdentifier:@"StarUserID" forIndexPath:indexPath];
        if (indexPath.row==0){
            FCell.delegate = self;
            [FCell initWithUserFirstCell:@"" cellName:@"头像" textName:userdic[@"HeadImg"] indexpath:1];
            cell =FCell;
        }
        if (indexPath.row ==1){
             if (userdic[@"NickName"] ==nil||[userdic[@"NickName"] isKindOfClass:[NSNull class]]){
                 userdic[@"NickName"] = @"";
             }
            [FCell initWithUserFirstCell:nil cellName:@"昵称" textName:userdic[@"NickName"]  indexpath:0];
            cell =FCell;
        }if (indexPath.row == 2) {
            if (userdic[@"UserName"] ==nil||[userdic[@"UserName"] isKindOfClass:[NSNull class]]){
                userdic[@"NickName"] = @" ";
            }
            [FCell initWithUserFirstCell:nil cellName:@"用户名" textName:userdic[@"UserName"]  indexpath:0];
            cell =FCell;
        }
        if (indexPath.row==3){
            FCell.delegate =self;
            NSString *textname;
            if ([userdic[@"Province"]isKindOfClass:[NSNull class]]) {
                textname =NULL;
            }
            else{
            textname = [NSString stringWithFormat:@"%@ %@",userdic[@"Province"],userdic[@"City"]];
            }
            [FCell initWithUserFirstCell:@"" cellName:@"我的地址" textName:textname indexpath:0];
            cell =FCell;
         }
    }
    if (indexPath.section ==1){
        StarUserFTableViewCell *FCell = [tableView dequeueReusableCellWithIdentifier:@"StarUserID" forIndexPath:indexPath];
        if (indexPath.row ==0){
            [FCell initWithUserFirstCell:nil cellName:@"性别" textName:userdic[@"sex"] indexpath:2];
        }
        if (indexPath.row==1){
            if (userdic[@"Idiograph"] ==nil||[userdic[@"Idiograph"] isKindOfClass:[NSNull class]]){
                userdic[@"Idiograph"] = @"";
            }
            [FCell initWithUserFirstCell:nil cellName:@"个性签名" textName:userdic[@"Idiograph"] indexpath:0];
        }
        cell =FCell;
    }
    if(indexPath.section == 2){
        TCell = [tableView dequeueReusableCellWithIdentifier:@"ThirdAccountRegisterTableViewCell" forIndexPath:indexPath];
        TCell.tag = indexPath.row;
        TCell.bindlistArray =  _bindListA;
        [TCell setdatainfo:_thirdRegisterA[indexPath.row]];
        cell = TCell;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row ==0) {
            paytag =0;
            [self HeadImagePicture];
        }
        if (indexPath.row ==1) {
            StarFirstViewController *FirstVC = [[StarFirstViewController alloc]initWithNibName:@"StarFirstViewController" bundle:nil];
            FirstVC.tag=0;
            FirstVC.titlename = @"修改昵称";
            FirstVC.textfiledname = userdic[@"NickName"];
            [self.navigationController pushViewController:FirstVC animated:YES];
        }
        if (indexPath.row == 2) {
            StarFirstViewController *FirstVC = [[StarFirstViewController alloc]initWithNibName:@"StarFirstViewController" bundle:nil];
            FirstVC.tag=2;
            FirstVC.titlename = @"修改用户名";
            FirstVC.textfiledname = userdic[@"UserName"];
            [self.navigationController pushViewController:FirstVC animated:YES];

        }
        if (indexPath.row ==3) {
            CityTableViewController *CityVC = [[CityTableViewController alloc]initWithNibName:@"CityTableViewController" bundle:nil];
            [self.navigationController pushViewController:CityVC animated:YES];
          CityVC.ReturnBlock =^(NSString *str)
             {
                [self getInforNation];
                [self.tableView reloadData];
            };
        }
    }
   else if(indexPath.section==1){
        if (indexPath.row ==0) {
            [self AlterViewController];
        }
        if (indexPath.row==1) {
            StarFirstViewController *FirstVC = [[StarFirstViewController alloc]initWithNibName:@"StarFirstViewController" bundle:nil];
            FirstVC.tag =1;
            FirstVC.textfiledname = userdic[@"Idiograph"];
            FirstVC.titlename= @"个信签名";
            [self.navigationController pushViewController:FirstVC animated:YES];
        }
    }
   else{
        UMSocialPlatformType platformType ;
        switch (indexPath.row){
            case 0:
                 [self mobileBild];
                 break;
            case 1:
                platformType = UMSocialPlatformType_WechatSession;
                [self RegplatformType:platformType];
                break;
             case 2:
                platformType = UMSocialPlatformType_Sina;
                [self RegplatformType:platformType];
                break;
            default:
                break;
        }
   }
}

-(void)mobileBild{
     MM_UnbildViewController *vc = [[MM_UnbildViewController alloc]initWithNibName:@"MM_UnbildViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)RegplatformType:(UMSocialPlatformType)platformType{
    [[UMSocialManager defaultManager]  authWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        NSString *message = nil;
        if (error) {
            message = @"Auth fail";
        }else{
            if ([result isKindOfClass:[UMSocialAuthResponse class]]) {
                UMSocialAuthResponse *response = result;
                NSString     *url ;
                switch (platformType) {
                    case 0:
                        Bindtag = 1;
                        url = [NSString stringWithFormat:@"%@%@",USERURL,@"api/Bind/BindWeibo"];
                        requestdic = @{
                                @"weibouid":response.uid,
                                @"access_token":response.accessToken,
                                @"UID":[NSNumber numberWithInt:single.ID],
                                @"Token":single.Token,
                                @"FormPlatform":@100,
                                @"ClientType":@10
                                };
                        [self bindTird:requestdic url:url];
                        break;
                        
                    case 1:
                        Bindtag = 2;
                        url = [NSString stringWithFormat:@"%@%@",USERURL,@"api/Bind/BindWeixin"];
                        requestdic = @{
                                @"openid":response.openid,
                                @"access_token":response.accessToken,
                                @"UID":[NSNumber numberWithInt:single.ID],
                                @"Token":single.Token,
                                @"FormPlatform":@100,
                                @"ClientType":@10
                            };
                        [self bindTird:requestdic url:url];
                        break;
                        
                    default:
                        break;
                }

            }else{
                
            }
        }
    }];
}

-(void)bindTird:(NSDictionary *)reqdic url:(NSString *)url{
    [Service getDicData:url Dic:requestdic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
        if ([dic[@"Flag"] isEqualToString:@"S"]) {
            [self getbindlist];
            [CommoneTools alertOnView:self.view content:@"绑定成功"];
        }else if ([dic[@"Flag"] isEqualToString:@"F"]){
            [self alterViewContrllerBind:requestdic];
        }
    } FailuerBlock:^(NSString *str) {
    }];
}

-(void)AlterViewController{
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:@"性别选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *boyAc =[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        NSDictionary *dic =@{@"sex":@"true"};
        NSNumber *uid = [NSNumber numberWithInt:single.ID];
        NSDictionary *lastdic =@{
                                 @"_Members":dic,
                                 @"Token":single.Token,
                                 @"UID":uid,
                                 @"FormPlatform":@100,
                                 @"ClientType":@10
                                 };
        NSString *url = [NSString stringWithFormat:@"%@api/Account/MemberUpdate",USERURL];
        [Service getDicData:url Dic:lastdic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
            [self getInforNation];
            [self.tableView reloadData];
        } FailuerBlock:^(NSString *str) {
            
        }];
    }];
   UIAlertAction  *girlAc = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       NSDictionary *dic =@{@"sex":@"false"};
       NSNumber *uid = [NSNumber numberWithInt:single.ID];
       NSDictionary *lastdic =@{
                                @"_Members":dic,
                                @"Token":single.Token,
                                @"UID":uid,
                                @"FormPlatform":@100,
                                @"ClientType":@10
                                };
       NSString *url = [NSString stringWithFormat:@"%@api/Account/MemberUpdate",USERURL];
       [Service getDicData:url Dic:lastdic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
           [self getInforNation];
           [self.tableView reloadData];
       } FailuerBlock:^(NSString *str) {
           
       }];

       }];
    UIAlertAction *canceAc =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
    }];
    [alterController addAction:boyAc];
    [alterController addAction:girlAc];
    [alterController addAction:canceAc];
    [self presentViewController:alterController animated:YES completion:nil];
}

-(void)alterViewContrllerBind:(NSDictionary *)dic{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ThirdAccountRegisterTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell.noOryes.text isEqualToString:@"绑定"]) {
        UIAlertView *okView = [[UIAlertView alloc]initWithTitle:@"是否解绑" message:@"该账号已经被绑定是否解绑" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [okView show];
    }else{
        [CommoneTools alertOnView:self.view content:@"此第三方账号已绑定其他乐善地图账号，无法再与您的乐善地图账号绑定"];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            
          break;
        case 1:
            [self unbindTird];
            break;
        default:
            break;
    }
}

-(void)unbindTird{
    NSString *url;
    switch (Bindtag) {
        case 0:
            url = [NSString stringWithFormat:@"%@api/Bind/UnBindMobileNum",USERURL];
            break;
       case 1:
            url = [NSString stringWithFormat:@"%@api/Bind/UnBindWeibo",USERURL];
            break;
        case 2:
            url =[NSString stringWithFormat:@"%@api/Bind/UnBindWeixin",USERURL];
            break;
        case 3:
            url = [NSString stringWithFormat:@"%@api/Account/MemberUpdate",USERURL];
        default:
            break;
    }
    [Service getDicData:url Dic:requestdic Title:nil SuccessBlock:^(NSMutableDictionary *dic) {
        if ([dic[@"Flag"] isEqualToString:@"S"]) {
            [self getbindlist];
            [self getInforNation];
        }else if ([dic[@"Flag"] isEqualToString:@"F"]){
        }
    } FailuerBlock:^(NSString *str) {
    }];
}

@end
