//
//  AppViewController.m
//  Bothtech
//
//  Created by lanhull on 16/1/8.
//  Copyright © 2016年 Andrés Brun. All rights reserved.
//

#import "AppViewController.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImage+UIImageExtras.h"
#import "ViewController.h"
#import "AppRead.h"
#import "AppSecondViewController.h"
#import "RCDraggableButton.h"

@interface AppViewController (){
    
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

@implementation AppViewController

#pragma - Object lifecycle



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
        self = [[AppViewController alloc] initWithNibName:@"AppViewController" bundle:nil];
        
    }
    
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化数据
    [self initDataSource];
    
    [self didApper];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home02.jpg"]];
    //按钮
  //  [self loadAvatarInKeyWindow];

    //单机
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];

    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
//
//    //双击返回
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
//    tap.numberOfTapsRequired = 2;
//    [self.view addGestureRecognizer:tap];
//    //这行很关键，意思是只有当没有检测到doubleTapGestureRecognizer 或者 检测doubleTapGestureRecognizer失败，singleTapGestureRecognizer才有效
//    
//    [singleTapGestureRecognizer requireGestureRecognizerToFail:tap];

    
}

- (void)singleTap:(UIGestureRecognizer*)gestureRecognizer

{
    NSLog(@"-----singleTap-----");
    ViewController * webVC = [[ViewController alloc] initViewController];
    [self.navigationController pushViewController:webVC animated:YES];
    
}

-(void)dealTap:(UITapGestureRecognizer *)tap
{

    ViewController * webVC = [[ViewController alloc] initViewController];
    [self.navigationController pushViewController:webVC animated:YES];

}



-(void)didApper{
    _myScrollView.frame = CGRectMake(0, 0, 1024, 768);
    NSLog(@"w = %f h = %f",SIZE.width,SIZE.height);
    
    _myScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2 - 172 ,self.view.frame.size.height);
    _myScrollView.frame = CGRectMake(0, 0, 1024, 768);
    _myScrollView.pagingEnabled = YES;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    NSLog(@"两个要不一样啊  %f",SIZE.width);
    [self Hengping];
    
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
    
    
    
    AppRead *read = [[AppRead alloc]init];
    
    int BtnHS = 50;
    int BtnY = 55;
    
    int i = 0;
    for (i = 0; i <[[read ImageArray] count]; i++ ){
        
        
        _imageview.backgroundColor = [UIColor blueColor];
        
        
        //获得图片数组中的第一个图   --- ---
        NSString *Pa = [NSString stringWithFormat:@"%@0",[read ImageMethod:i]];
        

        
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageButton.frame = CGRectMake( (_BtnW+_BtnWS) * (i%NUM) + _BtnX +5, (_BtnH+BtnHS) *(i/NUM) + BtnY, _BtnW, _BtnH );
        
//        [_imageButton addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_imageButton addTarget:self action:@selector(tabButtonTapped:forEvent:) forControlEvents:UIControlEventTouchDown];
        
        [_imageButton addTarget:self action:@selector(repeatBtnTapped:forEvent:) forControlEvents:UIControlEventTouchDownRepeat];
        
        
        
        _imageButton.tag = 10000+i;
        [_imageButton addSubview:_imageView];
        [_imageButton setBackgroundColor:[UIColor redColor]];
        [_imageButton setBackgroundImage:[UIImage imageNamed:Pa] forState:UIControlStateNormal];
        [_myScrollView addSubview:_imageButton];
        
        
        
        [self TitleLabel:i];
    }
    _getEndImageYH = (_BtnH+BtnHS) *(i/NUM) + BtnY ;
    
}

- (void)tabButtonTapped:(UIButton *)imageTap forEvent:(UIEvent *)event {
    
    [self performSelector:@selector(BtnClick:) withObject:imageTap afterDelay:0.5];
    
    
}
- (void)repeatBtnTapped:(UIButton *)imageTap forEvent:(UIEvent *)event {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(BtnClick:) object:imageTap];
    
    NSLog(@"双击操作");
    
    ViewController * webVC = [[ViewController alloc] initViewController];
    [self.navigationController pushViewController:webVC animated:YES];
    
}

//TitleLabel
-(void)TitleLabel:(int)number
{
    AppRead *read = [[AppRead alloc]init];
    float x = _imageButton.frame.origin.x ;
    float y = _imageButton.frame.origin.y ;
    
    _Titlelabel = [[UILabel alloc] init];
    _Titlelabel.frame = CGRectMake(x, y+_imageButton.frame.size.height+6 , 270, 30);
    _Titlelabel.text = [read ImageArray][number];
    //字体颜色
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
    
        [self Hengping];

}


#pragma mark - 点击跳转
-(void)BtnClick:(UIButton *)imageTap
{
    
    // 1.封装图片数据
    
    AppRead *read = [[AppRead alloc]init];
    NSUInteger count = [[read Branch:(imageTap.tag - 10000)] count];
    
    NSMutableArray *img = [[NSMutableArray alloc] init];
    _photos = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *path = [read Branch:(imageTap.tag - 10000)][i];
        
        [img addObject:path];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = _photos; // 设置所有的图片
    
    
    AppSecondViewController *ivc = [[AppSecondViewController alloc] init];
    
    ivc.imageArray = img ;
    ivc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    NSLog(@"%lu",(unsigned long)_photos.count);
    [self.navigationController pushViewController:ivc animated:YES];
    
    
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
    
    _BtnW = 335;//宽
    _BtnWS = 5;//左右间距
    _BtnX = 0;//x
    _BtnH = 603;//高
    
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
