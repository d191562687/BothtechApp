//
//  SecondViewController.m
//  SquaresFlipNavigationExample
//
//  Created by Andrés Brun on 7/14/13.
//  Copyright (c) 2013 Andrés Brun. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirthViewController.h"
#import "ViewController.h"
#import "FlipSquaresNavigationController.h"
#import "MMGridViewDefaultCell.h"
#import "ViewController.h"



@interface SecondViewController ()
- (IBAction)popViewController:(id)sender;
- (void)reload;
- (void)setupPageControl;



@end

@implementation SecondViewController

#pragma - Object lifecycle



- (void)viewDidUnload {
    gridView = nil;
    pageControl = nil;
    [super viewDidUnload];
}

- (id)initViewController
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPhone" bundle:nil];
    } else {
        self = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPad" bundle:nil];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
    // Do any additional setup after loading the view from its nib.
    // Give us a nice title
    self.title = @"MMGridView Demo";
    
    // Create a reload button
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                  target:self
                                                                                  action:@selector(reload)];
    self.navigationItem.rightBarButtonItem = reloadButton;
    
    // setup the page control
    [self setupPageControl];
    
    //按钮
    [self loadAvatarInKeyWindow];
    
//    [self loadAvatarInCustomView];
    
  //  [self addControlButton];

}




#pragma 悬浮按钮

- (void)loadAvatarInKeyWindow {
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(900, 630, 90, 90)];
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
        ViewController *firstVC = [self.navigationController.viewControllers objectAtIndex:0];
        [self.navigationController popToViewController:firstVC animated:YES];

  
        
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

- (void)loadAvatarInCustomView {
    UIView *customView = nil;
    if ([self.view viewWithTag:89]) {
        customView = [self.view viewWithTag:89];
    } else {
        customView = [[UIView alloc] initWithFrame:CGRectMake(10, 64, 300, 200)];
        [customView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.0]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        
        imageView.image = [[UIImage imageNamed:@"image.jpg"]stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        
        [self.view addSubview:imageView];
        
        [customView setTag:89];
        [self.view addSubview:customView];
    }
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInView:customView WithFrame:CGRectMake(120, 60, 130, 110)];
    [avatar setBackgroundImage:[UIImage imageNamed:@"avatar1"] forState:UIControlStateNormal];
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


//-------------------------------------悬空按钮




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)reload
{
    [gridView reloadData];
}


- (void)setupPageControl
{
    pageControl.numberOfPages = gridView.numberOfPages;
    pageControl.currentPage = gridView.currentPageIndex;
}

// ----------------------------------------------------------------------------------

#pragma - MMGridViewDataSource

- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView
{
    return 42;
}


- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSUInteger)index
{
    MMGridViewDefaultCell *cell = [[MMGridViewDefaultCell alloc] initWithFrame:CGRectNull];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %lu", (unsigned long)index];
    cell.imageView.image = [UIImage imageNamed:@"cell-image.png"];
    
    return cell;
}

// ----------------------------------------------------------------------------------

#pragma - MMGridViewDelegate

- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    
    ThirthViewController *thirthVC = [[ThirthViewController alloc] initViewController];
    [self.navigationController pushViewController:thirthVC animated:YES];
    
    [self removeAllFromKeyWindow];
    [self removeAllFromView];
}


- (void)gridView:(MMGridView *)gridView didDoubleTapCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[NSString stringWithFormat:@"Cell at index %lu was double tapped.", (unsigned long)index]
                                                   delegate:nil
                                          cancelButtonTitle:@"Cool!"
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)gridView:(MMGridView *)theGridView changedPageToIndex:(NSUInteger)index
{
    [self setupPageControl];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}



//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}

- (IBAction)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pushViewController:(id)sender {
    ThirthViewController *thirthVC = [[ThirthViewController alloc] initViewController];
    [self.navigationController pushViewController:thirthVC animated:YES];
}

@end
