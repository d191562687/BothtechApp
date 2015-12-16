//
//  ThirthViewController.m
//  SquaresFlipNavigationExample
//
//  Created by Andrés Brun on 7/25/13.
//  Copyright (c) 2013 Andrés Brun. All rights reserved.
//

#import "ThirthViewController.h"
#import "SecondViewController.h"
#import "ViewController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PlayNDropViewController.h"

#import "Read.h"
#import <MaryPopin/UIViewController+MaryPopin.h>

@interface ThirthViewController ()<UIGestureRecognizerDelegate>



@property (strong, nonatomic) IBOutlet CoverFlowView *CFView;

@end

@implementation ThirthViewController



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
        self = [[ThirthViewController alloc] initWithNibName:@"ThirthViewController_iPhone" bundle:nil];
    } else {
        self = [[ThirthViewController alloc] initWithNibName:@"ThirthViewController_iPad" bundle:nil];
        
    }
    
    
    
    return self;
}


- (NSMutableArray *)sourceImages
{
    
    if (!_sourceImages) {
        
        _sourceImages = [NSMutableArray arrayWithCapacity:20];
        for (int i = 0; i <20 ; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
            [_sourceImages addObject:image];
            
            
        }
    }
    return  _sourceImages;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

  
    [self sourceImages];
    
    
    self.CFView.frame = CGRectMake(0, 0, 1024, 768);
    


    //CoverFlowView *coverFlowView = [CoverFlowView coverFlowViewWithFrame: frame andImages:_arrImages sidePieces:6 sideScale:0.35 middleScale:0.6];
    CoverFlowView *coverFlowView = [CoverFlowView coverFlowViewWithFrame:self.view.frame andImages:_sourceImages sideImageCount:4 sideImageScale:0.5 middleImageScale:0.90];
    [self.CFView addSubview:coverFlowView];
    
    
    [self loadAvatarInKeyWindow];
    
//    [self loadAvatarInCustomView];
//    
//    [self addControlButton];
    



    
}

#pragma 悬浮按钮
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAvatarInKeyWindow {
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(900 , 630, 90, 90)];
    [avatar setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    
    [avatar setLongPressBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow ===  LongPress!!! ===");
        //More todo here.
        
    }];
    
    [avatar setTapBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow ===  Tap!!! ===");
        
        //More todo here.
        
//        //卡片效果
//        PlayNDropViewController * popin = [[PlayNDropViewController alloc] initWithNibName:@"PlayNDropViewController" bundle:nil];
//       
////        
////        UIViewController *popin = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PlayNDropViewController"];
//        popin.view.bounds = CGRectMake(0, 0, 300, 400);
//        
//        
//        [popin setPopinTransitionStyle:BKTPopinTransitionStyleSnap];
//        //[popin setPopinOptions:BKTPopinDisableAutoDismiss];
//        BKTBlurParameters *blurParameters = [[BKTBlurParameters alloc] init];
//        //blurParameters.alpha = 0.5;
//        blurParameters.tintColor = [UIColor colorWithWhite:0 alpha:0.5];
//        blurParameters.radius = 0.3;
//        [popin setBlurParameters:blurParameters];
//        [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
//        //popin.presentingController = self;
//        
//        //Present popin on the desired controller
//        //Note that if you are using a UINavigationController, the navigation bar will be active if you present
//        // the popin on the visible controller instead of presenting it on the navigation controller
//        [self presentPopinController:popin animated:YES completion:^{
//            NSLog(@"Popin presented !");
//        }];
////
//         [self.navigationController pushViewController:popin animated:YES];

        
        
        //点击返回
        
        SecondViewController *secondVC = [[SecondViewController alloc] initViewController];
        [self.navigationController pushViewController:secondVC animated:YES];
        
        [self removeAllFromKeyWindow];
        [self removeAllFromView];

        
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

- (void)loadAvatarInCustomView {
    UIView *customView = nil;
    if ([self.view viewWithTag:89]) {
        customView = [self.view viewWithTag:89];
    } else {
        customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024,768)];
        [customView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.0]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        
        imageView.image = [[UIImage imageNamed:@"image.jpg"]stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        
        [self.view addSubview:imageView];
        
        [customView setTag:89];
        [self.view addSubview:customView];
    }
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInView:customView WithFrame:CGRectMake(120, 60, 60, 60)];
    [avatar setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [avatar setAutoDocking:NO];
    
    avatar.longPressBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView ===  LongPress!!! ===");
        //More todo here.
        
    };
    
    avatar.tapBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView ===  Tap!!! ===");
        //More todo here.
        
    };
    
    avatar.draggingBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView === Dragging!!! ===");
        //More todo here.
        
    };
    
    avatar.dragDoneBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView === DragDone!!! ===");
        //More todo here.
        
    };
    
    avatar.autoDockingBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView === AutoDocking!!! ===");
        //More todo here.
        
    };
    
    avatar.autoDockingDoneBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView === AutoDockingDone!!! ===");
        //More todo here.
        
    };
}

