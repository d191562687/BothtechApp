//
//  BMKMapViewController.m
//  Bothtech
//
//  Created by lanhull on 15/12/7.
//  Copyright © 2015年 Andrés Brun. All rights reserved.
//

#import "BMKMapViewController.h"


@interface BMKMapViewController ()



@end

@implementation BMKMapViewController



- (id)initViewController
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [[BMKMapViewController alloc] initWithNibName:@"BMKMapViewController" bundle:nil];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = YES;
    }
    _locService = [[BMKLocationService alloc]init];
    [followHeadBtn setEnabled:NO];
    [followingBtn setAlpha:0.6];
    [followingBtn setEnabled:NO];
    [followHeadBtn setAlpha:0.6];
    [stopBtn setEnabled:NO];
    [stopBtn setAlpha:0.6];
    
    //地图
    [self startLocation];
    
    //按钮
    
//    [self loadAvatarInKeyWindow];
    
    //双击返回
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
    
    
    
}


-(void)dealTap:(UITapGestureRecognizer *)tap
{
    
    
    ViewController * webVC = [[ViewController alloc] initViewController];
    [self.navigationController pushViewController:webVC animated:YES];
    
    
}

//实现相关delegate 处理位置信息更新


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

#pragma 悬浮按钮

- (void)loadAvatarInKeyWindow {
    
    RCDraggableButton * avatar = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(900, 630, 90, 90)];
    [avatar setBackgroundImage:[UIImage imageNamed:@"avatar"] forState: UIControlStateNormal];
    
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


-(void)startLocation
{
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    [startBtn setEnabled:NO];
    [startBtn setAlpha:0.6];
    [stopBtn setEnabled:YES];
    [stopBtn setAlpha:1.0];
    [followHeadBtn setEnabled:YES];
    [followHeadBtn setAlpha:1.0];
    [followingBtn setEnabled:YES];
    [followingBtn setAlpha:1.0];
}

//---地图
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

//---------------





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)shouldAutorotate
{
    return YES;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)reload{
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
