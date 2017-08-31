//
//  SYMDateView.m
//  MercyMap
//
//  Created by zhangshupeng on 16/7/10.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "SYMDateView.h"

@interface SYMDateView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    
}
@property (nonatomic, strong) UIPickerView *startTime;
@property (nonatomic, strong) UIPickerView *endTime;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation SYMDateView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
        self.backgroundView.frame = CGRectMake(0, kSCREENHEIGTH - 200, kSCREENWIDTH, 200);
        [self addSubview:self.backgroundView];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, kSCREENWIDTH/2, 20)];
        label.text = @"开始";
        label.textAlignment = 1;
        [self.backgroundView addSubview:label];
        self.startTime.frame = CGRectMake(20, label.frame.origin.y + label.frame.size.height + 10, kSCREENWIDTH/2 - 40, 100);
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kSCREENWIDTH/2, 40, kSCREENWIDTH/2, 20)];
        label2.text = @"结束";
        label2.textAlignment = 1;
        [self.backgroundView addSubview:label2];
        self.endTime.frame =CGRectMake(kSCREENWIDTH/2 + 20, label2.frame.origin.y + label2.frame.size.height + 10, kSCREENWIDTH/2 - 40, 100);
        [self.backgroundView addSubview:self.startTime];
        [self.backgroundView addSubview:self.endTime];
        UIButton * button = [UIButton buttonWithType:0];
        [button setTitleColor:[UIColor colorWithRed:40/255.0 green:148/255.0 blue:250/255.0 alpha:1] forState:UIControlStateNormal];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 5, 60, 20);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:button];
    
        UIButton * button2 = [UIButton buttonWithType:0];
        [button2 setTitleColor:[UIColor colorWithRed:40/255.0 green:148/255.0 blue:250/255.0 alpha:1] forState:UIControlStateNormal];
        button2.tag = 1;
        [button2 setTitle:@"确定" forState:UIControlStateNormal];
        button2.frame = CGRectMake(kSCREENWIDTH - 60, 5, 60, 20);
        [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:button2];
    }
    return self;
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag == 0) {
        [self removeFromSuperview];
    }else{
        if(self.workTime){
            NSInteger h1 = [self.startTime selectedRowInComponent:0];
            NSInteger m1 = [self.startTime selectedRowInComponent:1];
            NSInteger h2 = [self.endTime selectedRowInComponent:0];
            NSInteger m2 = [self.endTime selectedRowInComponent:1];
            self.workTime(@{@"amhour":@(h1),@"ammin":@(m1),@"pmhour":@(h2),@"pmmin":@(m2)});
        }
         [self removeFromSuperview];
    }
}

- (void)show:(NSMutableArray *)timeArray{
    if(timeArray.count ==4){
    [self.startTime selectRow:[timeArray[0] intValue ] inComponent:0 animated:YES];
    [self.startTime selectRow:[timeArray[2] intValue ] inComponent:1 animated:YES];
    [self.endTime   selectRow:[timeArray[1] intValue ] inComponent:0 animated:YES];
    [self.endTime   selectRow:[timeArray[3] intValue ] inComponent:1 animated:YES];
    }
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    self.frame = window.bounds;
    [window addSubview:self];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0){
        return 24;
    }
    else{
        return 60;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
//        if ([pickerView isEqual:_startTime]) {
            if(row<10){
                return [NSString stringWithFormat:@"0%ld",row];
            }
            else{
             return [NSString stringWithFormat:@"%ld",row];
            }
//        }
//        return [NSString stringWithFormat:@"%ld",row + 12];
    }
    else
    {
        if(row<10){
            return [NSString stringWithFormat:@"0%ld",row];
        }
        else{
            return [NSString stringWithFormat:@"%ld",row];
        }
    }
}

//- (NSDate *)dealDate:(NSDate *)date{
//    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekOfMonthCalendarUnit | NSWeekOfYearCalendarUnit fromDate:date];
//    NSDate * date2 = [NSDate dateWithTimeInterval:-componets.hour*60*60-componets.minute*60-componets.second sinceDate:date];
//    return date2;
//}

- (UIPickerView *)startTime{
    if (_startTime == nil) {
        _startTime = [[UIPickerView alloc]init];
        _startTime.delegate = self;
    }
    return _startTime;
}

- (UIPickerView *)endTime{
    if (_endTime == nil) {
        _endTime = [[UIPickerView alloc]init];
        _endTime.delegate = self;
    }
    return _endTime;
}

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]init];
        _backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backgroundView;
}

@end
