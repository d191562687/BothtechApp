//
//  Read.h
//  ImageAPP
//
//  Created by bothtech on 14-9-14.
//  Copyright (c) 2014年 bothtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Read : NSObject
{
    NSMutableArray *_filelist;
}
-(NSMutableArray*)Path;//分类文件夹
-(NSMutableArray*)File;
-(NSString*)ImageMethod:(int)Click;
-(NSMutableArray*)ImageArray;
-(NSMutableArray*)Zilei:(int)dianji;
@end
