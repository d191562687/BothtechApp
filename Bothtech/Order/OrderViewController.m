//
//  OrderViewController.m
//  Bothtech
//
//  Created by lanhull on 15/12/16.
//  Copyright © 2015年 Andrés Brun. All rights reserved.
//

#import "OrderViewController.h"
#import "FoodCell.h"
#import "ShoppingCartCell.h"
#import "OverlayView.h"
#import "ShoppingCartView.h"
#import "BadgeView.h"
#import "ViewController.h"

#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate,ZFReOrderTableViewDelegate>

@property ( nonatomic,strong) NSMutableArray * dataArray;
@property ( nonatomic,strong) NSMutableArray * ordersArray;
@property ( nonatomic,strong) CALayer * dotLayer;
@property ( nonatomic,assign) CGFloat endPointX;
@property ( nonatomic,assign) CGFloat endPointY;
@property ( nonatomic,strong) UIBezierPath * path;
@property ( nonatomic,strong) UITableView * tableView;
@property ( nonatomic,assign) NSUInteger totalOrders;
@property BOOL up;
@property ( nonatomic,strong) ShoppingCartView * ShopCartView;
@property ( nonatomic,strong) UILabel * titleLabel;



@end

@implementation OrderViewController

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
        self = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
     
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    /*
     这只是一个demo,用于显示界面效果,实际的数据请结合项目（如Json 解析放到数据模型里更方便一些）
     */
    
    NSDictionary *dic1 = @{@"id": @9323283,
                           @"name": @"品牌设计",
                           @"min_price": @20000.0,
                           @"praise_num": @11,
                           @"picture":@"1.png",
                           @"month_saled":@"A"};
    
    NSDictionary *dic2 = @{@"id": @9323284,
                           @"name": @"网站建设",
                           @"min_price": @6000.0,
                           @"praise_num": @6,
                           @"picture":@"2.png",
                           @"month_saled":@"B"};
    
    NSDictionary *dic3 = @{@"id": @9323285,
                           @"name": @"移动应用",
                           @"min_price": @20000.0,
                           @"praise_num": @8,
                           @"picture":@"3.png",
                           @"month_saled":@"C"};
    
    NSDictionary *dic4 = @{@"id": @26844943,
                           @"name": @"互动营销",
                           @"min_price": @5000.0,
                           @"praise_num": @1,
                           @"picture":@"4.png",
                           @"month_saled":@"D"};
    
    NSDictionary *dic5 = @{@"id": @9323279,
                           @"name": @"软件开发",
                           @"min_price": @20000.0,
                           @"praise_num": @11,
                           @"picture":@"5.png",
                           @"month_saled":@"E"};
    
    NSDictionary *dic6 = @{};
//
//    NSDictionary *dic7 = @{@"id": @9323243,
//                           @"name": @"功能模块",
//                           @"min_price": @72.0,
//                           @"praise_num": @0,
//                           @"picture":@"7.png",
//                           @"month_saled":@19};
//    
//    NSDictionary *dic8 = @{@"id": @9323220,
//                           @"name": @"功能模块",
//                           @"min_price": @64.0,
//                           @"praise_num": @28,
//                           @"picture":@"8.png",
//                           @"month_saled":@7};
//    
//    NSDictionary *dic9 = @{@"id": @9323280,
//                           @"name": @"功能模块",
//                           @"min_price": @30.0,
//                           @"praise_num": @48,
//                           @"picture":@"9.png",
//                           @"month_saled":@0};
//    
//    NSDictionary *dic10 = @{@"id": @9323267,
//                            @"name": @"功能模块",
//                            @"min_price": @16.0,
//                            @"praise_num": @9,
//                            @"picture":@"10.png",
//                            @"month_saled":@136};
    
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    self.view.backgroundColor = [UIColor blackColor];
    
