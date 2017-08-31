 //
//  LoginService.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LoginService.h"
#import "AppDelegate.h"
#import "Single.h"
#import "LoginModel.h"
#import "LightModel.h"
@implementation LoginService
{
    Single *single;
}

-(NSDictionary *)getmacdic{
    NSMutableDictionary *macDic = [[NSMutableDictionary alloc]init];
    //设备名称
    //            NSString *strName = [[UIDevice currentDevice]name];
    //            //系统名称
    //            NSString *strSysName =[[UIDevice currentDevice]systemName];
    //            //手机机型
    //            NSString *phoneModel = [[UIDevice currentDevice]model];
    //app当前应用软件版本
//                NSDictionary *dicInfo = [[NSBundle mainBundle]infoDictionary];
//                NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
    //            NSString *Allstr = [NSString stringWithFormat:@"%@%@%@",strName,strSysName,phoneModel];
    NSDictionary *Macdic = @{
                             @"IMEI":@"",
                             @"MacAddress":@"",
                             @"GPSLocation":@""
                             };
    [macDic addEntriesFromDictionary:Macdic];
    return macDic;
}

-(NSString *)getappversion{
    NSDictionary *dicInfo = [[NSBundle mainBundle]infoDictionary];
    NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
    return  strAppVersion;
}

-(NSString *)getClientDevice{
    NSString *strSysName =[[UIDevice currentDevice]systemName];
    return  strSysName;
}

-(void)Login:(NSString *)url UserName:(NSString *)UserName andPassWord:(NSString *)password successBlock:(LoginSuccessBlock)successBlock FailuerBlock:(loginFailuerBlock)errorBlock
{
    NSDictionary *dic =@{@"MobileNum":UserName,@"Password":password,@"ClientAttr":@"123",@"TokenType":@10};
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setValue:dicData[@"OMsg"][@"Flag"] forKey:@"Flag"];
        if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]){
            [dic addEntriesFromDictionary:dicData[@"MUsers"]];
            [dic setValue:dicData[@"Token"] forKey:@"Token"];
             successBlock(dic);
        }
        else{
            [dic setValue:dicData[@"OMsg"][@"Msg"]forKey:@"Reason"];
            successBlock(dic);
        }
    } Failuer:^(NSString *errorInfo) {
        errorBlock(errorInfo);
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [CommoneTools alertOnView:window content:errorInfo];
    }];
    
}


-(void)Regist:(NSString *)ID MobileNum:(NSString *)MobileNum andPassWord:(NSString *)password code:(NSString *)code guidString:guidString Fag:(int)fag successBlock:(LoginSuccessBlock)successBlock FailuerBlock:(RegFailuerBlock)errorBlock
{
    single = [Single Send];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",USERURL,@"api/Account/MemberMobileReg"];
    NSDictionary *dic ;
    NSDictionary *IVerifyCode = @{
                                  @"TUidOrMail":guidString,
                                  @"ActionPage":@"loginPage",
                                  @"Code":code
                                  };
    if (fag==1){
        dic = @{
                @"code":ID,
                @"MobileNum":MobileNum,
                @"password":password,
                @"zon":@"86",
                @"ClientType":@10,
                @"FormPlatform":@100,
                @"ClientInfor":[self getmacdic],
                @"IVerifyCode":IVerifyCode
              };
    }
    else{
        dic = @{
                @"MobileNum":MobileNum,
                @"Password":password ,
                @"HeadImg":single.imageUrl
              };
    }
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setValue:dicData[@"Flag"] forKey:@"Flag"];
        [dic setValue:dicData[@"Msg"] forKey:@"Msg"];
        NSLog(@"%@",dicData[@"Msg"]);
        successBlock(dic);
           } Failuer:^(NSString *errorInfo) {
        errorBlock(errorInfo);
    }];
}

