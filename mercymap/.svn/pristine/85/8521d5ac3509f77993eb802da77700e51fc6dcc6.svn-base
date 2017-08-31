//
//  LocationMapViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/9/1.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LocationMapViewController.h"
#import "MapViewModel.h"
@interface LocationMapViewController ()<MAMapViewDelegate,AMapSearchDelegate>
{
    AMapSearchAPI *_search;
    MAMapView     *_MapView;
    UIButton      *_centerBtn;
}

@end

@implementation LocationMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"地点选择";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    
    _centerBtn = [[UIButton alloc]initWithFrame:CGRectMake(kSCREENWIDTH/2-15,(kSCREENHEIGTH-108)/2-15, 30, 30)];
    _centerBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"position.png"]];
    
    UIButton *locationBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, kSCREENHEIGTH-180, 30, 30)];
    locationBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"location.png"]];
    [locationBtn addTarget:self action:@selector(locationLocal) forControlEvents:UIControlEventTouchUpInside];
    
    _MapView = [[MAMapView alloc]initWithFrame:CGRectMake(0,0, kSCREENWIDTH, kSCREENHEIGTH-108)];
    [_MapView setZoomLevel:16.1 animated:YES];
    _MapView.delegate = self ;
    _MapView.mapType = MAMapTypeStandard;
    _MapView.userTrackingMode = MAUserTrackingModeFollow;
    _MapView.showsUserLocation = YES;
    _MapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    [_MapView addSubview:locationBtn];
    [_MapView addSubview:_centerBtn];
    [self.locationMapView addSubview:_MapView];
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
   [ _MapView setCenterCoordinate:_center animated:YES];
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay{
    if (overlay == mapView.userLocationAccuracyCircle){
        MACircleView *accuracyCircleView = [[MACircleView alloc]initWithCircle:mapView.userLocationAccuracyCircle];
        accuracyCircleView.lineWidth    = 2.f;
        accuracyCircleView.strokeColor  = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.0];
        accuracyCircleView.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.0];
        return accuracyCircleView;
    }
    return nil;
}

-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if (annotation == mapView.userLocation) {
        MAAnnotationView *annotationView = [[MAAnnotationView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    AMapReGeocodeSearchRequest *Request = [[AMapReGeocodeSearchRequest alloc]init];
    AMapGeoPoint *location = [[AMapGeoPoint alloc]init];
    CLLocationCoordinate2D MapCoordinate =
    [_MapView convertPoint:_centerBtn.center toCoordinateFromView:_MapView];
    location.latitude =  MapCoordinate.latitude;
    location.longitude = MapCoordinate.longitude;
    Request.location = location;
    Request.requireExtension = YES;
    [_search AMapReGoecodeSearch:Request];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    if (response.regeocode != nil ){
        self.locationAdress.text = [NSString stringWithFormat:@"%@%@%@%@",response.regeocode.addressComponent.district,response.regeocode.addressComponent.township,response.regeocode.addressComponent.streetNumber.street,response.regeocode.addressComponent.streetNumber.number];
    }
}

-(void)navLeftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)commitBtn:(id)sender {
    locationMapViewModel *model = [[locationMapViewModel alloc]init];
    model.locationText =  self.locationAdress.text;
    model.Molocation   =[NSString stringWithFormat:@"%f,%f",_MapView.centerCoordinate.latitude,_MapView.centerCoordinate.longitude];
    if (model) {
        self.sendAdres(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)locationLocal{
    _MapView.userTrackingMode = MAUserTrackingModeFollow;
    _MapView.showsUserLocation = YES;
    _MapView.customizeUserLocationAccuracyCircleRepresentation = YES;
}
@end
