//
//  payViewController.m
//  MercyMap
//
//  Created by RainGu on 16/11/25.
//  Copyright © 2016年 Wispeed. All rights reserved.
#import "payViewController.h"
#import "PayTableViewCell.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataMD5.h"
#import "LoginService.h"
#import "Single.h"
#import "Order.h"
#import "UPPaymentControl.h"
typedef enum{
    PayWayWechat  =0,
    PayWayAlipay  =1,
    PayWayUnion   =2,
} PayWayInfo;
@interface payViewController ()<submitPayInfoDelegate>{
    PayTableViewCell * _paycell;
    PayWayInfo         _paywayinfo;
    NSMutableDictionary *_dataDic;
    LoginService        *_serVice;
    Single              *_single;
    NSString            *orderInfoEncoded;
}
@end

@implementation payViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:@[@"PayTableViewCell"]];
    self.title =  @"支付";
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    _serVice = [[LoginService alloc]init];
    _dataDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(naveLeftBtnClick)];
    _single = [Single Send];
}

-(void)naveLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSCREENHEIGTH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    PayTableViewCell *paycell = [tableView dequeueReusableCellWithIdentifier:@"PayTableViewCell" forIndexPath:indexPath];
    paycell.payHeadName.text = self.payName;
    NSString *imgS =[self.payImg stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [paycell.payHeadImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",URLM,imgS]]];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payAction:)];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payAction:)];
     UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payAction:)];
    [paycell.wechatView addGestureRecognizer:tapGesture];
    [paycell.alipayView addGestureRecognizer:tapGesture2];
    //银联支付
    [paycell.unionpayView addGestureRecognizer:tapGesture3];
    [paycell.unionpayView setHidden:YES];
    
    paycell.payWay.selected = YES;
    paycell.delegate = self;
    _paycell = paycell;
    cell = paycell;
   [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)payAction:(UITapGestureRecognizer *)tap{
   NSInteger tag = tap.view .tag;
    switch (tag) {
        case 1:
            _paycell.payWay.selected       = YES;
            _paycell.payWayalipay.selected = NO;
            _paycell.unionpayway.selected  = NO;
            _paywayinfo = PayWayWechat;
            break;
        case 2:
            _paycell.payWayalipay.selected = YES;
            _paycell.payWay.selected       = NO;
            _paycell.unionpayway.selected  = NO;
            _paywayinfo =  PayWayAlipay ;
            break;
        case 3:
            _paycell.unionpayway.selected  = YES;
            _paycell.payWay.selected       = NO;
            _paycell.payWayalipay.selected = NO;
            _paywayinfo = PayWayUnion;
            break;
        default:
            break;
    }
}

-(void)submitPayInfo{
    switch (_paywayinfo) {
        case 0:
            [self wechatPay];
            break;
        case 1:
            [self  aliPay];
            break;
        case 2:
            [self unionpay];
            break;
        default:
            break;
    }
}

-(void)wechatPay{
    NSDictionary *dic;
    NSString *strName = [[UIDevice currentDevice]name];
    NSString *strSysName =[[UIDevice currentDevice]systemName];
    NSString *phoneModel = [[UIDevice currentDevice]model];
    NSString *device  = [NSString stringWithFormat:@"%@,%@,%@",strName,strSysName,phoneModel];
    int moneynum = _paycell.payNum.text.floatValue *100;
    NSNumber *money = [NSNumber numberWithInt:moneynum];
    NSString *payurl =[[NSUserDefaults standardUserDefaults]objectForKey:@"PayURL"];
    NSNumber *userid =[NSNumber numberWithInt:_single.ID];
    NSNumber *shopid = [NSNumber numberWithInt:_payID];
    
    NSString *url  =[NSString stringWithFormat:@"%@api/pay/UnifiedOrder?body=%@&totalfee=%d&appid=%@&userID=%@&shopID=%@&device_info=%@&attach=%@",payurl,self.payName,moneynum,@"wx7a811780f82a006e",userid,shopid,device,shopid];
    NSString *URL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    dic =@{@"body":[NSString stringWithFormat:@"%@",self.payName],@"totalfee":money,@"appid":@"wx7a811780f82a006e",@"userID":userid,@"shopID":shopid,@"device_info":device,@"attach":shopid};
    [self getPayInfofromService:URL Dic:dic fag:1];
}