-(void)getUser:(int)ID Token:(NSString *)Token successBlock:(GetUserInfornationSuccessBlock)successBlock Failuer:(GetUserInfornationFailuerBlock)errorBlock{
    
    NSString *url =[NSString stringWithFormat:@"%@api/Account/MemberInfo",USERURL];
    NSNumber *userID =[NSNumber numberWithInt:ID];
    NSDictionary *dic =@{@"UID":userID,@"Token":Token,@"ClientType":@10,@"FormPlatform":@100};
    
    if ([self netStatus]<= 0) {
        errorBlock(@"wrong");
    }
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
            NSMutableDictionary *resultdic = [[NSMutableDictionary alloc]init];
            [resultdic addEntriesFromDictionary:dicData[@"Members"]];
            [resultdic setValue:dicData[@"OMsg"][@"Flag"] forKey:@"Flag"];
            successBlock(resultdic);
        }else{
            successBlock(dicData[@"OMsg"]);
        }
    } Failuer:^(NSString *errorInfo) {
        errorBlock(errorInfo);
    }];
}

-(void)fixUserMessage:(int)ID Token:(NSString *)Token Parameters:(NSString *)Parameters Code:(NSString *)Code successBlock:(GetUserInfornationSuccessBlock)successBlock Failuer:(GetUserInfornationFailuerBlock)errorBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@",URLM,@"api/Account/UserUpdate"];
    NSNumber *UserID =[NSNumber numberWithInt:ID];
    NSDictionary *dic =[[NSDictionary alloc]init];
    if ([Code isEqualToString:@"RealName"]) {
        dic=@{@"ID":UserID,@"Token":Token,@"RealName":Parameters};
    }
    if ([Code isEqualToString:@"NickName"]) {
        dic =@{@"ID":UserID,@"Token":Token,@"NickName":Parameters};
    }
    if ([Code isEqualToString:@"HeadImg"]){
        dic =@{@"ID":UserID,@"Token":Token,@"HeadImg":Parameters};
    }
    if ([Code isEqualToString:@"Address"]) {
        dic=@{@"ID":UserID,@"Token":Token,@"Address":Parameters};
    }
    if ([Code isEqualToString:@"Idiograph"]) {
        dic =@{@"ID":UserID,@"Token":Token,@"Idiograph":Parameters};
    }
    if ([Code isEqualToString:@"Sex"]) {
        bool bool_true ;
        NSString *sex;
        if ([Parameters isEqualToString:@"Boy"]) {
            sex=@"true";
        }
        else{
            bool_true =false;
            sex=@"false";
        }
        dic =@{@"ID":UserID,@"Token":Token,@"Sex":sex};
    }
    if ([Code isEqualToString:@"ThirdLogin"]) {
        single =[Single Send];
        dic =@{@"ID":UserID,@"Token":Token,@"NickName":single.nickname,@"HeadImg":single.imageUrl};
    }
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        successBlock(dicData[@"MUsers"]);
    } Failuer:^(NSString *errorInfo) {
        errorBlock(errorInfo);
     }];
}


-(void)fixUserCity:(int)ID Token:(NSString *)Token Province:(NSString *)Province City:(NSString *)City successBlock:(GetUserInfornationSuccessBlock)successBlock Failuer:(GetUserInfornationFailuerBlock)errorBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@",URLM,@"api/Account/UserUpdate"];
    NSNumber *UserID =[NSNumber numberWithInt:ID];
    NSDictionary *dic =[[NSDictionary alloc]init];
    dic=@{@"ID":UserID,@"Token":Token,@"Province":Province,@"City":City};
    
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
    successBlock(dicData[@"OMsg"]);
    } Failuer:^(NSString *errorInfo) {
        errorBlock(errorInfo);
    }];
}

-(void)getLightKindInfornation:(int)shopCategoryID PageIndex:(int)pageIndex PageSize:(int)pageSize successBlock:(GetLightInfonationSuccessBlock)successBlock Failuer:(GetLightInfonationFailuerBlock)errorBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@",URLM,@"api/Shop/GetShopListForCategory"];
    single =  [Single Send];
    NSNumber *shopcategoryID =[NSNumber numberWithInt:shopCategoryID];
    NSNumber *pageindex =[NSNumber numberWithInt:pageIndex];
    NSNumber *pagesize =[NSNumber numberWithInt:pageSize];
    NSNumber *uid = [NSNumber numberWithInt:single.ID];
    NSDictionary *dic =@{
                        @"shopCategoryID":shopcategoryID,
                        @"pageIndex":pageindex,
                        @"pageSize":pagesize,
                        @"FormPlatform":@100,
                        @"ClientType":@10,
                        @"UID":uid
                        };
   [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData){
    if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
            successBlock(dicData[@"ListShopList"]);}
           }
    Failuer:^(NSString *errorInfo){
       errorBlock(errorInfo);
    }];
}

