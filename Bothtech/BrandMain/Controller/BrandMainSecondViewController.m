//
//  BrandMainSecondViewController.m
//  Bothtech
//
//  Created by lanhull on 16/1/14.
//  Copyright © 2016年 Andrés Brun. All rights reserved.
//

#import "BrandMainSecondViewController.h"
#import "MJPhotoView.h"
#import "BrandMainViewController.h"
#import "CCMPlayNDropView.h"
#import <MaryPopin/UIViewController+MaryPopin.h>


@interface BrandMainSecondViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate,CCMPlayNDropViewDelegate>
{
    
    UIImageView *imgView ;
    UIImageView *imageView;
    UIView *aView;
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

@implementation BrandMainSecondViewController

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
    self.view.backgroundColor = [UIColor clearColor];
    
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
    self.view.superview.userInteractionEnabled = NO;
    self.view.userInteractionEnabled = NO;
    
    self.view.superview.userInteractionEnabled = YES;
    CGRect frame = self.view.frame;
    frame.origin.y = -1000;
    self.view.frame = frame;
    [self.parentViewController dismissCurrentPopinControllerAnimated:YES];
}

-(void)dealTap:(UITapGestureRecognizer *)tap
{
    
    BrandMainViewController * webVC = [[BrandMainViewController alloc] initViewController];
    [self.navigationController pushViewController:webVC animated:YES];
    
}


- (void)highAndWidth
{

        aView.frame= CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
        IsShu = 0;
        [self Hengping];
   
}

-(void)createScroolView
{
    //*_imageArray.count
    
    aView.backgroundColor  =[UIColor clearColor];
    aView = [[UIView alloc] init];
    
    [self.view addSubview:aView];
    
    
}


-(void)addImageView{
    
    for (UIView *view in aView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i<_imageArray.count; i++) {
        //
        
        float w = SIZE.width;
        float h = SIZE.height ;
        float x = 0;
        float y = 0;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        
        imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
//        imgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"图层-1@2x.png"]];
        imgView.backgroundColor = [UIColor clearColor];
        imgView.image = [UIImage imageNamed:_imageArray[i]];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:imgView];
        
        
        imgView.frame = CGRectMake(0, 0, w-0, h);
        
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D transform=CATransform3DMakeScale(0.2, 0.2, 1.0);
        NSValue *value=[NSValue valueWithCATransform3D:transform];
        [animation setFromValue:value];
        [animation setAutoreverses:NO];
        animation.duration=0.02;
        animation.repeatCount=1;
        [imgView.layer addAnimation:animation forKey:nil];
        
        [aView addSubview:view];
        
    }

}




- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    /*
     //
     for (UIView *view in aView.subviews) {
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
        //heng向执行

        aView.frame = CGRectMake(0, 0, 1024, 768);
        
    }else {
        //纵向执行
        
        aView.frame = CGRectMake(0, 0, 768, 1024);

    }
    
}

-(void)Hengping{
    
    _imgH = SIZE.width;
    _imgW = SIZE.height;
    NSLog(@"-121----- -- ---_imgH = %d,_imgW = %d",_imgH,_imgW);
    
    
    aView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    [self addImageView];
    
}

-(void)Shuping{
    _imgH = SIZE.height;
    _imgW = SIZE.width;
    
//    aView.contentSize = CGSizeMake(self.view.bounds.size.width*_imageArray.count+20, 200);
    aView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    [self addImageView];
    
    
}


-(void)CCMPlayNDropViewWillStartDismissAnimationWithDynamics:(CCMPlayNDropView *)view{
    self.view.superview.userInteractionEnabled = NO;
    self.view.userInteractionEnabled = NO;
}


-(void)CCMPlayNDropViewDidFinishDismissAnimationWithDynamics:(CCMPlayNDropView *)view{
    self.view.superview.userInteractionEnabled = YES;
    CGRect frame = self.view.frame;
    frame.origin.y = -1000;
    self.view.frame = frame;
    [self.parentViewController dismissCurrentPopinControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
