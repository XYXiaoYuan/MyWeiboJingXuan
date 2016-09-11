//
//  XYRecommendTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/9/8.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYRecommendUserTool.h"
#import <MJExtension.h>
#import <FMDB.h>
#import "XYHttpTool.h"
#import "XYRecommendUserItem.h"

@implementation XYRecommendUserTool

/** 数据库实例 */
static FMDatabase *_db;

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"recommend_user.sqlite"];
    
    // 2.得到数据库
    _db = [FMDatabase databaseWithPath:filename];
    
    // 3.打开数据库
    if ([_db open]) {
        // 4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_recommend_user (id integer PRIMARY KEY AUTOINCREMENT,category_id integer NOT NULL,page integer NOT NULL,total_page integer NOT NULL, count NOT NULL,total integer NOT NULL,next_page integer NOT NULL,recommend_user blob NOT NULL);"];
        if (result) {
//            XYLog(@"成功创表t_recommend_user");
        } else {
//            XYLog(@"创表失败t_recommend_user");
        }
    }
}


+ (void)recommendUserWithParam:(XYRecommendUserParam *)param success:(void (^)(XYRecommendUserResult *result))success failure:(void (^)(NSError *error))failure
{
    // 从数据库中读取缓存数据
    NSArray *cacheUsers = [self cacheRecommendUsersWithParam:param];
    if (cacheUsers.count != 0) {
        if (success) {
            XYRecommendUserResult *result = [[XYRecommendUserResult alloc] init];
            result.list = cacheUsers;
            success(result);
        }
    } else {
        NSDictionary *params = [param mj_keyValues];
        [XYHttpTool get:XYRequestURL params:params success:^(id responseObj) {
            if (success) {
                XYRecommendUserResult *result = [XYRecommendUserResult mj_objectWithKeyValues:responseObj];
                success(result);
            }
            
            // 百思返回的字典数组
            NSArray *usersDictArray = responseObj[@"list"];
            NSInteger total_page = (NSInteger)responseObj[@"total_page"];
            NSInteger count = (NSInteger)responseObj[@"count"];
            NSInteger total = (NSInteger)responseObj[@"total"];
            NSInteger next_page = (NSInteger)responseObj[@"next_page"];
            
            // 缓存微博字典数组
            [self saveRecommendUsersDictArray:usersDictArray total_page:total_page count:count total:total next_page:next_page param:param];
            
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
    [self getWithUrl:XYRequestURL param:param resultClass:[XYRecommendUserResult class] success:success failure:failure];
}

#pragma mark - 取数据库表中的数据
+ (NSArray *)cacheRecommendUsersWithParam:(XYRecommendUserParam *)param
{
    // 创建可变数组缓存square数据
    NSMutableArray *users = [NSMutableArray array];
    
    FMResultSet *resultSet = nil;
    if (param.category_id && param.page) {
        resultSet = [_db executeQuery:@"SELECT * FROM t_recommend_user WHERE category_id = ? AND page = ?",param.category_id,param.page];
    }
    
    // 遍历查询结果
    while (resultSet.next) {
        NSData *userDictData = [resultSet objectForColumnName:@"recommend_user"];
        NSDictionary *userDict = [NSKeyedUnarchiver unarchiveObjectWithData:userDictData];
        // 字典转模型
        XYRecommendUserItem *user = [XYRecommendUserItem mj_objectWithKeyValues:userDict];
        // 添加模型到数组中
        [users addObject:user];
    }
    
    return users;
}

#pragma mark - 往数据库中存数据
+ (void)saveRecommendUsersDictArray:(NSArray *)usersDictArray total_page:(NSInteger)total_page count:(NSInteger)count total:(NSInteger)total next_page:(NSInteger)next_page param:(XYRecommendUserParam *)param
{
    for (NSDictionary *usersDict in usersDictArray) {
        // 把statusDict字典对象序列化成NSData二进制数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:usersDict];
        [_db executeUpdate:@"INSERT INTO t_recommend_user (category_id,page,total_page,count,total,next_page,recommend_user) VALUES (?,?,?,?,?,?,?);",param.category_id,param.page,total_page,count,total,next_page,data];
    }
}


@end