#pragma mark -设置导航栏


    self.nBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,50)];
    [self.nBarView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.nBarView];
    
    //返回
    UIImage *LeftImage = [UIImage imageNamed:@"返回image.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setImage:LeftImage forState:UIControlStateNormal];
  
    button.frame = CGRectMake(10, 15, 50, 50);
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];

    //工具
    UIImage * RightImage = [UIImage imageNamed:@"工具.png"];
    UIButton *buttonB = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonB setImage:RightImage forState:UIControlStateNormal];
    
    
    buttonB.frame = CGRectMake(970, 17, 50, 50);
    [buttonB addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
       //标题
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(400, 20, 200, 35);
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font=[UIFont fontWithName:@"GurmukhiMN-Bold" size:22];
        _titleLabel.textAlignment =  YES;
        _titleLabel.text = @"套餐选择";


    [self.nBarView addSubview:_titleLabel];
    [self.nBarView addSubview:button];
    [self.nBarView addSubview:buttonB];
    //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    

    
    //这样书写的定义数据，用于后面的动态添加订单个数的key：orderCount。 实际项目中没有这么复杂
    _dataArray = [@[[dic1 mutableCopy],[dic2 mutableCopy],[dic3 mutableCopy],[dic4 mutableCopy],[dic5 mutableCopy],[dic6 mutableCopy]] mutableCopy];
    
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图层-1@2x.png"]];
        UIImageView  * backgroundView = [[UIImageView alloc]init];
    backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home02.jpg"]];
    

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 70)];
    //self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView setBackgroundView:backgroundView];
    
    self.tableView.separatorColor = [UIColor grayColor];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);        // 设置端距，这里表示separator离左边和右边均80像素
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    //购物条
    _ShopCartView = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 70, CGRectGetWidth(self.view.bounds), 70) inView:self.view withObjects:nil];
    _ShopCartView.parentView = self.view;
    _ShopCartView.OrderList.delegate = self;
    _ShopCartView.OrderList.tableView.delegate = self;
    _ShopCartView.OrderList.tableView.dataSource = self;
    _ShopCartView.backgroundColor = [UIColor blackColor];
    
    
//    UIImageView * backgroundViews = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"123qqq.png"]];
//    
//    [_ShopCartView.OrderList.tableView setBackgroundView:backgroundView];
//    
//    
    [self.view addSubview:_ShopCartView];
    
    
    CGRect rect = [self.view convertRect:_ShopCartView.shoppingCartBtn.frame fromView:_ShopCartView];
    
    _endPointX = rect.origin.x + 15;
    _endPointY = rect.origin.y + 35;
    

  //  [self loadAvatarInKeyWindow];
    // Do any additional setup after loading the view from its nib.

}

#pragma mark - setter and getter

- (NSMutableArray *)ordersArray
{
    if (!_ordersArray) {
        _ordersArray = [NSMutableArray array];
        
    }
    return _ordersArray;
}

#pragma mark -导航栏上的按钮方法
-(void)backAction:(id)sender
{

    ViewController * webVC = [[ViewController alloc] initViewController];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = 0;
    if ([tableView isEqual:self.tableView]) {
        count = [_dataArray count];
    }
    else if ([tableView isEqual:self.ShopCartView.OrderList.tableView])
    {
        count = [self.ordersArray[section] count];
    }
    return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.ShopCartView.OrderList.tableView]) {
        return [self.ordersArray count];
        
    }
    return 1;
}


//设置cell背景色
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
 
//    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"333.png"]]; //cell的背景图
//    cell.textLabel.backgroundColor = [UIColor redColor];
    
    cell.backgroundColor = indexPath.row % 2?[UIColor colorWithRed: 240.0/255 green: 240.0/255 blue: 240.0/255 alpha: 1.0]: [UIColor whiteColor];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}



-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    if ([tableView isEqual:self.tableView]) {
        static NSString * cellID = @"FoodCell";
        
        FoodCell * cell = (FoodCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil] lastObject];
            
            float price = [_dataArray[indexPath.row][@"min_price"] floatValue];
//            NSInteger nSaledNum = [_dataArray[indexPath.row][@"month_saled"]integerValue];
            NSInteger nPraiseNum = [_dataArray[indexPath.row][@"praise_num"]integerValue];
            
            cell.name.text = _dataArray[indexPath.row][@"name"];
            cell.price.text = [NSString stringWithFormat:@"￥%.0f",price];
