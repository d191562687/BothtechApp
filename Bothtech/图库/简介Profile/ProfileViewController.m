//
//  ProfileViewController.m
//  Bothtech
//
//  Created by lanhull on 15/12/25.
//  Copyright © 2015年 Andrés Brun. All rights reserved.
//

#import "ProfileViewController.h"
#import "ViewController.h"
#import "BrandViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
        self = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
        
    }
    
    
    return self;
}

#pragma 页面布局
- (void)pageLayout
{
    //布局设置
    
    UIButton * buttonImage = [[UIButton alloc]initWithFrame:CGRectMake(600, 100, 402, 324)];
    [buttonImage setBackgroundImage:[UIImage imageNamed:@"cooperationIcon.png"] forState:UIControlStateNormal];
    [buttonImage addTarget:self action:@selector(buttonImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonImage];
    

//    UIImageView * companyImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 390, 540, 349)];
//    [companyImage setImage:[UIImage imageNamed:@"公司图片@2x.png"]];
//    [self.view addSubview:companyImage];
    
    
    FLAdView * adView = [[FLAdView alloc]initWithFrame:CGRectMake(30, 390, 540, 349)];
    adView.imageArray = @[@"OfficeImage1.jpg",@"OfficeImage2.jpg",@"OfficeImage3.jpg",@"OfficeImage4.jpg",@"OfficeImage5.jpg"];
    adView.location = PageControlCenter;
    adView.currentPageColor = [UIColor clearColor];
    adView.normalColor = [UIColor clearColor];
    adView.chageTime = 3.0f;
    adView.flDelegate = self;
    [self.view addSubview:adView];
    
    

    UILabel * topLable = [[UILabel alloc]initWithFrame:CGRectMake(70, 70, 300, 30)];
    topLable.text = @"公司简介";
    topLable.font = [UIFont fontWithName:@"Helvetica" size:35.0];
    topLable.textColor = [UIColor blackColor];
    [self.view addSubview:topLable];
    
    
    //联系地址label
    //联系1
    UILabel * lianxiLabel = [[UILabel alloc]initWithFrame:CGRectMake(610, 595, 100, 30)];
    lianxiLabel.text = @"联系方式";
    lianxiLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    [self.view addSubview:lianxiLabel];
    
    //'咨询电话'label
    UILabel *dianhuaLabel = [[UILabel alloc]initWithFrame:CGRectMake(610, 625, 350, 30)];
    dianhuaLabel.text = @"电话：010-67792610    QQ：1770103145";
    dianhuaLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    [self.view addSubview:dianhuaLabel];
    
    //'业务部邮箱‘label
    UILabel *yewuEmaiLabel = [[UILabel alloc]initWithFrame:CGRectMake(610, 655, 280, 30)];
    yewuEmaiLabel.text = @"Email：chenwei@bothtimes.com";
    [self.view addSubview:yewuEmaiLabel];
    
    //’官网‘label
    UILabel *guanwangLabel = [[UILabel alloc]initWithFrame:CGRectMake(610, 685, 255, 30)];
    guanwangLabel.text = @"官网：www.bothtimes.com";
    guanwangLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    [self.view addSubview:guanwangLabel];
    
    
    UILabel *dizhiLabel = [[UILabel alloc]initWithFrame:CGRectMake(610, 715, 400, 30)];
    dizhiLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    dizhiLabel.text = @"北京市朝阳区小关北里甲2号渔阳置业大厦A座704";
    [self.view addSubview:dizhiLabel];
  
    //公司介绍
    NSString *path = [[NSBundle mainBundle] pathForResource:@"lorem_ipsum1.txt" ofType:nil];
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(40, 90, 500, 300)];
    lable.text = text;
//    lable.lineBreakMode = UILineBreakModeWordWrap;
    lable.lineBreakMode = UILayoutConstraintAxisVertical;
    lable.numberOfLines = 0;
    lable.font = [UIFont fontWithName:@"Helvetica" size:20.0];
    lable.textColor = [UIColor blackColor];
    [self.view addSubview:lable];
    
    //双击返回
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
   
    
    
}


-(void)imageTaped:(UIImageView *)imageView{
    NSLog(@"imageView tag is %ld",(long)imageView.tag);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self pageLayout];
   
    
    
    //按钮
   // [self loadAvatarInKeyWindow];
}

-(void)buttonImage{
    BrandViewController * brandVC = [[BrandViewController alloc] initViewController];
    [self.navigationController pushViewController:brandVC animated:YES];
}


-(void)dealTap:(UITapGestureRecognizer *)tap
{
    
    
    ViewController * webVC = [[ViewController alloc] initViewController];
    [self.navigationController pushViewController:webVC animated:YES];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