-(void)getLightListInfonation:(int)PageIndex Pagesize:(int)pageSize successBlock:(GetLightInfonationSuccessBlock)successBlock Failuer:(GetLightInfonationFailuerBlock)errorBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@",URLM,@"api/Shop/GetShopListForCategory"];
    NSNumber *pageindex =[NSNumber numberWithInt:PageIndex];
    NSNumber *pagesize =[NSNumber numberWithInt:pageSize];
    NSDictionary *dic =@{
                         @"pageIndex":pageindex,
                         @"pageSize":pagesize,
                         @"FormPlatform":@100,
                         @"ClientType":@10
                         };
   [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
    if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
    successBlock(dicData[@"ListShopList"]);
    }
    } Failuer:^(NSString *errorInfo){
       errorBlock(errorInfo);
    }];
}

-(void)GetSelfLightInfo:(int)ID SuccessBlock:(LoginSuccessBlock)successBlock FailuerBlock:(loginFailuerBlock)errorBlock{
    NSString *url =[NSString stringWithFormat:@"%@api/Shop/GetShopDetail",URLM];
    NSNumber *LightID =[NSNumber numberWithInt:ID];
    NSDictionary *dic =@{
                         @"shopID":LightID,
                         @"FormPlatform":@100,
                         @"ClientType":@10
                         };
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData){
        if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]){
            successBlock(dicData[@"ShopList"]);
        }
        else{
            errorBlock(dicData[@"OMsg"][@"Msg"]);
        }
    }
    Failuer:^(NSString *errorInfo){
        errorBlock(errorInfo);
    }];
}


-(void)GetSelfLightComment:(int)shopID ParentID:(int)ParentID ParentLevel1ID:(int)ParentLevel1ID PageIndex:(int)pageIndex pageSize:(int)pageSize SuccessBlock:(GetLightInfonationSuccessBlock)successBlock FailuerBlock:(GetLightInfonationFailuerBlock)errorBlock {
    NSString *url;
    NSDictionary *dic;
    NSNumber *ShopID =[NSNumber numberWithInt:shopID];
    NSNumber *PageIndex =[NSNumber numberWithInt:pageIndex];
    NSNumber *PageSize =[NSNumber numberWithInt:pageSize];
    NSNumber *parentID =[NSNumber numberWithInt:ParentID];
    
    if (ParentLevel1ID == 0) {
        url =[NSString stringWithFormat:@"%@api/Shop/ShopCommentList",URLM];
        dic= @{
               @"shopID":ShopID,
               @"pageIndex":PageIndex,
               @"pageSize":PageSize,
               @"FormPlatform":@100,
               @"ClientType":@10
            };

    }else{
        url =[NSString stringWithFormat:@"%@api/Shop/ShopCommentListReply",URLM];
        dic= @{
                @"shopID":ShopID,
                @"pageIndex":PageIndex,
                @"pageSize":PageSize,
                @"parentID":parentID,
                @"FormPlatform":@100,
                @"ClientType":@10
               };
    }
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData){
       if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]){
           successBlock(dicData[@"ListShopComment"]);
    }
    else{
           errorBlock(dicData[@"OMsg"][@"Msg"]);
       }
   }
   Failuer:^(NSString *errorInfo) {
       errorBlock(errorInfo);
   }];
}

-(void)dianzanLightShopID:(int)ShopID UID:(int)UID Token:(NSString *)Token Time:(NSString *)time Tag:(int)tag  SuccessBlock:(RegSuccessBlock)successBlock Failuer:(RegFailuerBlock)errorBlock{
    NSString *url;
    if(tag ==1){
        url =[NSString stringWithFormat:@"%@%@",URLM,@"api/Shop/ClickLike"];
    }else{
        url = [NSString stringWithFormat:@"%@%@",URLM,@"api/Account/ClickSignIn"];
    }
    NSNumber *shopID =[NSNumber numberWithInt:ShopID];
    NSNumber *uID =[NSNumber numberWithInt:UID];
    NSDictionary *dic;
//    Userdic =@{@"ShopID":shopID,@"UID":uID};
//    dic =@{@"ShopLiked":Userdic,@"Token":Token};
    NSString * str  =[[NSUserDefaults standardUserDefaults]objectForKey:@"LocationAdress"];
    dic =@{
           @"UID":uID,
           @"ShopID":shopID,
           @"LikeTime":time,
           @"LikeLocaltion":str,
           @"Token":Token,
           @"FormPlatform":@100,
           @"ClientType":@10
           };
   [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData){
    successBlock(dicData[@"Msg"]);
    } Failuer:^(NSString *errorInfo) {
}];
}

