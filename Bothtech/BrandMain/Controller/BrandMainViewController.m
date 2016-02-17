//
//  BrandMainViewController.m
//  Bothtech
//
//  Created by lanhull on 16/1/14.
//  Copyright © 2016年 Andrés Brun. All rights reserved.
//

#import "BrandMainViewController.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImage+UIImageExtras.h"
#import "ViewController.h"
#import "BrandRead.h"
#import "BrandMainSecondViewController.h"
#import "RCDraggableButton.h"
#import "BMViewController.h"

#import <MaryPopin/UIViewController+MaryPopin.h>

@interface BrandMainViewController (){
    
    UIImageView * ImageBackView;
    
    
    //拖过来的
    NSMutableArray *_Imagearray;
    NSMutableArray *_photos;
    
    UIScrollView *_scrollView;//图片展示滚动视图
    UIView *_myScrollView;
    
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

@implementation BrandMainViewController

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
        self = [[BrandMainViewController alloc] initWithNibName:@"BrandMainViewController" bundle:nil];
        
    }
    
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    [self.navigationController setNavigationBarHidden:YES];
    
    //初始化数据
    [self initDataSource];
    
    [self didApper];
    
    [self layoutButton];
    
    
    //按钮
    //  [self loadAvatarInKeyWindow];
    
    //单机
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    
    //双击返回
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
    //这行很关键，意思是只有当没有检测到doubleTapGestureRecognizer 或者 检测doubleTapGestureRecognizer失败，singleTapGestureRecognizer才有效
    
    [singleTapGestureRecognizer requireGestureRecognizerToFail:tap];
    
    
}

- (void)singleTap:(UIGestureRecognizer*)gestureRecognizer

{
    NSLog(@"-----singleTap-----");
}

-(void)dealTap:(UITapGestureRecognizer *)tap
{
    
    ViewController * webVC = [[ViewController alloc] initViewController];
    [self.navigationController pushViewController:webVC animated:YES];
    
}

-(void)layoutButton{
    
    UIButton * buttonC = [[UIButton alloc]initWithFrame:CGRectMake(63, 80, 500, 200)];
    buttonC.tag = 10000;
    buttonC.backgroundColor = [UIColor clearColor];
    [buttonC addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonC];
    
    UIButton * buttonS = [[UIButton alloc]initWithFrame:CGRectMake(730, 80, 140, 200)];
    buttonS.tag = 10001;
    buttonS.backgroundColor = [UIColor clearColor];
    [buttonS addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonS];
    
    UIButton * buttonM = [[UIButton alloc]initWithFrame:CGRectMake(100, 330, 240, 310)];
    buttonM.tag = 10002;
    buttonM.backgroundColor = [UIColor clearColor];
    [buttonM addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonM];
    
    UIButton * buttonG = [[UIButton alloc]initWithFrame:CGRectMake(430, 350, 550, 110)];
    buttonG.tag = 10003;
    buttonG.backgroundColor = [UIColor clearColor];
    [buttonG addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonG];
    
    UIButton * buttonL = [[UIButton alloc]initWithFrame:CGRectMake(450, 540, 510, 125)];
    buttonL.tag = 10004;
    buttonL.backgroundColor = [UIColor clearColor];
    [buttonL addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonL];
    
    
    
}

-(void)didApper{


    [self Hengping];
    
}


-(void)initDataSource
{
    
    _user = [NSUserDefaults standardUserDefaults];
    
}

-(void)LayoutImage1:(int)NUM
{
    for (UIView * view  in _myScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    
    BrandRead *read = [[BrandRead alloc]init];
    
    int BtnHS = 50;
    int BtnY = 0;
    
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
        [_imageButton setBackgroundColor:[UIColor redColor]];
        [_imageButton setBackgroundImage:[UIImage imageNamed:Pa] forState:UIControlStateNormal];
        [_myScrollView addSubview:_imageButton];
        
        
        
        [self TitleLabel:i];
    }
    _getEndImageYH = (_BtnH+BtnHS) *(i/NUM) + BtnY ;
    
}


//TitleLabel
-(void)TitleLabel:(int)number
{
    BrandRead *read = [[BrandRead alloc]init];
    float x = _imageButton.frame.origin.x ;
    float y = _imageButton.frame.origin.y ;
    
    _Titlelabel = [[UILabel alloc] init];
    _Titlelabel.frame = CGRectMake(x, y+_imageButton.frame.size.height+6 , 270, 30);
    _Titlelabel.text = [read ImageArray][number];
    //字体颜色
    _Titlelabel.textColor = [UIColor blackColor];
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
    
        [self Hengping];
   
}


#pragma mark - 点击跳转
-(void)BtnClick:(UIButton *)imageTap
{
    
    // 1.封装图片数据
    
    BrandRead *read = [[BrandRead alloc]init];
    NSUInteger count = [[read Branch:(imageTap.tag - 10000.0)] count];
    
    NSMutableArray *img = [[NSMutableArray alloc] init];
    _photos = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *path = [read Branch:(imageTap.tag - 10000.0)][i];
        
        [img addObject:path];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = _photos; // 设置所有的图片
    
    
    BrandMainSecondViewController *popin = [[BrandMainSecondViewController alloc]init];
    

    popin.imageArray = img;
    popin.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    
    popin.view.bounds = CGRectMake(0, 0, 924, 668);
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleSnap];
    //[popin setPopinOptions:BKTPopinDisableAutoDismiss];
    BKTBlurParameters *blurParameters = [[BKTBlurParameters alloc] init];
    //blurParameters.alpha = 0.5;
    blurParameters.tintColor = [UIColor colorWithWhite:0 alpha:0.5];
    blurParameters.radius = 0.3;
    [popin setBlurParameters:blurParameters];
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];

    
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];

    
    
    [self removeAllFromKeyWindow];
    [self removeAllFromView];
    
    
    
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
    
    _BtnW = 1024;//宽
    _BtnWS = 0;//左右间距
    _BtnX = -5;//x
    _BtnH = 768;//高
    
    [self LayoutImage1:4];
}

-(void)Shuping
{
    _BtnW = 170;//宽            SIZE.width/5
    _BtnWS = 20;//左右间距       SIZE.width/5*(2/13)
    _BtnX = 10;//x
    _BtnH = 130;//高
    [self LayoutImage1:4];
    
    
    
}

- (void)removeAllFromKeyWindow {
    [RCDraggableButton removeAllFromKeyWindow];
}

- (void)removeAllFromView {
    [RCDraggableButton removeAllFromView:[self.view viewWithTag:89]];
}

//--------------------------按钮





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
