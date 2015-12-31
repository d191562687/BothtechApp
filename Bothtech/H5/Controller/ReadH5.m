//
//  ReadH5.m
//  Bothtech
//
//  Created by lanhull on 15/12/28.
//  Copyright © 2015年 Andrés Brun. All rights reserved.
//

#import "ReadH5.h"

@implementation ReadH5
//分类图片路径
-(NSMutableArray*)Route
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,                                                                          NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSMutableArray *filelist = [[NSMutableArray alloc]init];
    [filelist addObject:[fileManager subpathsOfDirectoryAtPath:documentsDirectory error:&error]];
    NSLog(@"_+_+%@",documentsDirectory);
    
    
    return filelist[0];
    
}

//



//得到documents文件下的分类文件夹
-(NSMutableArray*)Path
{
    NSMutableArray *TypeArray = [[NSMutableArray alloc]init];
    
    
    for (NSString *fileName in [self Route]) {
        if ([fileName rangeOfString:@"png"].location>=NSNotFound) {
            if ([fileName rangeOfString:@".DS_Store"].location>=NSNotFound){
                
                
                [TypeArray addObject:fileName];
                
            }
            
        }
    }
    
    return TypeArray;
}


//得到子图片数组
-(NSMutableArray*)File
{
    NSMutableArray *Array = [[NSMutableArray alloc]init];
    for (NSString *file in [self Path]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,                                                                          NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imageDirectory = [documentsDirectory stringByAppendingPathComponent:file];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        _filelist = [[NSMutableArray alloc]init];
        [_filelist addObject:[fileManager subpathsOfDirectoryAtPath:imageDirectory error:&error]];
        
        [_filelist[0] removeObjectAtIndex:0];
        
        [Array addObject:_filelist[0]];
        
    }
    return Array;
}

-(NSMutableArray*)ImageArray
{
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]initWithObjects:@"H501",@"H502",@"H503",@"H504",@"H505",@"H506",@"H507",@"H508",@"H509", nil];
    return imageArray;
}

-(NSString*)ImageMethod:(int)Click
{
    
    return [self ImageArray][Click];
}
//每个分类的个数
-(NSString*)Num:(int)i
{
    NSArray *NumArray = [[NSArray alloc]initWithObjects:@"7",@"4",@"7",@"8",@"8",@"7",@"7",@"9",@"9", nil];
    return NumArray[i];
}


-(NSMutableArray*)Branch:(int)dianji
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int a = 0; a<[[self Num:dianji]integerValue]; a++) {
        
        [array addObject:[NSString stringWithFormat:@"%@%d",[self ImageMethod:dianji],a]];
    }
    
    
    return array;
    
}






@end
