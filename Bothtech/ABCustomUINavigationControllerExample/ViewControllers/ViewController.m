//
//  ViewController.m
//  SquaresFlipNavigationExample
//
//  Created by Andrés Brun on 7/14/13.
//  Copyright (c) 2013 Andrés Brun. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirthViewController.h"
#import "FlipSquaresNavigationController.h"
#import "BMKMapViewController.h"
#import "H5SecondViewController.h"
#import "WebViewController.h"
#import "OrderViewController.h"
#import "BrandViewController.h"
#import "ProfileViewController.h"
#import "AJKMainViewController.h"
#import "MapViewController.h"
#import "AppViewController.h"
#import "SfViewController.h"
#import "BrandMainViewController.h"


#import "PopMenu.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (nonatomic, strong) PopMenu *popMenu;
@property (nonatomic, strong) UIButton * mainButton;

@property (nonatomic,strong) UIWebView * gifImage;


@property (nonatomic ,strong) UIView * vivo;
@property (nonatomic ,strong) UIView * Setview;

- (IBAction)pushViewController:(id)sender;

@end

@implementation ViewController

- (id)initViewController
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else {
        self = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
        

        
    }
    
    return self;
}


#pragma 隐藏状态栏
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleDefault;
//    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
//    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
//}
//
//- (BOOL)prefersStatusBarHidden
//{
//    return YES; // 返回NO表示要显示，返回YES将hiden
//}
//


//gif
- (UIWebView *)gifImage
{
    if (!_gifImage) {
        
        // 设定位置和大小
        CGRect frame = CGRectMake(0,0,0,0);
        frame.size = [UIImage imageNamed:@"guzhang.gif"].size;
        // 读取gif图片数据
        NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"guzhang" ofType:@"gif"]];
        

        
        //webView
        _gifImage = [[UIWebView alloc] initWithFrame:frame];
        _gifImage.backgroundColor = [UIColor blackColor];
        _gifImage.scalesPageToFit = YES;
        _gifImage.userInteractionEnabled = NO;//用户不可交互
        [_gifImage loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
        [self.iconView addSubview:_gifImage];

    }
    return _gifImage;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.navigationController setNavigationBarHidden:YES];
  
    [self showButton];
    
}



//GCD延迟执行方法
- (void)showButton{
    
    double delayInSeconds = 1.2;
    
    __block __weak ViewController* bself = self;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));

    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [bself showMenu];
        
        
    });
    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}


- (void)showMenu {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:4];

    
    MenuItem *menuItem = [MenuItem itemWithTitle:@"网站建设" iconName:@"post_type_bubble_www2"];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"互动营销" iconName:@"post_type_bubble_H53" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];
    
    
    menuItem = [MenuItem itemWithTitle:@"移动应用" iconName:@"post_type_bubble_App1" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];
    
    
    menuItem = [MenuItem itemWithTitle:@"软件开发" iconName:@"post_type_bubble_5" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];
    
    
    
    menuItem = [MenuItem itemWithTitle:@"品牌设计" iconName:@"post_type_bubble_4" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];

    
    menuItem = [MenuItem itemWithTitle:@"订单管理" iconName:@"post_type_bubble_6" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"关于我们" iconName:@"post_type_bubble_me7" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"公司位置" iconName:@"post_type_bubble_Position8" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];
    
    
    
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];


        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;

    }
    if (_popMenu.isShowed) {

        return;
    }
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        NSLog(@"%@",selectedItem.title);
        if ([selectedItem.title  isEqual: @"移动应用"]) {
            
            
        AppViewController * appVC = [[AppViewController alloc]initViewController];
        [self.navigationController pushViewController:appVC animated:YES];

            
        }
//
//        if ([selectedItem.title  isEqual: @"移动应用"]) {
//            
//            
//            SecondViewController * appVC = [[SecondViewController alloc]initViewController];
//            [self.navigationController pushViewController:appVC animated:YES];
//            
//            
//        }

        
        if ([selectedItem.title  isEqual: @"公司位置"]) {

            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                        @"渔阳置业大厦",@"address",
                                        @"北京市",@"city",
                                        @"google",@"from_map_type",
                                        @"39.9795652801",@"google_lat",
                                        @"116.4088600554",@"google_lng",
                                        @"朝阳区",@"region", nil];
            
            
            MapViewController *mv = [[MapViewController alloc] init];
            mv.navDic = dic;
            mv.mapType = RegionNavi;
            [self.navigationController pushViewController:mv animated:YES];

        }
        
        if ([selectedItem.title  isEqual: @"互动营销"]) {
            H5SecondViewController * H5 = [[H5SecondViewController alloc] initViewController];
            [self.navigationController pushViewController:H5 animated:YES];
        }
        
        if ([selectedItem.title  isEqual: @"网站建设"]) {
            WebViewController * webVC = [[WebViewController alloc] initViewController];
            [self.navigationController pushViewController:webVC animated:YES];

        }
        
        if ([selectedItem.title  isEqual: @"订单管理"]) {
            OrderViewController * ordarVC = [[OrderViewController alloc] initViewController];
            [self.navigationController pushViewController:ordarVC animated:YES];
        }
//        if ([selectedItem.title  isEqual: @"品牌设计"]) {
//            BrandViewController * brandVC = [[BrandViewController alloc] initViewController];
//            [self.navigationController pushViewController:brandVC animated:YES];
//        }
        if ([selectedItem.title  isEqual: @"品牌设计"]) {
            BrandMainViewController * brandVC = [[BrandMainViewController alloc] initViewController];
            [self.navigationController pushViewController:brandVC animated:YES];
        }

        if ([selectedItem.title  isEqual: @"关于我们"]) {
            ProfileViewController * profileVC = [[ProfileViewController alloc]initViewController];
            [self.navigationController pushViewController:profileVC animated:YES];
        }
        if ([selectedItem.title  isEqual: @"软件开发"]) {
            SfViewController *softVC = [[SfViewController alloc]initViewController];
            [self.navigationController pushViewController:softVC animated:YES];
        }
        
    };
    

    [_popMenu showMenuAtView:self.view];
    
    //    [_popMenu showMenuAtView:self.view startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self showMenu];
    
    
//    //渐变
//    self.iconView.alpha = 0.5;
//    [UIView beginAnimations:@"" context:nil];
//    [UIView setAnimationDuration:1.0];
//    self.iconView.alpha = 1;
//    [UIView commitAnimations];
//    
//    [self.iconView setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"QQ.png"]]];

 
//    UIImageView *  uuu = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
//    [uuu setImage:[UIImage imageNamed:@"home02.jpg"]];
//    [self.view addSubview:uuu];
    
    
    
}



- (void)dealloc {
    NSLog(@"dealloc");
   
  
}



@end