//            cell.month_saled.text = [NSString stringWithFormat:@"已售%ld",(long)nSaledNum];
            cell.month_saled.text = [NSString stringWithFormat:@"【 套餐%@ 】",_dataArray[indexPath.row][@"month_saled"]];

            cell.praise_num.text = [NSString stringWithFormat:@"%ld",(long)nPraiseNum];
            cell.foodImageView.image = [UIImage imageNamed:_dataArray[indexPath.row][@"picture"]];
            cell.foodId = [_dataArray[indexPath.row][@"id"] integerValue];
            cell.amount = _dataArray[indexPath.row][@"orderCount"]?[_dataArray[indexPath.row][@"orderCount"] integerValue]:0;
            
            __weak __typeof(&*cell)weakCell =cell;
            cell.plusBlock = ^(NSInteger nCount,BOOL animated)
            {
                NSMutableDictionary * dic = _dataArray[indexPath.row];
                [dic setObject:[NSNumber numberWithInteger:nCount] forKey:@"orderCount"];
                CGRect parentRect = [weakCell convertRect:weakCell.plus.frame toView:self.view];
                
                
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
                
                [self storeOrders:dict isAdded:animated withSectionIndex:0 withRowIndex:0];
                
                if (animated) {
                    [self JoinCartAnimationWithRect:parentRect];
                    _totalOrders ++;
                }
                else
                {
                    _totalOrders --;
                }
                _ShopCartView.badge.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)_totalOrders];
                [self setCartImage];
                [self setTotalMoney];
                
            };
 
        }
        return cell;
    }
    else if ([tableView isEqual:_ShopCartView.OrderList.tableView])
    {
        static NSString *cellID = @"ShoppingCartCell";
        
        ShoppingCartCell *cell = (ShoppingCartCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil] lastObject];
        }
        NSMutableArray *sectionArray =[NSMutableArray array];
        sectionArray = [self.ordersArray objectAtIndex:indexPath.section];
        
        //
        cell.id = [sectionArray[indexPath.row][@"id"] integerValue];
        cell.nameLabel.text = sectionArray[indexPath.row][@"name"];
        
        float price = [sectionArray[indexPath.row][@"min_price"] floatValue];
        cell.priceLabel.text = [NSString stringWithFormat:@"￥%.0f",price] ;
        
        NSInteger count = [sectionArray[indexPath.row][@"orderCount"] integerValue];
        cell.number = count;
        cell.numberLabel.text = [NSString stringWithFormat:@"%ld",count];
        
        cell.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section % 3 == 0) {
            cell.dotLabel.textColor = [UIColor greenColor];
        }
        else if (indexPath.section % 3 == 1)
        {
            cell.dotLabel.textColor = [UIColor yellowColor];
        }
        else if (indexPath.section % 3 == 2)
        {
            cell.dotLabel.textColor = [UIColor redColor];
        }
        
        cell.operationBlock = ^(NSUInteger nCount,BOOL plus)
        {
            NSMutableDictionary * dic = sectionArray[indexPath.row];
            
            //更新订单列表中的数量
            [dic setObject:[NSNumber numberWithInteger:nCount] forKey:@"orderCount"];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
            
            //获取当前id的所有数量
            NSInteger nTotal = [self CountAllSections:[NSString stringWithFormat:@"%ld",[dic[@"id"] integerValue]]];
            [dict setObject:[NSNumber numberWithInteger:nTotal] forKey:@"orderCount"];
            
            [self storeOrders:dict isAdded:plus withSectionIndex:indexPath.section withRowIndex:indexPath.row];
            
            
            _totalOrders = plus ? ++_totalOrders : --_totalOrders;
            
            _ShopCartView.badge.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)_totalOrders];
            //刷新tableView
            [self.tableView reloadData];
            [self setCartImage];
            [self setTotalMoney];
            if (_totalOrders <=0) {
                [_ShopCartView dismissAnimated:YES];
            }
            
        };
        
        return cell;
    }
    return cell;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -加入购物车动画
-(void) JoinCartAnimationWithRect:(CGRect)rect
{
    
    CGFloat startX = rect.origin.x;
    CGFloat startY = rect.origin.y;
    
    _path= [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    //三点曲线
    [_path addCurveToPoint:CGPointMake(_endPointX, _endPointY)
             controlPoint1:CGPointMake(startX, startY)
             controlPoint2:CGPointMake(startX - 180, startY - 200)];
    
    _dotLayer = [CALayer layer];
    _dotLayer.backgroundColor = [UIColor redColor].CGColor;
    _dotLayer.frame = CGRectMake(0, 0, 15, 15);
    _dotLayer.cornerRadius = (15 + 15) /4;
    [self.view.layer addSublayer:_dotLayer];
    [self groupAnimation];
    
}
#pragma mark - 组合动画
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.5f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.8f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [_dotLayer addAnimation:groups forKey:nil];
    
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.8f];
    
}
- (void)removeFromLayer:(CALayer *)layerAnimation{
    
    [layerAnimation removeFromSuperlayer];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if ([[anim valueForKey:@"animationName"]isEqualToString:@"groupsAnimation"]) {
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:0.9];
        shakeAnimation.toValue = [NSNumber numberWithFloat:1];
        shakeAnimation.autoreverses = YES;
        [_ShopCartView.shoppingCartBtn.layer addAnimation:shakeAnimation forKey:nil];
    }
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView])
    {
        return 120;
    }
    else if ([tableView isEqual:self.ShopCartView.OrderList.tableView])
    {
        return 90;
    }
    return 120;
}

