//
//  SecondViewController.h
//  SquaresFlipNavigationExample
//
//  Created by Andrés Brun on 7/14/13.
//  Copyright (c) 2013 Andrés Brun. All rights reserved.
//

#import "ViewController.h"
#import "MMGridView.h"
#import "RCDraggableButton.h"

@interface SecondViewController : UIViewController<MMGridViewDataSource, MMGridViewDelegate>
{
   
    IBOutlet MMGridView *gridView;
    IBOutlet UIPageControl *pageControl;
    
}

- (id)initViewController;

@end
