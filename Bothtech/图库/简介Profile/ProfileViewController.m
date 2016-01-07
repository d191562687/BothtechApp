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

    UIImageView *logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(600, 70, 402, 270)];
    [logoImage setImage:[UIImage imageNamed:@"组-1@2x.png"]];
    [self.view addSubview:logoImage];

    UIImageView * companyImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 390, 540, 349)];
    [companyImage setImage:[UIImage imageNamed:@"公司图片@2x.png"]];
    [self.view addSubview:companyImage];
    

    
    UILabel * topLable = [[UILabel alloc]initWithFrame:CGRectMake(70, 70, 300, 30)];
    topLable.text = @"公司简介";
    topLable.font = [UIFont fontWithName:@"Helvetica" size:35.0];
    topLable.textColor = [UIColor blackColor];
    [self.view addSubview:topLable];
    
    
    //联系地址label
    //联系1
    UILabel * lianxiLabel = [[UILabel alloc]initWithFrame:CGRectMake(620, 370, 100, 30)];
    lianxiLabel.text = @"联系方式";
    lianxiLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
    [self.view addSubview:lianxiLabel];
    
    //'咨询电话'label
    UILabel *dianhuaLabel = [[UILabel alloc]initWithFrame:CGRectMake(620, 400, 240, 30)];
    dianhuaLabel.text = @"电话：010-67792610";
    dianhuaLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    [self.view addSubview:dianhuaLabel];
    //'业务部QQ‘label
    UILabel *yewuQQlabel = [[UILabel alloc]initWithFrame:CGRectMake(620, 420, 150, 30)];
    yewuQQlabel.text = @"QQ：1770103145";
    yewuQQlabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    [self.view addSubview:yewuQQlabel];
    //'业务部邮箱‘label
    UILabel *yewuEmaiLabel = [[UILabel alloc]initWithFrame:CGRectMake(620, 440, 280, 30)];
    yewuEmaiLabel.text = @"Email：chenwei@bothtimes.com";
    [self.view addSubview:yewuEmaiLabel];
    
    //’官网‘label
    UILabel *guanwangLabel = [[UILabel alloc]initWithFrame:CGRectMake(620, 460, 255, 30)];
    guanwangLabel.text = @"官网：www.bothtimes.com";
    guanwangLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    [self.view addSubview:guanwangLabel];
    
    
    UILabel *dizhiLabel = [[UILabel alloc]initWithFrame:CGRectMake(620, 480, 400, 30)];
    dizhiLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    dizhiLabel.text = @"北京市朝阳区小关北里甲2号渔阳置业大厦A座704";
    [self.view addSubview:dizhiLabel];
    //’微信服务号‘label
    UILabel *fuwuLabel = [[UILabel alloc]initWithFrame:CGRectMake(620, 500, 255, 30)];
    fuwuLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    fuwuLabel.text = @"微信服务号：BothTech2014";
    [self.view addSubview:fuwuLabel];
    //微信帐号label
    UILabel *WeixinLabel = [[UILabel alloc]initWithFrame:CGRectMake(620, 520, 255, 30)];
    WeixinLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    WeixinLabel.text = @"扫描关注“时代博晟网络科技”";
    [self.view addSubview:WeixinLabel];
    
    //微信二维码
    UIImageView *weimaImage = [[UIImageView alloc]initWithFrame:CGRectMake(620, 550, 180, 176)];
    [weimaImage setImage:[UIImage imageNamed:@"QQ图片20140808100136_meitu_2_180.png"]];
    [self.view addSubview:weimaImage];
    
    
    
    //公司介绍
    NSString *path = [[NSBundle mainBundle] pathForResource:@"lorem_ipsum1.txt" ofType:nil];
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(40, 90, 500, 300)];
    lable.text = text;
    lable.lineBreakMode = UILineBreakModeWordWrap;
    lable.numberOfLines = 0;
    lable.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    lable.textColor = [UIColor blackColor];
    [self.view addSubview:lable];
    
    
    //  [self.view addSubview:textView];
    
    //双击返回
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
   
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self pageLayout];
   
    
    
    //按钮
   // [self loadAvatarInKeyWindow];
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

#pragma 悬浮按钮

- (void)loadAvatarInKeyWindow {
    
    RCDraggableButton * avatar = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(900, 620, 90, 90)];
    [avatar setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    
    [avatar setLongPressBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow ===  LongPress!!! ===");
        //More todo here.
        
    }];
    
    [avatar setTapBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow ===  111Tap!!! ===");
        //More todo here.
//     [self dismissViewControllerAnimated:YES completion:nil];
        
        //More todo here.
        ViewController *firstVC = [[ViewController alloc]initViewController];
        [self.navigationController pushViewController:firstVC animated:YES];

//        
//        ViewController *firstVC = [self.navigationController.viewControllers objectAtIndex:0];
//        [self.navigationController popToViewController:firstVC animated:YES];
  
        



        
        
        [self removeAllFromView];
        [self removeAllFromKeyWindow];
        
        
    }];
    
    [avatar setDoubleTapBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow ===  DoubleTap!!! ===");
        //More todo here.
        
        
    }];
    
    [avatar setDraggingBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow === Dragging!!! ===");
        //More todo here.
        
    }];
    
    [avatar setDragDoneBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow === DragDone!!! ===");
        //More todo here.
        
    }];
    
    [avatar setAutoDockingBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow === AutoDocking!!! ===");
        //More todo here.
        
    }];
    
    [avatar setAutoDockingDoneBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow === AutoDockingDone!!! ===");
        //More todo here.
        
    }];
}

- (void)removeAllFromKeyWindow {
    [RCDraggableButton removeAllFromKeyWindow];
}

- (void)removeAllFromView {
    [RCDraggableButton removeAllFromView:[self.view viewWithTag:89]];
}

//--------------------------按钮



@end
