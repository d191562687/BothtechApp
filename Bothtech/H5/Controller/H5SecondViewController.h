


#import "ViewController.h"
#import "MMGridView.h"
#import "RCDraggableButton.h"

@interface H5SecondViewController : UIViewController<MMGridViewDataSource, MMGridViewDelegate>
{
    
    IBOutlet MMGridView *gridView;
    IBOutlet UIPageControl *pageControl;
    
}

- (id)initViewController;

@end