-(void)aliPay{
    Order* order = [Order new];
    // NOTE: app_id设置*
    order.app_id = @"2016111602874881";
    // NOTE: 支付接口名称 *
    order.method = @"alipay.trade.app.pay";
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    // NOTE: 当前时间点*
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time  = [formatter stringFromDate:[NSDate date]];
    order.timestamp = time ;
    // NOTE: 支付版本 *
    order.version = @"1.0";
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    order.notify_url = @"http://1u454a6459.imwork.net:5511/api/AliPay/NotifyUrl/1";
    // NOTE: 商品数据 *
    order.biz_content = [BizContent new];
    order.biz_content.subject = self.payName;//商品名或店家名
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = _paycell.payNum.text; //商品价格
    order.biz_content.seller_id = @"zj@wispeed.com";
    
    NSNumber *totalfeeN = [NSNumber numberWithInt:[_paycell.payNum.text intValue]];
    NSNumber *userIDN   =  [NSNumber numberWithInt:_single.ID];
    NSNumber *shopIDN   = [NSNumber numberWithInt:_payID];
    NSNumber *payTypeN  = [NSNumber numberWithInt:1];
    
    NSString *sorturl = [[NSString stringWithFormat:@"%@api/order/GenerateOutTradeNo?totalFee=%@&body=%@&userID=%@&shopID=%@&payType=%@",URLM,totalfeeN,self.payName,userIDN,shopIDN,payTypeN] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *sortdic =@{@"totalFee":totalfeeN,@"body":self.payName,@"userID":userIDN,@"shopID":shopIDN,@"payType":payTypeN};
    
    [_serVice GetSort:sorturl parameters:sortdic Success:^(NSDictionary *successInfo){
        //将商品信息拼接成字符串
        order.biz_content.out_trade_no = successInfo[@"order"][@"OutTradeNo"]; //订单ID（由商家自行制定）
        orderInfoEncoded = [order orderInfoEncoded:YES];
        NSString *orderInfo = [order orderInfoEncoded:NO];
        NSString *payurl =[[NSUserDefaults standardUserDefaults]objectForKey:@"PayURL"];
        NSString *url = [NSString stringWithFormat:@"%@api/AliPay/SignaturesUrl",payurl];
        NSDictionary *dic =@{@"param":orderInfo};
        [self getPayInfofromService:url Dic:dic fag:2];
    } Failuer:^(NSString *errorInfo) {
        
    }];
}

-(void)unionpay{
    NSString *urlString  =@"http://101.231.204.84:8091/sim/getacptn";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString* pay = [[NSMutableString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    [[UPPaymentControl defaultControl] startPay:pay fromScheme:@"UPPay" mode:@"01" viewController:self];
}

-(void)getPayInfofromService:(NSString *)url Dic:(NSDictionary *)dic fag:(int)fag{
    [_serVice getDicData:url Dic:dic Title:@"return_info" SuccessBlock:^(NSMutableDictionary *dic) {
        [_dataDic removeAllObjects];
        [_dataDic addEntriesFromDictionary:dic];
        switch (fag) {
            case 1:
                [self wechatpayapp];
                break;
            case 2:
                [self alipayapp];
                break;
            default:
                break;
        }
    } FailuerBlock:^(NSString *str){
        [CommoneTools alertOnView:self.view content:str];
    }];
}

-(void)wechatpayapp{
    PayReq* req   = [[PayReq alloc]init];
    if (_dataDic.count != 0) {
        _single.payResult = _dataDic[@"out_trade_no"];
        req.partnerId = [_dataDic objectForKey:@"partnerid"];
        req.package   = @"Sign=WXPay";
        req.prepayId  = [_dataDic objectForKey:@"prepayid"];
        NSString *timestamp = [_dataDic objectForKey:@"timestamp"];
        req.timeStamp = timestamp.intValue;
        req.nonceStr  = [_dataDic objectForKey:@"noncestr"];
        req.sign      = [_dataDic objectForKey:@"sign"];
        [WXApi sendReq:req];
    }else{
        [CommoneTools alertOnView:self.view content:@"网络连接有问题"];
    }
}

-(void)alipayapp{
    if (_dataDic.count != 0) {
        NSString *appScheme = @"ali2016111602874881";
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded,_dataDic[@"return_url"]];
       [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic){
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}

//支付宝创建商品订单
- (NSString *)generateTradeNO{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++){
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
