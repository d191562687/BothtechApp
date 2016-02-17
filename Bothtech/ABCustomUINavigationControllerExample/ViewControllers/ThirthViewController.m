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
    
 

    UIImageView * viewiPhone =  [[UIImageView alloc]initWithFrame:CGRectMake(350, 20, 300,700)];
    
    UIImage*img =[UIImage imageNamed:@"手机镂空图.png"];
    [viewiPhone setBackgroundColor:[UIColor colorWithPatternImage:img]];
    [self.CFView addSubview:viewiPhone];


    CoverFlowView *coverFlowView = [CoverFlowView coverFlowViewWithFrame:self.view.frame andImages:_sourceImages sideImageCount:3 sideImageScale:0.5 middleImageScale:0.90];
    [self.CFView addSubview:coverFlowView];
    
    
    //双击返回
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
 

    
}


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
