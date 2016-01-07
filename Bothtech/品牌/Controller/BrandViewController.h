//
//  BrandViewController.h
//  Bothtech
//
//  Created by lanhull on 15/12/25.
//  Copyright © 2015年 Andrés Brun. All rights reserved.
//

#import "ViewController.h"
#import "RCDraggableButton.h"

@interface BrandViewController : UIViewController<UIWebViewDelegate>
{
    
    IBOutlet UIView * _webView;
    
    
    NSUserDefaults *_user;
    UIImageView *_Backimage;//背景图片
    
    int _i;
    
    NSMutableArray *_FenUrlArray;//存储分类‘url’
    NSMutableArray *_UrlArray;//存储子图片‘url’
    NSMutableArray *_Array;//存储‘name’
    NSArray *_DataArray;//存储所有数据数组
    UIImageView *_imageView;//最底层image
    //    UIImageView *_imageView1;//
    UIImage *_placeholder;//
    NSMutableArray *_Array1;
    
    UIActivityIndicatorView *_activityIndicator;//活动指示器
    UIView *_BackView;//活动指示器背景
    
}
- (id)initViewController;
@property(nonatomic,retain)UIImageView *imageView1;

@end
