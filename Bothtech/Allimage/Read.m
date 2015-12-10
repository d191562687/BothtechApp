//
//  Read.m
//  ImageAPP
//
//  Created by bothtech on 14-9-14.
//  Copyright (c) 2014年 bothtech. All rights reserved.
//

#import "Read.h"

@implementation Read
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
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]initWithObjects:@"北京工业大学",@"彼岸春风网站",@"从头开始网站",@"电力工业网",@"格瑞德曼",@"供暖信息报网站",@"浩德仪器网",@"回龙观社区网",@"佳饰光网站",@"教育网站",@"酒窖网站",@"李纯博个人网站",@"企业网站模板",@"世纪鼎城",@"天路公考网",@"易巢网站",@"萤火虫网站",@"中诚通达汽车商城",@"中兴天安网站",@"LULU花店商城", nil];
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
