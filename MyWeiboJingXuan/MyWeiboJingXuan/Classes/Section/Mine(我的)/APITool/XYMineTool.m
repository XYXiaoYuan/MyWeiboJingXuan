//
//  XYMineTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/9.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYMineTool.h"
#import <MJExtension.h>
#import <FMDB.h>
#import "XYHttpTool.h"
#import "XYSquareItem.h"

@implementation XYMineTool

/** 数据库实例 */
static FMDatabase *_db;

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"mine_square.sqlite"];
    
    // 2.得到数据库
    _db = [FMDatabase databaseWithPath:filename];
    
    // 3.打开数据库
    if ([_db open]) {
        // 4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_mine_square (id integer PRIMARY KEY AUTOINCREMENT,square_dict blob NOT NULL);"];
        if (result) {
//            XYLog(@"成功创表t_mine_square");
        } else {
//            XYLog(@"创表失败t_mine_square");
        }
    }
}


+ (void)mineDataWithParam:(XYMineParam *)param success:(void (^)(XYMineResult *))success failure:(void (^)(NSError *))failure
{
    // 从数据库中读取缓存数据
    NSArray *cacheSquares = [self cacheMineSquares];
    if (cacheSquares.count != 0) {
        if (success) {
            XYMineResult *result = [[XYMineResult alloc] init];
            result.square_list = cacheSquares;
            success(result);
        }
    } else {
        NSDictionary *params = [param mj_keyValues];
        [XYHttpTool get:XYRequestURL params:params success:^(id responseObj) {
            if (success) {
                XYMineResult *result = [XYMineResult mj_objectWithKeyValues:responseObj];
                success(result);
            }
            
            // 百思返回的字典数组
            NSArray *squaresDictArray = responseObj[@"square_list"];
            
            // 缓存微博字典数组
            [self saveMineSquaresDictArray:squaresDictArray];

        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

#pragma mark - 取数据库表中的数据
+ (NSArray *)cacheMineSquares
{
    // 创建可变数组缓存square数据
    NSMutableArray *squares = [NSMutableArray array];
    
    FMResultSet *resultSet = nil;
    resultSet = [_db executeQuery:@"SELECT * FROM t_mine_square"];
    
    // 遍历查询结果
    while (resultSet.next) {
        NSData *squaresDictData = [resultSet objectForColumnName:@"square_dict"];
        NSDictionary *squaresDict = [NSKeyedUnarchiver unarchiveObjectWithData:squaresDictData];
        // 字典转模型
        XYSquareItem *square = [XYSquareItem mj_objectWithKeyValues:squaresDict];
        // 添加模型到数组中
        [squares addObject:square];
    }
    
    return squares;
}

#pragma mark - 往数据库中存数据
+ (void)saveMineSquaresDictArray:(NSArray *)squaresDictArray
{
    for (NSDictionary *squaresDict in squaresDictArray) {
        // 把statusDict字典对象序列化成NSData二进制数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:squaresDict];
        [_db executeUpdate:@"INSERT INTO t_mine_square (square_dict) VALUES (?);",data];
    }
}

@end
