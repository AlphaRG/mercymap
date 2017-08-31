//
//  LocationMapViewController.h
//  MercyMap
//
//  Created by sunshaoxun on 16/9/1.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "MapModel.h"
@class locationMapViewModel;

@interface LocationMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MAMapView *locationMapView;

- (IBAction)commitBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *locationAdress;
@property(nonatomic,copy)void(^sendAdres)(locationMapViewModel *model);

@property(nonatomic)CLLocationCoordinate2D center;
@end
