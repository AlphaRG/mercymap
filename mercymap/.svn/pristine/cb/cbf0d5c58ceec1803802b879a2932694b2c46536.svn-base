//
//  ZLThumbnailViewController.h
//  多选相册照片
//
//  Created by long on 15/11/30.
//  Copyright © 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAssetCollection;
@class ZLSelectPhotoModel;
@class ZLPhotoBrowser;

@interface ZLThumbnailViewController : UIViewController

@property (nonatomic, assign) NSInteger tag;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//相册属性
@property (nonatomic, strong) PHAssetCollection *assetCollection;

//当前已经选择的图片
@property (nonatomic, strong) NSMutableArray<ZLSelectPhotoModel *> *arraySelectPhotos;
@property (nonatomic, strong) NSMutableArray<ZLSelectPhotoModel *> *SelectPhotos;


//最大选择数
@property (nonatomic, assign) NSInteger maxSelectCount;

//用于回调上级列表，把已选择的图片传回去
@property (nonatomic, weak) ZLPhotoBrowser *sender;

//选则完成后回调
@property (nonatomic, copy) void (^DoneBlock)(NSArray<ZLSelectPhotoModel *> *);
//选则完成后回调
@property (nonatomic, copy) void (^DoneCustomBackBlock)(NSArray<ZLSelectPhotoModel *> *);
//取消选择后回调
@property (nonatomic, copy) void (^CancelBlock)();

@end
