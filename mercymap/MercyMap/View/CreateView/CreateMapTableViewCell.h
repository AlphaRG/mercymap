//
//  CreateMapTableViewCell.h
//  MercyMap
//
//  Created by sunshaoxun on 16/6/22.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "MapViewSet.h"

@interface CreateMapTableViewCell : UITableViewCell<MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>

{
    UIButton *rightBtn;
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    MAPointAnnotation *pointAnnotation;
}

@property (nonatomic, copy)   AMapGeoPoint *location;

@property(nonatomic,strong)NSString *Mlocation;
@property (nonatomic,strong)NSMutableArray <MAPointAnnotation *> *ArrayPoint;
@property (weak, nonatomic) IBOutlet UIView *createmapView;


@property (weak, nonatomic) IBOutlet UITextField *createmapTextfield;

- (IBAction)searchBtnClick:(id)sender;
-(void)getinfo:(MAMapView *)mapView;

@end
