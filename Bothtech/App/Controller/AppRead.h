//
//  AppRead.h
//  Bothtech
//
//  Created by lanhull on 16/1/8.
//  Copyright © 2016年 Andrés Brun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppRead : NSObject
{
    NSMutableArray *_filelist;
}
-(NSMutableArray*)Path;//分类文件夹
-(NSMutableArray*)File;
-(NSString*)ImageMethod:(int)Click;
-(NSMutableArray*)ImageArray;
-(NSMutableArray*)Branch:(int)dianji;


@end
