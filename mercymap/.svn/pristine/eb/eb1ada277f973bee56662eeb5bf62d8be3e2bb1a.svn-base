//
//  MM2DbarcodePicture.h
//  MercyMap
//
//  Created by RainGu on 17/2/17.
//  Copyright © 2017年 Wispeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MM2DbarcodePicture : NSObject
+(UIImage *)createQRimageString:(NSString *)QRString sizeWidth:(CGFloat)sizeWidth fillColor:(UIColor *)color;
+ (CIImage *)createQRForString:(NSString *)qrString ;

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

+(NSString *)readQRCodeFromImage:(UIImage *)image;
@end
