//
//  ImageListViewController.m
//  ImageAPP
//
//  Created by lanhull on 14-9-27.
//  Copyright (c) 2014年 bothtech. All rights reserved.
//

#import "ImageTestViewController.h"
#import "MJPhotoView.h"
#import "WebViewController.h"


@interface ImageTestViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>
{
    
    UIImageView *imgView ;
    UIImageView *imageView;
    UIScrollView *scrollView;
    UILabel *bottomLabel;
    
    int _imgW; //图片的宽度 
    int _imgWWW;//原始宽
    int _imgHHH;//原始高
    int _imgH;//图片的高度
    int _scrollW;//滚动视图都宽
    
    int _page;//记录转屏之前的页数；
    
    int _getEndImageYH;
    
    int imHH;
    int imWW;
    
    
    BOOL IsShu;//是否竖屏
    
    // 工具条
    UIView *_toolbar;
}
@property(nonatomic, unsafe_unretained)CGFloat currentScale;


@end

@implementation ImageTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _imageArray = [[NSMutableArray
                        alloc] init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self initData];
    [self createScroolView];
    
    [self highAndWidth];
}

-(void)initData{

    bottomLabel = [[UILabel  alloc] init];
    bottomLabel.textColor = [UIColor blueColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createToolbar];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home02.jpg"]];

    
}



- (void)highAndWidth
{
    
    NSLog(@"scre = = == %f",[[UIScreen mainScreen] applicationFrame].size.height);
    //判断是否横屏
    
    if ([[UIScreen mainScreen] applicationFrame].size.width != 768 ) {
        //此时为横屏
        //横屏view显示方法
        scrollView.frame= CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
        IsShu = 0;
        [self Hengping];
    }else{
        scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        IsShu = 1;
        [self Shuping];
    }
    
}

-(void)createScroolView
{
    //*_imageArray.count

    scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*_imageArray.count, imHH);
    scrollView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
  
    
    [self.view addSubview:scrollView];
    
    
}



-(void)addImageView{
    
    for (UIView *view in scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i<_imageArray.count; i++) {
        //
        
        float w = SIZE.width;
        float h = SIZE.height ;
        float x = i*w;
        float y = - 20;
        
  
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        
        
        imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        imgView.backgroundColor = [UIColor clearColor  ];
        imgView.image = [UIImage imageNamed:_imageArray[i]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        NSLog(@"HH==%f,WW==%f",imgView.image.size.height,imgView.image.size.width);

        
        imgView.userInteractionEnabled = YES;
        [view addSubview:imgView];
        
        
        
        
        //手势
//        UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(dealPinch:)];
//        [imgView addGestureRecognizer:pinch];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
        [imgView addGestureRecognizer:tap];
        
        
        UILongPressGestureRecognizer *longPressReger = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        longPressReger.minimumPressDuration = 1.2;
        
        [scrollView addGestureRecognizer:longPressReger];
        
        imgView.frame = CGRectMake(0, 0, w-0, h);

        
       
        
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D transform=CATransform3DMakeScale(0.2, 0.2, 1.0);
        NSValue *value=[NSValue valueWithCATransform3D:transform];
        [animation setFromValue:value];
        [animation setAutoreverses:NO];
        animation.duration=0.02;
        animation.repeatCount=1;
        [imgView.layer addAnimation:animation forKey:nil];
        
        [scrollView addSubview:view];
        
//        //一个手指
//        UITapGestureRecognizer *singleClickDog = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singliDogTap:)];
//        UITapGestureRecognizer *doubleClickTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
//        //两个手指
//        UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelTwoFingerTap:)];
//        singleClickDog.numberOfTapsRequired = 1;
//        singleClickDog.numberOfTouchesRequired = 1;
//        doubleClickTap.numberOfTapsRequired = 2;//需要点两下
//        twoFingerTap.numberOfTouchesRequired = 2;//需要两个手指touch
//        [imgView addGestureRecognizer:singleClickDog];
//        [imgView addGestureRecognizer:doubleClickTap];
//        [imgView addGestureRecognizer:twoFingerTap];
//        [singleClickDog requireGestureRecognizerToFail:doubleClickTap];//如果双击了，则不响应单击事件
//        [scrollView setZoomScale:1];

//        
//                CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform"];
//                CATransform3D transform=CATransform3DMakeScale(0.2, 0.2, 1.0);
//                NSValue *value=[NSValue valueWithCATransform3D:transform];
//                [animation setFromValue:value];
//                [animation setAutoreverses:NO];
//                animation.duration=0.02;
//                animation.repeatCount=1;
//                [imgView.layer addAnimation:animation forKey:nil];
//                
//                [scrollView addSubview:view];

        
        
        
    }
    [self createToolbar];
}


-(void)handelTwoFingerTap:(UITapGestureRecognizer *)gestureRecongnizer{

    float newScale = [scrollView zoomScale]/2;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecongnizer locationInView:gestureRecongnizer.view]];
    [scrollView zoomToRect:zoomRect animated:YES];
}