-(void)sendCommentShopID:(int)ShopID UID:(int)UID ParentID:(int)ParentID ParentLevel1ID:(int)ParentLevel1ID Token:(NSString *)Token CommentInfo:(NSString *)CommentInfo imageArray:(NSMutableArray *)imageArray PublicRole:(NSNumber *)PublicRole SuccessBlock:(RegSuccessBlock)successBlock Failuer:(RegFailuerBlock)errorBlock{
    NSString *url =[NSString stringWithFormat:@"%@%@",URLM,@"api/Shop/ShopComment"];
    NSNumber *shopID =[NSNumber numberWithInt:ShopID];
    NSNumber *uID =[NSNumber numberWithInt:UID];
    NSNumber *parentID = [NSNumber numberWithInt:ParentID];
    NSNumber *parentLevel1ID = [NSNumber numberWithInt:ParentLevel1ID];
    NSDictionary *Userdic,*dic;
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]initWithCapacity:0];;
    Userdic =@{
        @"ShopID":shopID,
        @"UID":uID,
        @"CommentInfo":CommentInfo,
        @"ParentID":parentID,
        @"ParentLevel1ID":parentLevel1ID,
        @"PublicRole":PublicRole
        };
    [dic2 addEntriesFromDictionary:Userdic];
    if (imageArray != nil) {
        for (int i=0; i<imageArray.count; i++){
            NSString *ImageName =[NSString stringWithFormat:@"Img%d",i+1];
            [dic2 setObject:imageArray[i] forKey:ImageName];
        }
    }
    dic =@{
           @"ShopComment":dic2,
           @"Token":Token,
           @"UID":uID,
           @"FormPlatform":@100,
           @"ClientType":@10
           };
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        successBlock(dicData[@"Msg"]);
    } Failuer:^(NSString *errorInfo) {
    }];
}



-(void)CreateLight:(NSString *)ShopName ShopCategoryID:(int)ShopCategoryID ShopMainImg:(NSString *)ShopMainImg ShopAddr:(NSString *)ShopAddr ShopHours:(NSString *)ShopHours ShopStory:(NSString *)ShopStory ShopImageArray:(NSMutableArray *)ImageArray Token:(NSString *)Token ShopMobileNum:(NSString *)ShopMobileNum ShopGPS:(NSString *)ShopGPS SuccessBlock:(RegSuccessBlock)successBlock FailuerBlock:(RegFailuerBlock)errorBlock
{
    single=[Single Send];
    NSString *url =[NSString stringWithFormat:@"%@api/Shop/CreateShop",URLM];
    NSNumber *shopCategoryID =[NSNumber numberWithInt:ShopCategoryID];
    NSNumber *uid =[NSNumber numberWithInt:single.ID];
    NSMutableDictionary *dic;
    NSDictionary *dic2;
    dic =[[NSMutableDictionary alloc]initWithCapacity:0];
    dic2=@{@"ShopName":ShopName,@"ShopCategoryID":shopCategoryID,@"ShopMainImg":ShopMainImg,@"ShopAddr":ShopAddr,@"ShopHours":ShopHours,@"ShopStory":ShopStory,@"Token":Token,@"ShopMobileNum":ShopMobileNum,@"UID":uid,@"ShopGPS":ShopGPS};
    
    [dic addEntriesFromDictionary:dic2];

    for (int i=0; i<ImageArray.count; i++){
        NSString *ImageName =[NSString stringWithFormat:@"ShopImg%d",i+1];
        [dic setObject:ImageArray[i] forKey:ImageName];
    }
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData){
        successBlock(dicData[@"Flag"]);
        } Failuer:^(NSString *errorInfo) {
        }];
}