#define SECTION_HEIGHT 30.0
// 设置section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:self.ShopCartView.OrderList.tableView])
    {
        return SECTION_HEIGHT;
    }
    else
        return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, SECTION_HEIGHT)];
    
    UILabel *leftLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 3, SECTION_HEIGHT)];
    [view addSubview:leftLine];
    
    
    if (section == 0) {
        
        leftLine.backgroundColor = [UIColor greenColor];
        UIButton *clear = [UIButton buttonWithType:UIButtonTypeCustom];
        clear.frame= CGRectMake(self.view.bounds.size.width - 120, 0, 120, SECTION_HEIGHT);
        [clear setTitle:@"清空购物车" forState:UIControlStateNormal];
        [clear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        clear.titleLabel.textAlignment = NSTextAlignmentCenter;
        clear.titleLabel.font = [UIFont systemFontOfSize:18 ];
        [clear addTarget:self action:@selector(clearShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:clear];
    }
    else{
        
        if (section % 3 == 0) {
            leftLine.backgroundColor = [UIColor greenColor];
        }
        else if (section % 3 == 1)
        {
            leftLine.backgroundColor = [UIColor yellowColor];
        }
        else if (section % 3 == 2)
        {
            leftLine.backgroundColor = [UIColor redColor];
        }
        
    }
    
    //    view.backgroundColor = kUIColorFromRGB(0x9BCB3D);
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}




#pragma mark - private method

-(void)clearShoppingCart:(UIButton *)sender
{
    [self.ordersArray removeAllObjects];
    
    
    _totalOrders = 0;
    _ShopCartView.badge.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)_totalOrders];
    
    
    [self setTotalMoney];
    [self setCartImage];
    [self.ShopCartView dismissAnimated:YES];
    
    for (NSMutableDictionary *dic in self.dataArray) {
        
        [dic setObject:@"0" forKey:@"orderCount"];
        
    }
    [self.tableView reloadData];
}

-(void)setCartImage
{
    if (_totalOrders) {
        [_ShopCartView setCartImage:@"cart_1"];
    }
    else{
        [_ShopCartView setCartImage:@"cart"];
    }
    
}

-(void)setTotalMoney
{
    NSInteger nTotal = 0;
    for (NSMutableArray *array in self.ordersArray) {
        for (NSMutableDictionary *dic in array) {
            nTotal += [dic[@"orderCount"] integerValue] * [dic[@"min_price"] integerValue];
        }
    }
    
    [_ShopCartView setTotalMoney:nTotal];
    
}
#pragma mark - store orders 存放订单