//缩放系数(倍数)
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollViewSS withView:(UIView *)view atScale:(CGFloat)scale
{
    [scrollViewSS setZoomScale:scale+0.01 animated:NO];
    [scrollViewSS setZoomScale:scale animated:NO];
}
#pragma mark - 事件处理
-(void)singliDogTap:(UITapGestureRecognizer *)gestureRecognizer
{
//    if (_myBlock) {
//        _myBlock(@"单击");
//    }
//    if (gestureRecognizer.numberOfTapsRequired == 1)
//    {
//        
//    }
}
-(void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer{
//    if (_myBlock) {
//        _myBlock(@"双击");
//    }
    if (gestureRecognizer.numberOfTapsRequired == 2) {
        if(scrollView.zoomScale == 1){
            float newScale = [scrollView zoomScale] *2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [scrollView zoomToRect:zoomRect animated:YES];
        }else{
            float newScale = [scrollView zoomScale]/2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
            [scrollView zoomToRect:zoomRect animated:YES];
        }
    }
}


#pragma mark - 缩放大小获取方法
-(CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    //大小
    zoomRect.size.height = [scrollView frame].size.height/scale;
    zoomRect.size.width = [scrollView frame].size.width/scale;
    //原点
    zoomRect.origin.x = center.x - zoomRect.size.width/2;
    zoomRect.origin.y = center.y - zoomRect.size.height/2;
    return zoomRect;
}






#pragma mark - 手势




-(void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer

{
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {

        //长按事件开始"
   
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"是否保存图片"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        
        
        
        [alert show];

        //do something
        
    }
    
    else if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        
        //长按事件结束
        
        //do something
        
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    if (buttonIndex == 1) {
             //保存图片
        UIImageWriteToSavedPhotosAlbum([imgView image], nil, nil,nil);

  
        
        NSLog(@"保存");
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示"
                              
                                                       message:@"您已保存图片到相册！"
                              
                                                      delegate:nil
                              
                                             cancelButtonTitle:@"确定"
                              
                                             otherButtonTitles:nil];
        
        [alert show];
        

    }
}

#pragma mark - 拖拽移动


-(void)dealpPan:(UIPanGestureRecognizer *)paramSender
{
    
    if (paramSender.state != UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed){
        //通过使用 locationInView 这个方法,来获取到手势的坐标
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        paramSender.view.center = location;
        
 
    }
}


// 处理缩放手势


-(void)dealPinch:(UIPinchGestureRecognizer *)paramSender
{
    
    if (paramSender.state == UIGestureRecognizerStateEnded) {
        self.currentScale = paramSender.scale;
    }else if(paramSender.state == UIGestureRecognizerStateBegan && self.currentScale != 0.0f){
        paramSender.scale = self.currentScale;
    }
    if (paramSender.scale !=NAN && paramSender.scale != 0.0) {
        paramSender.view.transform = CGAffineTransformMakeScale(paramSender.scale, paramSender.scale);
    }
    
}



-(void)dealTap:(UITapGestureRecognizer *)tap
{

    [self dismissViewControllerAnimated:YES completion:nil];
    
    WebViewController * webVC = [[WebViewController alloc] initViewController];
    [self.navigationController pushViewController:webVC animated:YES];
    

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollViewSS  {
    NSLog(@"=====");
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight || self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        //横屏
        //        NSLog(@"横屏第%.0f页",scrollView.contentOffset.x/1024+1);
        _page = scrollViewSS.contentOffset.x/SIZE.width+1;

        
        NSLog(@"横屏%d",_page);
        
    }else{
        //        _page = _page;
        //        NSLog(@"竖屏第%.0f页",scrollView.contentOffset.x/1024+1);
        _page = scrollViewSS.contentOffset.x/SIZE.width+1;
        NSLog(@"竖屏%d",_page);
    }
    

    [self updateTollbarState];
}

-(NSUInteger)supportedInterfaceOrientations
{
    NSLog(@"只要是旋转都会调用我");
    //NSLog(@"/会调用我 w=  %f",SIZE.width);
    
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait)
    {
        //竖屏处理
    }
    else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)
    {
        //横屏处理
    }
    return UIInterfaceOrientationMaskAll;
}


