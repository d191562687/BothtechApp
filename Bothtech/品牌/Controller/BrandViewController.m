//
//  BrandViewController.m
//  Bothtech
//
//  Created by lanhull on 15/12/25.
//  Copyright © 2015年 Andrés Brun. All rights reserved.
//

#import "BrandViewController.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImage+UIImageExtras.h"
#import "Reads.h"
#import "ViewController.h"
#import "ProfileViewController.h"



@interface BrandViewController ()
{
    
    UIImageView * ImageBackView;
    
    
    //拖过来的
    NSMutableArray *_Imagearray;
    NSMutableArray *_photos;
    
    UIScrollView *_scrollView;//图片展示滚动视图
    UIScrollView *_myScrollView;
    
    UIImageView *_imageview;
    
    int _BtnW;
    int _BtnWS;
    int _BtnX;
    int _BtnH;
    
    int _getEndImageYH;
    
    
    UILabel *_Titlelabel;
    
    
    UIButton *_imageButton;
}
#define NavgationBarH 64


@end

@implementation BrandViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        
    }
    
    return self;
    //To change the template use AppCode | Preferences | File Templates.
}

- (id)initViewController
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [[BrandViewController alloc] initWithNibName:@"BrandViewController" bundle:nil];
        
    }
    
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    [self initDataSource];
    
    [self didApper];
    
    
    
    //双击返回
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
    
    
    
}


-(void)dealTap:(UITapGestureRecognizer *)tap
{
    
    
    ProfileViewController * webVC = [[ProfileViewController alloc] initViewController];
    [self.navigationController pushViewController:webVC animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didApper{
    _myScrollView.frame = CGRectMake(0, 0, 1024, 768);
    NSLog(@"w = %f h = %f",SIZE.width,SIZE.height);
    
    _myScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 4 ,self.view.frame.size.height);
    _myScrollView.frame = CGRectMake(0, 0, 1024, 768);
    _myScrollView.pagingEnabled = YES;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    NSLog(@"两个要不一样啊  %f",SIZE.width);
    [self Hengping];
    
    [self.view addSubview:_myScrollView];
    
}


-(void)initDataSource
{
    
    _user = [NSUserDefaults standardUserDefaults];
    
    _myScrollView = [[UIScrollView alloc] init];
    [self.view addSubview: _myScrollView];
    
    
}

-(void)LayoutImage1:(int)NUM
{
    for (UIView * view  in _myScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    
    
    Reads *read = [[Reads alloc]init];
    
    int BtnHS = 50;
    int BtnY = 55;
    
    int i = 0;
    for (i = 0; i <[[read ImageArray] count]; i++ ){
        
        
        _imageview.backgroundColor = [UIColor blueColor];
        
        
        //获得图片数组中的第一个图   --- ---
        NSString *Pa = [NSString stringWithFormat:@"%@0",[read ImageMethod:i]];
        
        
        [_imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)]];
        
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageButton.frame = CGRectMake( (_BtnW+_BtnWS) * (i%NUM) + _BtnX +5, (_BtnH+BtnHS) *(i/NUM) + BtnY, _BtnW, _BtnH );
        [_imageButton addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _imageButton.tag = 10000+i;
        [_imageButton addSubview:_imageView];
        [_imageButton setBackgroundColor:[UIColor clearColor]];
        [_imageButton setBackgroundImage:[UIImage imageNamed:Pa] forState:UIControlStateNormal];
        [_myScrollView addSubview:_imageButton];
        
        
        
        [self TitleLabel:i];
    }
    _getEndImageYH = (_BtnH+BtnHS) *(i/NUM) + BtnY ;
    
}


//TitleLabel
-(void)TitleLabel:(int)number
{
    Reads *read = [[Reads alloc]init];
    float x = _imageButton.frame.origin.x ;
    float y = _imageButton.frame.origin.y ;
    
    _Titlelabel = [[UILabel alloc] init];
    _Titlelabel.frame = CGRectMake(x, y+_imageButton.frame.size.height + 3 , 270, 30);
    _Titlelabel.text = [read ImageArray][number];
    _Titlelabel.textColor = [UIColor clearColor];
    _Titlelabel.textAlignment = NSTextAlignmentCenter;
    _Titlelabel.font = [UIFont fontWithName:@"Helvetica" size:24];
    
    [_myScrollView addSubview:_Titlelabel];
}


//检测设备旋转方向

- (BOOL)shouldAutorotate{
    
    return YES;
}

-(void)hengshu
{
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight || self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self Shuping];
    }else {
        //纵向执行
        //竖屏view显示方法
        [self Hengping];
    }
    
}


#pragma mark - 点击跳转
-(void)BtnClick:(UIButton *)imageTap
{
    
    // 1.封装图片数据
    
    Reads *read = [[Reads alloc]init];
    NSUInteger count = [[read Zilei:(imageTap.tag - 10000.0)] count];
    
    NSMutableArray *img = [[NSMutableArray alloc] init];
    _photos = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *path = [read Zilei:(imageTap.tag - 10000.0)][i];
        
        [img addObject:path];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = _photos; // 设置所有的图片
    
    
    // 图片跳转按钮
//    ImageTestViewController *ivc = [[ImageTestViewController alloc] init];
//    
//    ivc.imageArray = img ;
//    ivc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    NSLog(@"%d",_photos.count);
//    [self.navigationController pushViewController:ivc animated:YES];

    
    
    //
    //    [self presentViewController:ivc animated:YES completion:nil];
    //
    //    [self removeAllFromKeyWindow];
    //    [self removeAllFromView];
    
    
    
}

#pragma mark - 横竖屏方法
//测试
-(void)hengpingTest{
    _BtnW = 170;//宽
    _BtnWS = 30;//左右间距
    _BtnX = 20;//x
    _BtnH = 130;//高
    [self LayoutImage1:5];
    
}

-(void)shupingTest{
    _BtnW = 170;//宽
    _BtnWS = 20;//左右间距
    _BtnX = 10;//x
    _BtnH = 130;//高
    [self LayoutImage1:4];
    
}

//
-(void)Hengping
{
    
    _BtnW = 280;//宽
    _BtnWS = 60;//左右间距
    _BtnX = 30;//x
    _BtnH = 120;//高
    
    [self LayoutImage1:7];
}

-(void)Shuping
{
    _BtnW = 170;//宽            SIZE.width/5
    _BtnWS = 20;//左右间距       SIZE.width/5*(2/13)
    _BtnX = 10;//x
    _BtnH = 130;//高
    [self LayoutImage1:4];
    
    
    
}







#pragma mark - SLCoverFlowViewDataSource




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}




- (void)reload{
    
    
}

@end
