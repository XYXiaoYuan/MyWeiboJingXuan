//
//  XYTagTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYTagTool.h"
#import <MJExtension.h>
#import <FMDB.h>
#import "XYHttpTool.h"
#import "XYTagResultItem.h"

@implementation XYTagTool

/** 数据库实例 */
static FMDatabase *_db;

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"home_tag.sqlite"];
    
    // 2.得到数据库
    _db = [FMDatabase databaseWithPath:filename];
    
    // 3.打开数据库
    if ([_db open]) {
        // 4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_home_tag (id integer PRIMARY KEY AUTOINCREMENT,home_tag blob NOT NULL);"];
        if (result) {
//            NSLog(@"成功创表t_home_tag");
        } else {
//            NSLog(@"创表失败t_home_tag");
        }
    }
}


+ (void)tagWithParam:(XYTagParam *)param success:(void (^)(XYTagResultItem *result))success failure:(void (^)(NSError *error))failure
{
    
    // 从数据库中读取缓存数据
    NSMutableArray *cacheTags = [self cacheTopicTag];
    if (cacheTags.count != 0) {
        if (success) {
            XYTagResultItem *result = (XYTagResultItem *)cacheTags;
            success(result);
        }
    } else {
        NSDictionary *params = [param mj_keyValues];
        [XYHttpTool get:XYRequestURL params:params success:^(id responseObj) {
            if (success) {
                XYTagResultItem *result = [XYTagResultItem mj_objectWithKeyValues:responseObj];
                success(result);
            }
            
            // 百思返回的字典数组
            NSArray *squaresDictArray = responseObj;
            
            // 缓存微博字典数组
            [self saveTopicTagDictArray:squaresDictArray];
            
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
    
    [self getWithUrl:XYRequestURL param:param resultClass:[XYTagResultItem class] success:success failure:failure];
}

#pragma mark - 取数据库表中的数据
+ (NSMutableArray *)cacheTopicTag
{
    // 创建可变数组缓存square数据
    NSMutableArray *tags = [NSMutableArray array];
    
    FMResultSet *resultSet = nil;
    resultSet = [_db executeQuery:@"SELECT * FROM t_home_tag"];
    
    // 遍历查询结果
    while (resultSet.next) {
        NSData *squaresDictData = [resultSet objectForColumnName:@"home_tag"];
        NSDictionary *squaresDict = [NSKeyedUnarchiver unarchiveObjectWithData:squaresDictData];
        // 字典转模型
        XYTagResultItem *tag = [XYTagResultItem mj_objectWithKeyValues:squaresDict];
        // 添加模型到数组中
        [tags addObject:tag];
    }
    
    return tags;
}

#pragma mark - 往数据库中存数据
+ (void)saveTopicTagDictArray:(NSArray *)tagsDictArray
{
    for (NSDictionary *squaresDict in tagsDictArray) {
        // 把statusDict字典对象序列化成NSData二进制数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:squaresDict];
        [_db executeUpdate:@"INSERT INTO t_home_tag (home_tag) VALUES (?);",data];
    }
}

@end
