//
//  BMViewController.m
//  Bothtech
//
//  Created by lanhull on 16/1/15.
//  Copyright © 2016年 Andrés Brun. All rights reserved.
//

#import "BMViewController.h"
#import <MaryPopin/UIViewController+MaryPopin.h>

@interface BMViewController ()

@property (nonatomic,strong)UIImageView *imgView ;

@end

@implementation BMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)addImageView{
    
    UIView * aView = [[UIView alloc] init];
    
   aView.backgroundColor  =[UIColor redColor];
    
    
    for (UIView *view in aView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i<_imageArray.count; i++) {
        //
        
        float w = SIZE.width;
        float h = SIZE.height ;
        float x = i*w;
        float y = 0;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        
        _imgView = [[UIImageView alloc] init];
        _imgView.userInteractionEnabled = YES;
        //        imgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"图层-1@2x.png"]];
        _imgView.backgroundColor = [UIColor blackColor];
        _imgView.image = [UIImage imageNamed:_imageArray[i]];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:_imgView];
        
        
        
 
        
        _imgView.frame = CGRectMake(0, 0, w-0, h);
        
        
    }

     [self.view addSubview:aView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
