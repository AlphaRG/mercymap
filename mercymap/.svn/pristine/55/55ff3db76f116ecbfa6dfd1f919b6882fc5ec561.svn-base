//
//  WalkMapTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/9/16.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "WalkMapTableViewCell.h"
#import "UIButton+WebCache.h"
#import "YCXMenu.h"
@implementation WalkMapTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.mapView];
        [self.mapView addSubview:self.timeChoose];
    }
    return self;
}

-(MAMapView *)mapView{
  if (_mapView ==nil) {
      _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds))];
      _mapView.delegate = self;
     _mapView.mapType = MAMapTypeStandard;
     _mapView.showsScale = NO;
      CLLocationCoordinate2D center =CLLocationCoordinate2DMake(33.39,107.40);
      [_mapView setCenterCoordinate:center animated:YES];
    [_mapView setZoomLevel:4 animated:YES];
    }
    return _mapView;
}

-(void)sendDataMapView:(NSMutableArray *)dataArray{
    finallyArray = [NSMutableArray arrayWithCapacity:0];
    [finallyArray addObjectsFromArray:dataArray];
    for(i =0;i<dataArray.count;i++){
        if (![dataArray[i][@"ShopGPS"]isKindOfClass:[NSNull class]]){
            MapViewModel *annotation = [[MapViewModel alloc] init];
            NSString *str =dataArray[i][@"ShopGPS"];
            NSArray *array = [str componentsSeparatedByString:@","];
            annotation.title =dataArray[i][@"ShopName"];
            annotation.image = [UIImage imageNamed:@"walk"];
            annotation.subtitle = [NSString stringWithFormat:@"签到数：%d",[dataArray[i][@"SignInCount"] intValue]];
            float latitude = [array[0] floatValue];
            float longitude =[array[1] floatValue];
            annotation.coordinate =CLLocationCoordinate2DMake(latitude ,longitude);
            [_mapView addAnnotation:annotation];
        }
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MapViewModel class]]){
        static NSString *animatedAnnotationIdentifier = @"AnimatedAnnotationIdentifier";
        MAPinAnnotationView  *annotationView = (MAPinAnnotationView  *)[mapView dequeueReusableAnnotationViewWithIdentifier:animatedAnnotationIdentifier];
        if (annotationView == nil){
            annotationView = [[MAPinAnnotationView  alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:animatedAnnotationIdentifier];
            annotationView.animatesDrop     = NO;
            annotationView.canShowCallout   = YES;
            annotationView.highlighted      = YES;
        }
        annotationView.annotation = annotation;
        annotationView.image      = ((MapViewModel *)annotation).image;//设置大头针视图的图片
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    _Mapcoordinate =view.annotation.coordinate;
}

-(void)timeClickAction{
    [YCXMenu setTintColor:[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:0.5]];
    if ([YCXMenu isShow]){
        [YCXMenu dismissMenu];
    } else {
        [YCXMenu showMenuInView:self fromRect:CGRectMake(self.frame.size.width-20,50,0,0) menuItems:self.timeitems selected:^(NSInteger index, YCXMenuItem *item) {
            if (item.tag == 100) {
                [_timeChoose setTitle:@"今天" forState:UIControlStateNormal];
                [self.walkdelegate sendtime:1];
            }
            if(item.tag ==101){
                [_timeChoose setTitle:@"一周" forState:UIControlStateNormal];
                [self.walkdelegate sendtime:7];
            }
            if (item.tag ==102) {
                [_timeChoose setTitle:@"一月" forState:UIControlStateNormal];
                [self.walkdelegate sendtime:30];
            }
        }];
    }
}

-(UIButton *)timeChoose{
    if (_timeChoose == nil) {
        _timeChoose = [[UIButton alloc]initWithFrame:CGRectMake(kSCREENWIDTH-50, 20, 30, 30)];
        _timeChoose.backgroundColor = [UIColor redColor];
        [_timeChoose setTitle:@"一月" forState:UIControlStateNormal];
        _timeChoose.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_timeChoose addTarget:self action:@selector(timeClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeChoose;
}

-(NSMutableArray *)timeitems {
    if(!_timeitems) {
        _timeitems = [NSMutableArray array];
        _timeitems = [@[
                        [YCXMenuItem menuItem:@"今天"
                                        image:[UIImage imageNamed:@""]
                                          tag:100 fag:2
                                     userInfo:@{@"title":@"Menu"}],
                        [YCXMenuItem menuItem:@"一周"
                                        image:[UIImage imageNamed:@""]
                                          tag:101 fag:2
                                     userInfo:@{@"title":@"Menu"}],
                        [YCXMenuItem menuItem:@"一月"
                                        image:[UIImage imageNamed:@""]
                                          tag:102 fag:2
                                     userInfo:@{@"title":@"Menu"}],
                        ] mutableCopy];
    }
    return _timeitems;
}
@end
