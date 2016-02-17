//
//  BMViewController.h
//  Bothtech
//
//  Created by lanhull on 16/1/15.
//  Copyright © 2016年 Andrés Brun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCMPlayNDropView.h"

@interface BMViewController : UIViewController<CCMPlayNDropViewDelegate>

@property (nonatomic,retain) NSMutableArray *imageArray;

- (id)initViewController;

@end
