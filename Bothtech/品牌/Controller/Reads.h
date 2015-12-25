//
//  Reads.h
//  Bothtech
//
//  Created by lanhull on 15/12/25.
//  Copyright © 2015年 Andrés Brun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reads : NSObject
{
    NSMutableArray *_filelist;
}
-(NSMutableArray*)Path;//分类文件夹
-(NSMutableArray*)File;
-(NSString*)ImageMethod:(int)Click;
-(NSMutableArray*)ImageArray;
-(NSMutableArray*)Zilei:(int)dianji;

@end