-(void)storeOrders:(NSMutableDictionary *)dictionary isAdded:(BOOL)added withSectionIndex:(NSInteger)sectionID withRowIndex:(NSInteger)rowID
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    
    if (added) {
        //如果订单数组是空（无商品） 则需创建两个section (1号口袋，2号口袋（被添加）)
        if ([self.ordersArray count] <=0) {
            [self.ordersArray addObject:[NSMutableArray array]];
            [self.ordersArray addObject:[NSMutableArray array]];
        }
        //如果是从商品列表中添加，传人的sectionID为0
        //如果是从订单列表中添加，传人的sectionID是订单中实际的section
        
        for (NSMutableDictionary *dic in self.ordersArray[sectionID]) {
            if (dic[@"id"] == dict[@"id"]){
                
                NSInteger count = [self CountOthersWithoutSection:sectionID foodID:dictionary[@"id"]];
                NSInteger nCount = [dict[@"orderCount"] integerValue] - count;
                
                [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
                
                self.ShopCartView.OrderList.objects = self.ordersArray;
                [self.ShopCartView.OrderList.tableView reloadData];
                
                return;
            }
        }
        
        NSInteger count = [self CountOthersWithoutSection:sectionID foodID:dictionary[@"id"]];
        count = [dictionary[@"orderCount"] integerValue] - count;
        [dictionary setObject:[NSString stringWithFormat:@"%ld",count] forKey:@"orderCount"];
        [self.ordersArray[sectionID] addObject:dictionary];
        
        self.ShopCartView.OrderList.objects = self.ordersArray;
        [self.ShopCartView.OrderList.tableView reloadData];
    }
    else{
        //从商品列表删除，传人的section =0;优先section：0移除商品，然后再从其他section移除商品
        //从订单列表删除，就从指定的section移除相同的商品
        
        //block 代码段
        void(^block)(NSInteger,NSInteger) = ^(NSInteger section,NSInteger row){
            
            NSDictionary *dic = self.ordersArray[section][row];
            NSInteger count = [dic[@"orderCount"] integerValue];
            if (count <= 0) {
                
                [self.ordersArray[section] removeObjectAtIndex:row];
                self.ShopCartView.OrderList.objects = self.ordersArray;
                [self.ShopCartView.OrderList.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:section]]  withRowAnimation:UITableViewRowAnimationBottom];
                
                //section
                if ([self.ordersArray[section] count] <=0) {
                    [self.ordersArray removeObjectAtIndex:section];
                    [self.ShopCartView.OrderList.tableView deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationBottom];
                }
                
                [self.ShopCartView.OrderList.tableView reloadData];
                [self.ShopCartView updateFrame:self.ShopCartView.OrderList];
            }
            else{
                
            }
        };
        
        
        if (!sectionID && !rowID) {
            NSMutableDictionary *dic = self.ordersArray[sectionID][rowID];
            
            if (dic[@"id"] == dict[@"id"]) {
                NSInteger nCount = [dic[@"orderCount"] integerValue];
                                nCount -= 1;
                [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
                block(sectionID,rowID);
                
                self.ShopCartView.OrderList.objects = self.ordersArray;
                
                [self.ShopCartView.OrderList.tableView reloadData];
            }
            else{
                //section:0 有该商品
                NSMutableArray *sectionArray = self.ordersArray[sectionID];
                NSInteger row = 0;
                for (NSMutableDictionary *dic in sectionArray)
                {
                    if (dict[@"id"] == dic[@"id"]) {
                        NSInteger nCount = [dic[@"orderCount"] integerValue];
                        nCount -= 1;
                        [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
                        block(sectionID,row);
                        
                        self.ShopCartView.OrderList.objects = self.ordersArray;
                        
                        [self.ShopCartView.OrderList.tableView reloadData];
                        
                        return;
                    }
                    row ++;
                }
                
                //section:0 没有该商品
                for (NSInteger i = sectionID + 1; i < [self.ordersArray count]; i ++) {
                    
                    sectionArray = self.ordersArray[i];
                    row = 0;
                    for (NSMutableDictionary *dic in sectionArray) {
                        if (dict[@"id"] == dic[@"id"]) {
                            NSInteger nCount = [dic[@"orderCount"] integerValue];
                            nCount -= 1;
                            [dic setObject:[NSString stringWithFormat:@"%ld",nCount] forKey:@"orderCount"];
                            
                            if (nCount <= 0) {
                                
                                block(i,row);
                                self.ShopCartView.OrderList.objects = self.ordersArray;
                                
                                [self.ShopCartView.OrderList.tableView reloadData];
                                return;
                            }
                            
                            //刷新当前row
                            [self.ShopCartView.OrderList.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:i],nil] withRowAnimation:UITableViewRowAnimationNone];
                            
                            self.ShopCartView.OrderList.objects = self.ordersArray;
                            
                        }
                        row ++;
                    }
                }
            }
        }
        else{
            
            block(sectionID,rowID);
            
        }
        
        
    }
    
}

//计算在其他section中的指定fooid的个数
-(NSInteger)CountOthersWithoutSection:(NSInteger)sectionID foodID:(NSString *)foodID
{
    NSInteger count = 0;
    for (int i = 0; i< self.ordersArray.count; i++) {
        if (sectionID == i) {
            continue;
        }
        NSMutableArray *array = self.ordersArray[i];
        for (NSMutableDictionary *dic in array) {
            if ([dic[@"id"] integerValue] == [foodID integerValue]) {
                count += [dic[@"orderCount"] integerValue];
            }
        }
    }
    
    return count;
}
//计算所有section中指定fooid的个数
-(NSInteger)CountAllSections:(NSString *)foodID
{
    int nCount = 0;
    for (NSMutableArray *array in self.ordersArray) {
        for (NSMutableDictionary *dic in array)
        {
            if ([dic[@"id"] integerValue] == [foodID integerValue]) {
                nCount += [dic[@"orderCount"] integerValue];
            }
        }
    }
    NSMutableDictionary *dic = [self GetDictionaryFromID:[foodID integerValue]];
    
    [dic setObject:[NSNumber numberWithInt:nCount] forKey:@"orderCount"];
    return nCount;
}

