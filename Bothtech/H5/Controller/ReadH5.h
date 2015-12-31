//
//  ReadH5.h
//  Bothtech
//
//  Created by lanhull on 15/12/28.
//  Copyright © 2015年 Andrés Brun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadH5 : NSObject
{
    NSMutableArray *_filelist;
}
-(NSMutableArray*)Path;//分类文件夹
-(NSMutableArray*)File;
-(NSString*)ImageMethod:(int)Click;
-(NSMutableArray*)ImageArray;
-(NSMutableArray*)Branch:(int)dianji;
@end
