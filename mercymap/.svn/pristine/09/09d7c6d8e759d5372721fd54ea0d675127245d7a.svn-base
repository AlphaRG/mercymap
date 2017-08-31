//
//  ZLShowBigImgViewController.m
//  多选相册照片
//
//  Created by long on 15/11/25.
//  Copyright © 2015年 long. All rights reserved.
//

#define kViewWidth      [[UIScreen mainScreen] bounds].size.width
//如果项目中设置了导航条为不透明，即[UINavigationBar appearance].translucent=NO，那么这里的kViewHeight需要-64
#define kViewHeight     [[UIScreen mainScreen] bounds].size.height

////////ZLPhotoActionSheet
#define kBaseViewHeight 300

////////ZLShowBigImgViewController
#define kItemMargin 30
#import "ZLShowBigImgViewController.h"
#import <Photos/Photos.h>
#import "ZLBigImageCell.h"
#import "ZLSelectPhotoModel.h"
#import "ZLPhotoTool.h"

@interface ZLShowBigImgViewController () <UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
    
    NSMutableArray<PHAsset *> *_arrayDataSources;
    UIButton *_navRightBtn;
    NSMutableArray<NSURL *>*_arrayimageData;
    //双击的scrollView
    UIScrollView *_selectScrollView;
    NSInteger _currentPage;
}
@end

@implementation ZLShowBigImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title =  _titleName;
    
    [self initNavBtns];
    [self sortAsset];
    [self initCollectionView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.shouldReverseAssets) {
        if (self.fag ==1)
        {
            [_collectionView setContentOffset:CGPointMake((self.imageA.count-self.selectIndex-1)*(kViewWidth+kItemMargin), 0)];
        }
        else
        {
        [_collectionView setContentOffset:CGPointMake((self.assets.count-self.selectIndex-1)*(kViewWidth+kItemMargin), 0)];
        }
    }
    else {
        [_collectionView setContentOffset:CGPointMake(self.selectIndex*(kViewWidth+kItemMargin), 0)];
    }
    
    [self changeNavRightBtnStatus];
}

