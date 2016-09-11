//
//  XYEssenceTool.m
//  MyWeiboJingXuan
//
//  Created by 袁小荣 on 16/8/22.
//  Copyright © 2016年 bruceyuan. All rights reserved.
//

#import "XYEssenceTool.h"
#import <MJExtension.h>
#import <FMDB.h>
#import "XYHttpTool.h"
#import "XYTopicItem.h"

@implementation XYEssenceTool

/** 数据库实例 */
static FMDatabase *_db;

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"home_topic.sqlite"];
    
    // 2.得到数据库
    _db = [FMDatabase databaseWithPath:filename];
    
    // 3.打开数据库
    if ([_db open]) {
        // 4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_home_topic (id integer PRIMARY KEY AUTOINCREMENT,home_list blob NOT NULL);"];
        if (result) {
//            XYLog(@"成功创表t_home_topic");
        } else {
//            XYLog(@"创表失败t_home_topic");
        }
    }
}


+ (void)essenceWithParam:(XYEssenceParam *)param success:(void (^)(XYEssenceResult *result))success failure:(void (^)(NSError *error))failure
{
    // 从数据库中读取缓存数据(帖子模型数组,和info模型)
//    NSArray *cacheHomeTopics = [self cacheHomeTopicsWithParam:param];
//    if (cacheHomeTopics.count != 0) { // 有缓存数据
//        if (success) {
//            XYEssenceResult *result = [[XYEssenceResult alloc] init];
//            result.list = cacheHomeTopics;
//            success(result);
//        }
//    } else { // 没有缓存数据
//        NSDictionary *params = [param mj_keyValues];
//        
//        [XYHttpTool get:XYRequestURL params:params success:^(id responseObj) {
//            if (success) {
//                XYEssenceResult *result = [XYEssenceResult mj_objectWithKeyValues:responseObj];
//                success(result);
//            }
//            
//            // 百思返回的字典数组
//            NSArray *topicDictArray = responseObj[@"list"];
//            
//            // 缓存帖子字典数组
//            [self saveHomeTopicDictArray:topicDictArray];
//            
//        } failure:^(NSError *error) {
//            if (failure) {
//                failure(error);
//            }
//        }];
//    }
    
    
    [self getWithUrl:XYRequestURL param:param resultClass:[XYEssenceResult class] success:success failure:failure];
}

+ (NSArray *)cacheHomeTopicsWithParam:(XYEssenceParam *)param
{
    // 创建可变数组缓存帖子数据
    NSMutableArray *topics = [NSMutableArray array];
    
    // 根据请求参数查询数据
    FMResultSet *resultSet = nil;
    if (param.type) {
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_topic;"];
    }
    
    while (resultSet.next) {
        NSData *topicDictData = [resultSet objectForColumnName:@"home_list"];
        
        NSDictionary *topicDict = [NSKeyedUnarchiver unarchiveObjectWithData:topicDictData];
        
        // 字典转模型
        XYTopicItem *topic = [XYTopicItem mj_objectWithKeyValues:topicDict];
        // 添加模型到数组中
        [topics addObject:topic];
    }
    
    return topics;
}


+ (void)saveHomeTopicDictArray:(NSArray *)topicDictArray
{
    for (NSDictionary *topicDict in topicDictArray) {
        // 把statusDict字典对象序列化成NSData二进制数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:topicDict];
        [_db executeUpdate:@"INSERT INTO t_home_topic (home_list) VALUES (?);",data];
    }
}



@end
