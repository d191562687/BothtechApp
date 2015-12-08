//
//  BMKMapViewController.h
//  Bothtech
//
//  Created by lanhull on 15/12/7.
//  Copyright © 2015年 Andrés Brun. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "RCDraggableButton.h"

@interface BMKMapViewController : ViewController <BMKMapViewDelegate,BMKLocationServiceDelegate>{
    IBOutlet BMKMapView* _mapView;
    IBOutlet UIButton* startBtn;
    IBOutlet UIButton* stopBtn;
    IBOutlet UIButton* followingBtn;
    IBOutlet UIButton* followHeadBtn;
    BMKLocationService* _locService;
}


@end