- (void)addControlButton {
    RCDraggableButton *removeAllFromKeyWindow = [[RCDraggableButton alloc] initInView:self.view WithFrame:CGRectMake(10, 280, 300, 44)];
    [removeAllFromKeyWindow addTarget:self action:@selector(removeAllFromKeyWindow) forControlEvents:UIControlEventTouchUpInside];
    [removeAllFromKeyWindow setTitle:@"Remove All From KeyWindow" forState:UIControlStateNormal];
    [removeAllFromKeyWindow setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [removeAllFromKeyWindow setDraggable:NO];
    [self.view addSubview:removeAllFromKeyWindow];
    
    RCDraggableButton *addOneToKeyWindow = [[RCDraggableButton alloc] initInView:self.view WithFrame:CGRectMake(10, 330, 300, 44)];
    [addOneToKeyWindow addTarget:self action:@selector(loadAvatarInKeyWindow) forControlEvents:UIControlEventTouchUpInside];
    [addOneToKeyWindow setTitle:@"Add One To KeyWindow" forState:UIControlStateNormal];
    [addOneToKeyWindow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addOneToKeyWindow setDraggable:NO];
    [self.view addSubview:addOneToKeyWindow];
    
    RCDraggableButton *removeAllFromView = [[RCDraggableButton alloc] initInView:self.view WithFrame:CGRectMake(10, 380, 300, 44)];
    [removeAllFromView addTarget:self action:@selector(removeAllFromView) forControlEvents:UIControlEventTouchUpInside];
    [removeAllFromView setTitle:@"Remove All From View" forState:UIControlStateNormal];
    [removeAllFromView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [removeAllFromView setDraggable:NO];
    [self.view addSubview:removeAllFromView];
    
    RCDraggableButton *addOneToView = [[RCDraggableButton alloc] initInView:self.view WithFrame:CGRectMake(10, 430, 300, 44)];
    [addOneToView addTarget:self action:@selector(loadAvatarInCustomView) forControlEvents:UIControlEventTouchUpInside];
    [addOneToView setTitle:@"Add One To View" forState:UIControlStateNormal];
    [addOneToView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addOneToView setDraggable:NO];
    [self.view addSubview:addOneToView];
}

- (void)removeAllFromKeyWindow {
    [RCDraggableButton removeAllFromKeyWindow];
}

- (void)removeAllFromView {
    [RCDraggableButton removeAllFromView:[self.view viewWithTag:89]];
}

//----------------------------------悬浮按钮



- (BOOL)shouldAutorotate
{
    return YES;
}

//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}

- (IBAction)popViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)popToFirstViewController:(id)sender
{
    ViewController *firstVC = [self.navigationController.viewControllers objectAtIndex:0];
    [self.navigationController popToViewController:firstVC animated:YES];
}

- (IBAction)popToRootViewController:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



#pragma 图片



//-------------------图片保存----------------------



- (void)dealloc {
    NSLog(@"DEALLOC1");
}
@end
