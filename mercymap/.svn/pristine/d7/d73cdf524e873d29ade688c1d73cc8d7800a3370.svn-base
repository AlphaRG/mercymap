//
//  CreateLightTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/8/24.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "CreateLightTableViewCell.h"

@implementation CreateLightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)createCell:(NSString *)cellname tag:(int)tag
{
    self.vertical.hidden = YES;
    self.locationBtn.hidden = YES;
    self.lightInfoName.text = cellname;
    if (tag ==1) {
        self.lightInfoTextfield.placeholder = @"请输入店家名称";
        self.lightInfoTextfield.tag = tag;
    }
    else if (tag ==2){
//      self.lightInfoTextfield.placeholder = @"请填写有效地址";
        self.lightInfoTextfield.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Address"];
        self.lightInfoTextfieldTrailing.constant = 68;
        self.locationBtn.hidden = NO;
        self.vertical.hidden         = NO;
        self.lightInfoTextfield.tag = tag;
    }
    else if (tag ==3) {
        self.lightInfoTextfield.placeholder = @"请选择分类";
        self.lightInfoTextfieldTrailing.constant = 20;
        self.lightInfoTextfield.textAlignment = NSTextAlignmentRight ;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.lightInfoTextfield.tag = tag;
    }
    else if (tag ==4){
        self.lightInfoTextfield.placeholder = @"请填写正确的手机号码";
        self.lightInfoTextfield.textAlignment = NSTextAlignmentLeft ;
        
        self.accessoryType = UITableViewCellAccessoryNone;
        self.lightInfoTextfield.tag = tag;
    }
    else{
        self.lightInfoTextfield.placeholder = @"请添加营业时间";
        self.lightInfoTextfield.textAlignment = NSTextAlignmentRight ;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.lightInfoTextfield.tag = tag;
    }
}
- (IBAction)locationBtnClick:(id)sender {
    [self.delegate sendLocationView];
}
@end