-(void)CollectionUser:(int)ShopID UID:(int)UID FocusType:(BOOL)FocusType Token:(NSString *)Token SuccessBlock:(RegSuccessBlock)successBlock Failuer:(RegFailuerBlock)errorBlock
{
    NSString *url = [NSString stringWithFormat:@"%@api/Account/UserClickFocus",URLM];
    NSNumber *shopid = [NSNumber numberWithInt:ShopID];
    NSNumber *uid =[NSNumber numberWithInt:UID];
    NSDictionary *dic;
    if (FocusType) {
        dic =@{@"ShopID":shopid,@"UID":uid,@"FocusType":@"false",@"Token":Token};
    }
    else{
       dic =@{@"ShopID":shopid,@"UID":uid,@"FocusType":@"true",@"Token":Token};
    }
    
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        successBlock(dicData[@"Msg"]);
    } Failuer:^(NSString *errorInfo) {
        errorBlock(errorInfo);
    }];
}

-(void)CollectionInfo:(int)UID FocusType:(BOOL)FocusType Token:(NSString *)Token PageSize:(int)PageSize PageIndex:(int)PageIndex SuccesBlock:(GetLightInfonationSuccessBlock)successBlock FailuerBlock:(GetUserInfornationFailuerBlock)errorBlock
{
    NSString *url =[NSString stringWithFormat:@"%@api/Account/UserClickFocusList",URLM];
    NSNumber *uid =[NSNumber numberWithInt:UID];
    NSNumber *pageIndex =[NSNumber numberWithInt:PageIndex];
    NSNumber *pagesize =[NSNumber numberWithInt:PageSize];
    NSDictionary *dic;
    if (FocusType) {
        dic =@{@"UID":uid,@"FocusType":@"false",@"Token":Token,@"pageSize":pagesize,@"pageIndex":pageIndex};
    }
    else{
        dic =@{@"UID":uid,@"FocusType":@"true",@"Token":Token,@"pageSize":pagesize,@"pageIndex":pageIndex};
    }
    
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {

        successBlock(dicData[@"ListUserClickFocus"]);
        
    } Failuer:^(NSString *errorInfo) {
        errorBlock(errorInfo);
    }];
}


-(void)firstLogin{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:@"ID"];
    [defaults removeObjectForKey:@"Token"];
    [defaults removeObjectForKey:@"UserLogin"];
    [defaults removeObjectForKey:@"newUser"];
    
    [self sendRequestHttp:[NSString stringWithFormat:@"%@/api/Account/UserCreateGuest",URLM]parameters:nil Success:^(NSDictionary *dicData){
         // [[NSUserDefaults standardUserDefaults]setObject:dicData[@"ID"] forKey:@"userID"];
         Single *sing = [Single Send];
         sing.ID = [dicData[@"ID"] intValue];
         sing.MobileNum = nil;
         sing.Password  = nil;
         sing.Token    =  nil;
         int ID =sing.ID;
         [[NSUserDefaults standardUserDefaults]setInteger:ID forKey:@"ID"];
         [[NSUserDefaults standardUserDefaults]synchronize];
     }
    Failuer:^(NSString *errorInfo) {
     }];
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:YES] forKey:@"newUser"];
    [[NSUserDefaults standardUserDefaults]synchronize];

}

-(void)judegeMoibleExict:(NSString *)mobile SuccessBlock:(RegSuccessBlock)SuccessBlock FailuerBlock:(loginFailuerBlock)Failuer{
    NSString *url =[NSString stringWithFormat:@"%@api/Account/MemberMobileIsExist",USERURL];
    NSDictionary *dic =@{
                         @"mobileNum":mobile,
                         @"ClientInfor":[self getmacdic],
                         @"FormPlatform":@100,
                         @"ClientType":@10
                         };
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
       SuccessBlock (dicData[@"Code"]);
    } Failuer:^(NSString *errorInfo) {
       Failuer(errorInfo);
         }];
}

