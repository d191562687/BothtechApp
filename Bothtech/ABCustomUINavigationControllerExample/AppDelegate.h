//
//  AppDelegate.h
//  SquaresFlipNavigationExample
//
//  Created by Andrés Brun on 7/14/13.
//  Copyright (c) 2013 Andrés Brun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
