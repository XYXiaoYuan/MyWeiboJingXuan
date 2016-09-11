//
//  XYCategoryTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/8.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYRecommendCategoryTool.h"
#import <MJExtension.h>
#import <FMDB.h>
#import "XYHttpTool.h"
#import "XYRecommendCategoryItem.h"


@implementation XYRecommendCategoryTool

/** 数据库实例 */
static FMDatabase *_db;

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"recommend_category.sqlite"];
    
    // 2.得到数据库
    _db = [FMDatabase databaseWithPath:filename];
    
    // 3.打开数据库
    if ([_db open]) {
        // 4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_recommend_category (id integer PRIMARY KEY AUTOINCREMENT,size integer NOT NULL,total integer NOT NULL,recommend_category blob NOT NULL);"];
        if (result) {
//            XYLog(@"成功创表t_recommend_category");
        } else {
//            XYLog(@"创表失败t_recommend_category");
        }
    }
}

+ (void)recommendCategoryWithParam:(XYRecommendCategoryParam *)param success:(void (^)(XYRecommendCategoryResult *result))success failure:(void (^)(NSError *error))failure
{
    // 从数据库中读取缓存数据
    NSArray *cacheCategories = [self cacheRecommendCategories];
    if (cacheCategories.count != 0) {
        if (success) {
            XYRecommendCategoryResult *result = [[XYRecommendCategoryResult alloc] init];
            result.list = cacheCategories;
            success(result);
        }
    } else {
        NSDictionary *params = [param mj_keyValues];
        [XYHttpTool get:XYRequestURL params:params success:^(id responseObj) {
            if (success) {
                XYRecommendCategoryResult *result = [XYRecommendCategoryResult mj_objectWithKeyValues:responseObj];
                success(result);
            }
            
            // 百思返回的字典数组
            NSArray *categoriesDictArray = responseObj[@"list"];
            NSInteger size = (NSInteger)responseObj[@"size"];
            NSInteger total = (NSInteger)responseObj[@"total"];
            
            // 缓存微博字典数组
            [self saveRecommendCategoriesDictArray:categoriesDictArray size:size total:total];
            
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
//    [self getWithUrl:XYRequestURL param:param resultClass:[XYRecommendCategoryResult class] success:success failure:failure];
}

#pragma mark - 取数据库表中的数据
+ (NSArray *)cacheRecommendCategories
{
    // 创建可变数组缓存square数据
    NSMutableArray *categories = [NSMutableArray array];
    
    FMResultSet *resultSet = nil;
    resultSet = [_db executeQuery:@"SELECT * FROM t_recommend_category"];
    
    // 遍历查询结果
    while (resultSet.next) {
        NSData *categoryDictData = [resultSet objectForColumnName:@"recommend_category"];
        NSDictionary *categoryDict = [NSKeyedUnarchiver unarchiveObjectWithData:categoryDictData];
        // 字典转模型
        XYRecommendCategoryItem *category = [XYRecommendCategoryItem mj_objectWithKeyValues:categoryDict];
        // 添加模型到数组中
        [categories addObject:category];
    }
    
    return categories;
}

#pragma mark - 往数据库中存数据
+ (void)saveRecommendCategoriesDictArray:(NSArray *)categoriesDictArray size:(NSInteger)size total:(NSInteger)total
{
    for (NSDictionary *squaresDict in categoriesDictArray) {
        // 把statusDict字典对象序列化成NSData二进制数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:squaresDict];
        [_db executeUpdate:@"INSERT INTO t_recommend_category (size,total,recommend_category) VALUES (?,?,?);",size,total,data];
    }
}

@end