- (BOOL)shouldAutorotate{
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight || self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        NSLog(@"横");
        NSLog(@"w = %f",SIZE.width);
        //横屏刚进去也会调用
    }else{
        NSLog(@"竖");
        NSLog(@"w = %f  h = %f",SIZE.width,SIZE.height);
    }
 
    
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
/*
    //
        for (UIView *view in scrollView.subviews) {
            [view removeFromSuperview];
        }
    //
 */
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    

    NSLog(@"/转之前是竖屏才会调用1");
    
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
     NSLog(@"/转之前是竖屏c才会调用我 w=  %f",SIZE.width);
 //
    //heng向执行
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight || self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {

        scrollView.frame = CGRectMake(0, 0, 1024, 768);
        

        scrollView.contentSize = CGSizeMake(SIZE.height*_imageArray.count, self.view.bounds.size.width);
        IsShu = 1;
        
        [scrollView setContentOffset:CGPointMake((_page-1)*1024, 0) animated:NO];
        [self Hengping];
    }else {
        //纵向执行
        
        scrollView.frame = CGRectMake(0, 0, 768, 1024);
        //        NSLog(@"%f  %f  ",SIZE.width*0.75,SIZE.height*1.3);
        //w缩小0.75
        //        imgView.frame = CGRectMake(0, 0, 768*0.75, 1024*0.75);
        //        imgView.center = CGPointMake(SIZE.width/2, SIZE.height/2);
        scrollView.contentSize = CGSizeMake(SIZE.width*_imageArray.count, self.view.bounds.size.height);
        IsShu = 0;
        
        [scrollView setContentOffset:CGPointMake((_page-1)*768, 0) animated:NO];
        [self Shuping];
    }
    
//    */
    
}

-(void)Hengping{
    
    
    _imgH = SIZE.width;
    _imgW = SIZE.height;
    NSLog(@"-121----- -- ---_imgH = %d,_imgW = %d",_imgH,_imgW);
    
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * _imageArray.count, 200);
    scrollView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    scrollView.directionalLockEnabled = YES;
    
    [self addImageView];
    
}

-(void)Shuping{
    _imgH = SIZE.height;
    _imgW = SIZE.width;
    
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*_imageArray.count+20, 200);
    scrollView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    [self addImageView];
    
    
}

#pragma mark - 底部页码
-(void)createToolbar{
    CGFloat barHeight = 70;
    CGFloat barY = self.view.frame.size.height - barHeight;
    _toolbar = [[UIView alloc] init];
    _toolbar.alpha = 0.4;
    
    _toolbar.frame = CGRectMake(0, barY, self.view.frame.size.width, barHeight);
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _toolbar.backgroundColor = [UIColor whiteColor];
//    _toolbar.photos = _imageArray;
    //[self.view addSubview:_toolbar];
    

    [self.view addSubview:bottomLabel];
    [self.view bringSubviewToFront:bottomLabel];

    bottomLabel.frame = CGRectMake(SIZE.width/2-30, SIZE.height-50, 60, 30);


    [self updateTollbarState];
    
   
}

#pragma mark - 刷新页码
- (void)updateTollbarState
{
    if (!_page) {
        bottomLabel.textColor = [UIColor whiteColor];
        bottomLabel.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)_imageArray.count];
    }else{
        bottomLabel.textColor = [UIColor whiteColor];
        bottomLabel.text = [NSString stringWithFormat:@"%d/%lu",_page,(unsigned long)_imageArray.count];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
