//
//  UIImage+UIImageExtras.m
//  TianTianShiPin
//
//  Created by bothtech on 14-4-24.
//  Copyright (c) 2014年 bothtech. All rights reserved.
//

#import "UIImage+UIImageExtras.h"

@implementation UIImage (UIImageExtras)

-(UIImage*)imageByScalingToSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaleWidth = targetWidth;
    CGFloat scaleHeight = targetHeight;
    CGPoint thumbailPoint = CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor) {
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
            scaleWidth = width *scaleFactor;
            scaleHeight = height * scaleFactor;
        }
        if (widthFactor > heightFactor) {
            thumbailPoint.y = (targetHeight - scaleHeight) * 0.5;
        }else if (widthFactor > heightFactor){
            thumbailPoint.x = (targetWidth - scaleWidth) *0.5;
            
        }
        UIGraphicsBeginImageContext(targetSize);
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbailPoint;
        thumbnailRect.size.width = scaleWidth;
        thumbnailRect.size.height = scaleHeight;
        [sourceImage drawInRect:thumbnailRect];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (newImage == nil) {
            NSLog(@"could not scale image");
        }
        
    }
    
    
    return newImage;
}
@end
