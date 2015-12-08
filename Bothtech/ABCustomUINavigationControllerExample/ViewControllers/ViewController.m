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

#import "PopMenu.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (nonatomic, strong) PopMenu *popMenu;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
	// Do any additional setup after loading the view, typically from a nib.
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

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (IBAction)pushViewController:(id)sender {
    SecondViewController *secondVC = [[SecondViewController alloc] initViewController];
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (IBAction)pushToThirthViewController:(id)sender {
    ThirthViewController *thirthVC = [[ThirthViewController alloc] initViewController];
    [self.navigationController pushViewController:thirthVC animated:YES];
}


- (void)showMenu {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:4];
    
    MenuItem *menuItem = [MenuItem itemWithTitle:@"App" iconName:@"post_type_bubble_App1"];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"网站建设" iconName:@"post_type_bubble_www2" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"H5" iconName:@"post_type_bubble_H53" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"品牌" iconName:@"post_type_bubble_4" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"OA" iconName:@"post_type_bubble_5" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"订单" iconName:@"post_type_bubble_6" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"关于我们" iconName:@"post_type_bubble_me7" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Map" iconName:@"post_type_bubble_Position8" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.000]];
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
        if ([selectedItem.title  isEqual: @"App"]) {
            
            SecondViewController *secondVC = [[SecondViewController alloc] initViewController];
            [self.navigationController pushViewController:secondVC animated:YES];

            
        }
        if ([selectedItem.title  isEqual: @"Map"]) {
            BMKMapViewController * mapVC = [[BMKMapViewController alloc] initViewController];
            [self.navigationController pushViewController:mapVC animated:YES];
        }

        
    };
    
    [_popMenu showMenuAtView:self.view];
    
    //    [_popMenu showMenuAtView:self.view startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self showMenu];
}

@end