- (void)initNavBtns
{
    //left nav btn
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(btnBack_Click)];
        _navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _navRightBtn.frame = CGRectMake(0, 0,30,30);
    if (_fag==1) {
        
        _navRightBtn.hidden =YES;
    }
    else if (_fag==2)
    {
        [_navRightBtn setTintColor:[UIColor whiteColor]];
        [_navRightBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    else
    {
        
      [_navRightBtn setBackgroundImage:[UIImage imageNamed:@"btn_circle.png"] forState:UIControlStateNormal];
      [_navRightBtn setBackgroundImage:[UIImage imageNamed:@"btn_selected.png"] forState:UIControlStateSelected];
    }
    
    [_navRightBtn addTarget:self action:@selector(navRightBtn_Click:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navRightBtn];
}

#pragma mark - UIButton Actions
- (void)btnBack_Click
{
    if (_fag==1) {
        
    }
    else{
    if (self.onSelectedPhotos) {
        self.onSelectedPhotos(self.arraySelectPhotos);
        }
    
//    if (self.showPopAnimate) {
////        [self.navigationController.view.layer addAnimation:[ZLAnimationTool animateWithType:kCATransitionMoveIn subType:kCATransitionFromBottom duration:0.3] forKey:nil];
//    }
    }
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)navRightBtn_Click:(UIButton *)btn
{
    if (_fag ==1)
    {
        
    }
    else if (self.fag==2)
    {
        
    }
    else
    {
        
    if (_arraySelectPhotos.count >= self.maxSelectCount
        && btn.selected == NO) {
        return;
    }
    PHAsset *asset = _arrayDataSources[_currentPage-1];
    ZLBigImageCell *cell = (ZLBigImageCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentPage-1 inSection:0]];
    if (![self isHaveCurrentPageImage]) {
        
        if (cell.imageView.image == nil) {
            return;
        }
        ZLSelectPhotoModel *model = [[ZLSelectPhotoModel alloc] init];
        model.asset = asset;
        model.image = cell.imageView.image;
        model.imageName = [asset valueForKey:@"filename"];
        [_arraySelectPhotos addObject:model];
    } else {
        [self removeCurrentPageImage];
    }
    
    btn.selected = !btn.selected;
    }
}

- (BOOL)isHaveCurrentPageImage
{
    if (_fag==1) {
        
    }
    else
    {
        
    PHAsset *asset = _arrayDataSources[_currentPage-1];
    for (ZLSelectPhotoModel *model in _arraySelectPhotos) {
        if ([model.imageName isEqualToString:[asset valueForKey:@"filename"]]) {
            return YES;
        }
    }
}
    return NO;
}

- (void)removeCurrentPageImage
{
    if (_fag ==1) {
        
    }
    else{
    PHAsset *asset = _arrayDataSources[_currentPage-1];
    for (ZLSelectPhotoModel *model in _arraySelectPhotos) {
        if ([model.imageName isEqualToString:[asset valueForKey:@"filename"]]) {
            [_arraySelectPhotos removeObject:model];
            break;
        }
    }
    }
}

- (void)changeNavRightBtnStatus
{
    if ([self isHaveCurrentPageImage]) {
        _navRightBtn.selected = YES;
    } else {
        _navRightBtn.selected = NO;
    }
}

- (void)sortAsset
{
    if (_fag==1){
        
        _arrayimageData =[NSMutableArray array];
        
        if (self.shouldReverseAssets) {
            NSEnumerator *enumerator = [self.imageA reverseObjectEnumerator];
            id obj;
            while (obj = [enumerator nextObject]) {
                [_arrayimageData addObject:obj];
            }
            //当前页
            _currentPage = _arrayimageData.count-self.selectIndex;
        }
    
        else {
              [_arrayimageData addObjectsFromArray:self.imageA];
              _currentPage = self.selectIndex + 1;
             }
        self.title = [NSString stringWithFormat:@"%ld/%ld", _currentPage, _arrayimageData.count];
    }
    else{
        
       _arrayDataSources = [NSMutableArray array];
       if (self.shouldReverseAssets) {
        NSEnumerator *enumerator = [self.assets reverseObjectEnumerator];
        id obj;
        while (obj = [enumerator nextObject]) {
            [_arrayDataSources addObject:obj];
        }
        //当前页
        _currentPage = _arrayDataSources.count-self.selectIndex;
    } else {
        [_arrayDataSources addObjectsFromArray:self.assets];
        _currentPage = self.selectIndex + 1;
        }
        self.title = [NSString stringWithFormat:@"%ld/%ld", _currentPage, _arrayDataSources.count];
      }
}

#pragma mark - 初始化CollectionView
- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = kItemMargin;
    layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin/2, 0, kItemMargin/2);
    layout.itemSize = self.view.bounds.size;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-kItemMargin/2, 0, kViewWidth+kItemMargin, kViewHeight) collectionViewLayout:layout];
    [_collectionView registerNib:[UINib nibWithNibName:@"ZLBigImageCell" bundle:nil] forCellWithReuseIdentifier:@"ZLBigImageCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_fag==1) {
        return _arrayimageData.count;
    }
    else
    {
        return _arrayDataSources.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZLBigImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZLBigImageCell" forIndexPath:indexPath];
    if (_fag==1) {
         NSURL  *imageA=_arrayimageData[indexPath.row];
        [cell.imageView sd_setImageWithURL:imageA];
    }
    else
    {
    PHAsset *asset = _arrayDataSources[indexPath.row];
    cell.imageView.image = nil;
    [cell showIndicator];
    [[ZLPhotoTool sharePhotoTool] requestImageForAsset:asset size:PHImageManagerMaximumSize resizeMode:PHImageRequestOptionsResizeModeNone completion:^(UIImage *image) {
        cell.imageView.image = image;
        [cell hideIndicator];
    }];
        
    }
    
    cell.scrollView.delegate = self;
    
    [self addDoubleTapOnScrollView:cell.scrollView];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZLBigImageCell *cell1 = (ZLBigImageCell *)cell;
    cell1.scrollView.zoomScale = 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 图片缩放相关方法
- (void)addDoubleTapOnScrollView:(UIScrollView *)scrollView
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [scrollView addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [scrollView addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap
{
    if (self.navigationController.navigationBar.isHidden) {
        [self showStatusBarAndNavBar];
    } else {
        [self hidStatusBarAndNavBar];
    }
}

- (void)doubleTapAction:(UITapGestureRecognizer *)tap
{
    UIScrollView *scrollView = (UIScrollView *)tap.view;
    _selectScrollView = scrollView;
    CGFloat scale = 1;
    if (scrollView.zoomScale != 3.0) {
        scale = 3;
    } else {
        scale = 1;
    }
    CGRect zoomRect = [self zoomRectForScale:scale withCenter:[tap locationInView:tap.view]];
    [scrollView zoomToRect:zoomRect animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == (UIScrollView *)_collectionView) {
        //改变导航标题
        CGFloat page = scrollView.contentOffset.x/(kViewWidth+kItemMargin);
        NSString *str = [NSString stringWithFormat:@"%.0f", page];
        _currentPage = str.integerValue + 1;
        if (_fag ==1) {
        self.title = [NSString stringWithFormat:@"%ld/%ld", _currentPage, _arrayimageData.count];
 
        }
        else{
            
           self.title = [NSString stringWithFormat:@"%ld/%ld", _currentPage, _arrayDataSources.count];
         }
        [self changeNavRightBtnStatus];
    }
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = _selectScrollView.frame.size.height / scale;
    zoomRect.size.width  = _selectScrollView.frame.size.width  / scale;
    zoomRect.origin.x    = center.x - (zoomRect.size.width  /2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height /2.0);
    return zoomRect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews[0];
}

#pragma mark - 显示隐藏导航条状态栏
- (void)showStatusBarAndNavBar
{
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)hidStatusBarAndNavBar
{
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarHidden = YES;
}

@end