//foodid 获取其模型model 或者字典

-(NSMutableDictionary *)GetDictionaryFromID:(NSInteger)foodID
{
    for (NSMutableDictionary *dic in self.dataArray) {
        if ([dic[@"id"] integerValue] == foodID) {
            return dic;
        }
    }
    return nil;
}


#pragma mark - ZFOrderListsViewDelegate

-(void) updateDataSource:(NSMutableArray *)dataArrays
{
    if ([self.ShopCartView.OrderList.delegate respondsToSelector:@selector(updateDataSource:)]) {
        
        
        self.ordersArray = dataArrays;
        
        //        [self.delegate updateDataSource:dataArrays];
        [self.ShopCartView updateFrame:self.ShopCartView.OrderList];
        [self.ShopCartView.OrderList.tableView reloadData];
        
    }
}

//合并相同的row
-(void) mergeRowsInSection:(NSInteger)section splitRowIdentifier:(NSString *)identifier
{
    if ([self.ShopCartView.OrderList.delegate respondsToSelector:@selector(mergeRowsInSection:splitRowIdentifier:)]) {
        
        NSMutableArray *array = [self.ordersArray objectAtIndex:section];
        
        if (identifier) {
            int index = 0;
            
            for (NSMutableDictionary *dic in array) {
                if ([dic[@"id"] integerValue] == [identifier integerValue]){
                    NSInteger count = [dic[@"orderCount"] integerValue] + 1;
                    [dic setObject:[NSNumber numberWithInteger:count] forKey:@"orderCount"];
                    
                    [self.ShopCartView.OrderList.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:section]]  withRowAnimation:UITableViewRowAnimationFade];
                    [self.ShopCartView updateFrame:self.ShopCartView.OrderList];
                    return;
                }
                index ++;
            }
            
            //快速获取当前foodid的详情
            
            for (NSDictionary *dictionary in self.dataArray) {
                if ([dictionary[@"id"] integerValue]== [identifier integerValue]) {
                    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
                    [dict setObject:@1 forKey:@"orderCount"];
                    [array addObject:dict];
                    
                    
                    if (array.count > 1) {
                        [self.ShopCartView.OrderList.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:array.count-1 inSection:section]]  withRowAnimation:UITableViewRowAnimationFade];
                    }
                    else{
                        [self.ShopCartView.OrderList.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:section]]  withRowAnimation:UITableViewRowAnimationFade];
                    }
                    
                    //更新购物清单的frame
                    [self.ShopCartView updateFrame:self.ShopCartView.OrderList];
                }
            }
        }
        
        int sameIndex = -1;
        for(int i = 0; i< array.count; i++){
            for (int j = i + 1; j < array.count; j++) {
                
                if ([array[i][@"id"] integerValue] == [array[j][@"id"] integerValue]) {
                    
                    NSInteger count = [array[i][@"orderCount"] integerValue] + [array[j][@"orderCount"] integerValue];
                    [array[i] setObject:[NSNumber numberWithInteger:count] forKey:@"orderCount"];
                    sameIndex = j;
                    [self.ShopCartView.OrderList.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:section]]  withRowAnimation:UITableViewRowAnimationFade];
                    
                    break;
                }
            }
            
            if (sameIndex > 0) {
                //合并相同的数据
                
                [array removeObjectAtIndex:sameIndex];
                
                [self.ShopCartView.OrderList.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:sameIndex inSection:section]]  withRowAnimation:UITableViewRowAnimationFade];
                
                
                //更新购物清单的frame
                [self.ShopCartView updateFrame:self.ShopCartView.OrderList];
                
                break;
            }
        }
        
    }
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

-(void)dealTap:(UITapGestureRecognizer *)tap
{
    
    ViewController * webVC = [[ViewController alloc] initViewController];
    [self.navigationController pushViewController:webVC animated:YES];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"111");
    
    
}

@end
