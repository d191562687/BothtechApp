//
//  Reads.m
//  Bothtech
//
//  Created by lanhull on 15/12/25.
//  Copyright © 2015年 Andrés Brun. All rights reserved.
//

#import "Reads.h"

@implementation Reads
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
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]initWithObjects:@"luosimao服务平台logo",@"一汽丰田",@"中国发展研究基金会",@"中国建筑结构金属协会",@"中国支教联盟",@"中国铁道出版社",@"初心武道场Logo",@"初见",@"友盟",@"咕咚",@"大成律师事务所",@"天路公考网",@"尚城同力",@"微盟",@"快法务",@"支付宝",@"普达财务logo",@"曲美家居",@"果多美",@"派多格",@"爱奇艺",@"百度",@"百度翻译",@"百度识图",@"金龙腾",@"银鹭",@"加", nil];
    return imageArray;
}

-(NSString*)ImageMethod:(int)Click
{
    
    return [self ImageArray][Click];
}
//每个分类的个数
-(NSString*)Num:(int)i
{
    NSArray *NumArray = [[NSArray alloc]initWithObjects:@"3",@"3",@"6",@"4",@"12",@"9",@"5",@"9",@"9",@"8",@"6",@"6",@"7",@"6",@"19",@"7",@"7",@"8",@"5",@"8", nil];
    return NumArray[i];
}


-(NSMutableArray*)Zilei:(int)dianji
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int a = 0; a<[[self Num:dianji]integerValue]; a++) {
        
        [array addObject:[NSString stringWithFormat:@"%@%d",[self ImageMethod:dianji],a]];
    }
    
    
    return array;
    
}



@end
