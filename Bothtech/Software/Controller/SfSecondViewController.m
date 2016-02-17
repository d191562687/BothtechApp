//
//  SfSecondViewController.m
//  Bothtech
//
//  Created by lanhull on 16/1/13.
//  Copyright © 2016年 Andrés Brun. All rights reserved.
//

#import "SfSecondViewController.h"
#import "MJPhotoView.h"
#import "SfViewController.h"

@interface SfSecondViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>
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
    
    
    BOOL IsShu;//是否竖屏
    
    // 工具条
    UIView *_toolbar;
}
@property(nonatomic, unsafe_unretained)CGFloat currentScale;



@end

@implementation SfSecondViewController

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
    
}



- (void)highAndWidth
{
        //此时为横屏
        //横屏view显示方法
        scrollView.frame= CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
        IsShu = 0;
        [self Hengping];
 
}

-(void)createScroolView
{
    //*_imageArray.count
    
    scrollView.backgroundColor  =[UIColor redColor];
    scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*_imageArray.count+20, 200);
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
        float h = SIZE.height - 50;
        float x = i*w;
        float y = 0;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        
        
        imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        imgView.backgroundColor = [UIColor blackColor];
        imgView.image = [UIImage imageNamed:_imageArray[i]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imgView];
        
        
        
//        //手势
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
        
    }
    [self createToolbar];
}

#pragma mark - 手势


-(void)dealpPan:(UIPanGestureRecognizer *)paramSender
{
    if (paramSender.state != UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed){
        //通过使用 locationInView 这个方法,来获取到手势的坐标
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        paramSender.view.center = location;
        
    }
    
}

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
    
    
    SfViewController * webVC = [[SfViewController alloc] initViewController];
    [self.navigationController pushViewController:webVC animated:YES];
    
    
}






- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

    
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
    
    
    
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * _imageArray.count+20, 200);
    scrollView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
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