-(void)getAppURL:(NSString *)urltype SuccessBlock:(HttpSuccessBlock)SuccessBlock FailuerBlock:(HttpFailuerBlock)FailuerBlock{
    //NSString *url = [NSString stringWithFormat:@"http://www.wispeed.com/api/Common/GetIUrl?urltype=%@",urltype];
    NSString *url = [NSString stringWithFormat:@"http://www.wispeed.com/geturlapis.ashx?urltype="];
    NSDictionary *dic = @{@"urltype":[NSNull null]};
    [self sendRequestHttpGet:url parameters:dic Success:^(NSDictionary *dicData) {
        NSMutableDictionary  *dic1 =  [[NSMutableDictionary alloc]init];
        if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]){
            [dic1 setObject:@"S" forKey:@"Flag"];
            [dic1 setObject:dicData[@"ListAppIUrls"] forKey:@"ListAppIUrls"];
            SuccessBlock(dic1);
        }
        else{
            [dic1 setObject:@"F" forKey:@"Flag"];
            SuccessBlock(dic1);
        }
    }
    Failuer:^(NSString *errorInfo){
         FailuerBlock(errorInfo);
     }];
}

-(void)getArrayData:(NSDictionary *)dic Url:(NSString *)url Title:(NSString*)title SuccessBlock:(GetLightInfonationSuccessBlock)SuccessBlock FailuerBlock:(HttpFailuerBlock)FailuerBlock{
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
      if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]){
            SuccessBlock([dicData objectForKey:[NSString stringWithFormat:@"%@",title]]);
        }else{
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            [CommoneTools alertOnView:window content:dicData[@"OMsg"][@"Msg"]];
            NSMutableArray *a = [NSMutableArray arrayWithCapacity:0];
            SuccessBlock(a);
        }
    } Failuer:^(NSString *errorInfo) {
        FailuerBlock(errorInfo);
    }];
}

-(void)getDicData:(NSString *)url Dic:(NSDictionary *)dic Title:(NSString *)title SuccessBlock:(HttpSuccessBlock)successBlock FailuerBlock:(HttpFailuerBlock)failuerBlock{
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        NSMutableDictionary *lastdic = [[NSMutableDictionary alloc]init];
        if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]||[dicData[@"OMsg"][@"Flag"]isEqualToString:@"SUCCESS"]){
            if (title == nil) {
                [lastdic addEntriesFromDictionary:dicData];
            }else{
            [lastdic addEntriesFromDictionary:[dicData objectForKey:[NSString stringWithFormat:@"%@",title]]];
            [lastdic addEntriesFromDictionary:dicData[@"OMsg"]];
            }
            successBlock(lastdic);
        }else{
            [lastdic addEntriesFromDictionary:dicData];
            successBlock(lastdic);
        }
    } Failuer:^(NSString *errorInfo) {
        failuerBlock(errorInfo);
    }];
}

-(void)login:(NSString *)url dic:(NSDictionary *)dic code:(NSString *)code title:(NSString *)title successBlock:(HttpSuccessBlock)successBlock failuerBlock:(HttpFailuerBlock)failuerBlock{
    NSMutableDictionary *lastdic = [[NSMutableDictionary alloc]init];
    
    [lastdic addEntriesFromDictionary:dic];
    [lastdic setValue:[self getmacdic]forKey:@"ClientInfor"];
    [lastdic setValue: [self getClientDevice] forKey:@"ClientDevice"];
    [lastdic setValue: [self getappversion] forKey:@"SoftVesion"];
    [lastdic setValue: @"No messages" forKey:@"ClientInformation"];
    [lastdic setValue:@10 forKey:@"ClientType"];
    [lastdic  setValue:@100 forKey:@"FormPlatform"];
    
    [self sendRequestHttp:url parameters:lastdic Success:^(NSDictionary *dicData) {
    if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]||[dicData[@"OMsg"][@"Flag"]isEqualToString:@"SUCCESS"]){
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic addEntriesFromDictionary:[dicData objectForKey:[NSString stringWithFormat:@"%@",title]]];
        [dic setValue:dicData[@"Token"] forKey:@"Token"];
        [dic setValue:dicData[@"OMsg"][@"Flag"] forKey:@"Flag"];
        successBlock(dic);
        }else{
            successBlock(dicData[@"OMsg"]);
        }
    } Failuer:^(NSString *errorInfo) {
        failuerBlock(errorInfo);
    }];
}
@end
