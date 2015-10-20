//
//  ViewController.m
//  webView
//
//  Created by lanhull on 15/10/12.
//  Copyright © 2015年 bothtech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)NSMutableArray *addEbookTeim;
@property (nonatomic,strong)UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.qq.com"]];
    [self.view addSubview: _webView];
    //缩进
    [_webView loadRequest:request];

    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
