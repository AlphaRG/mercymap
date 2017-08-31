//
//  CreateMapTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/6/22.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "CreateMapTableViewCell.h"
#import "ButtonAdd.h"



@interface CreateMapTableViewCell ()<UITextFieldDelegate>
{
    
}

@end

@implementation CreateMapTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:NO];
    
}

-(void)getinfo:(MAMapView *)mapView{
    _mapView = mapView;
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;

    _mapView.delegate =self;
    _mapView.mapType = MAMapTypeStandard;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    [_mapView setZoomLevel:16.1 animated:YES];
    
    self.createmapTextfield.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"Address"];
    self.Mlocation               =[[NSUserDefaults standardUserDefaults]objectForKey:@"LocationAdress"];

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lPress:)];
    
    longPress.minimumPressDuration = 0.4;
    longPress.allowableMovement = 10.0;
    [_mapView addGestureRecognizer:longPress];
    
    UIButton *ClickBtn  = [[UIButton alloc]initWithFrame:CGRectMake(20, self.createmapView.bounds.size.height-60, 30, 30)];
    [ClickBtn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    ClickBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"location.png"]];
    [_mapView addSubview:ClickBtn];
    
    [self.createmapView addSubview:_mapView];
    self.createmapTextfield.delegate = self;
}

-(void)lPress:(UILongPressGestureRecognizer *)gestureRecongnizer{
    [_mapView removeAnnotations:_mapView.annotations];
    if (gestureRecongnizer.state == UIGestureRecognizerStateEnded){
        
        CGPoint touchPoint = [gestureRecongnizer locationInView:_mapView];
        
        CLLocationCoordinate2D touchMapCoordinate =
        [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
        pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = touchMapCoordinate;
        [_mapView addAnnotation:pointAnnotation];
    }
}

-(void)BtnClick{
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}

- (IBAction)searchBtnClick:(id)sender {
    
    ButtonAdd *length = [[ButtonAdd alloc]init];
    
    if ([length checkInput:_createmapTextfield.text])
        
    {
        [CommoneTools alertOnView:self content:@"请填写完整"];
    }
    else
    {
        [self getLocation];
    }


}


-(void)getLocation
{
    //构造AMapGeocodeSearchRequest对象，address为必选项，city为可选项
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords =_createmapTextfield.text;
    //    request.city =self.Lightcity.text;
    //关键字搜索
    [_search AMapPOIKeywordsSearch: request];
}


- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [_mapView removeAnnotations:_mapView.annotations];
    if(response.pois.count == 0)
    {
        [CommoneTools alertOnView:self.superview content:@"没有搜索到您的位置"];
        return;
    }
    AMapPOI *p =[response.pois firstObject];
    
    self.location=p.location;
    
    _mapView.delegate =self;
    
    pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.title =_createmapTextfield.text;
    pointAnnotation.coordinate =CLLocationCoordinate2DMake(p.location.latitude,p.location.longitude);
    
    self.Mlocation =[NSString stringWithFormat:@"%f,%f",p.location.latitude,p.location.longitude];
    
    [_mapView setCenterCoordinate:pointAnnotation.coordinate animated:YES];
    [_mapView addAnnotation:pointAnnotation];
    
}


-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    for (UIView *view in mapView.subviews) {
        if ([view isKindOfClass:[MAPinAnnotationView class]]) {
            [view removeFromSuperview];
        }
    }
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;    //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;     //设置标注动画显示，默认为NO
        annotationView.draggable = YES;       //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}


-(void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState
{
    
    if (newState == MAAnnotationViewDragStateEnding)
    {
        //        _isSearchFromDragging = YES;
        //        self.annotation = view.annotation;

        CLLocationCoordinate2D coordinate = view.annotation.coordinate;
        
        [self searchReGeocodeWithCoordinate:coordinate];
    }
    
}



- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension            = YES;
    
    [_search AMapReGoecodeSearch:regeo];
}

//逆地理编码回调

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil )
    {
        //        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
        
        pointAnnotation.coordinate =CLLocationCoordinate2DMake(request.location.latitude,request.location.longitude);
        pointAnnotation.title = [NSString stringWithFormat:@"%@%@",response.regeocode.addressComponent.streetNumber.street,response.regeocode.addressComponent.streetNumber.number];
        
        self.createmapTextfield.text = pointAnnotation.title;
        self.Mlocation =[NSString stringWithFormat:@"%f,%f",request.location.latitude,request.location.longitude];
        [_mapView setCenterCoordinate:pointAnnotation.coordinate animated:YES];
        [_mapView addAnnotation:pointAnnotation];
        
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}


- (NSMutableArray *)ArrayPoint{
        if (_ArrayPoint == nil) {
            _ArrayPoint = [NSMutableArray arrayWithCapacity:0];
        }
        return _ArrayPoint ;
}
@end
