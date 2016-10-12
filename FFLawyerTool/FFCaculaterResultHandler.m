//
//  FFCaculaterResultHandler.m
//  FFLawyerTool
//
//  Created by fanly frank on 4/18/16.
//  Copyright © 2016 fanly frank. All rights reserved.
//

#import <FMDB/FMDB.h>
#import "FFCaculaterResultHandler.h"
#import "FFCaculateResultHistoryModel.h"

@interface FFCaculaterResultHandler ()

@property (strong, nonatomic) FMDatabaseQueue *dbQueue;

@end

@implementation FFCaculaterResultHandler

+ (instancetype)sharedCaculaterResultHandler {
    
    static id sharedHandler;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedHandler = [self init];
    });
    
    return sharedHandler;
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        [self createResultTableIfNeeded];
    }
    
    return self;
}

- (void)createResultTableIfNeeded {
    NSString *tableCteated = [[NSUserDefaults standardUserDefaults] objectForKey:FFResultTableCreatedKey];
    if (!tableCteated) {
        
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            
            BOOL success = [db executeUpdate:@"CREATE TABLE tb_result_history (result_id INTEGER PRIMARY KEY AUTOINCREMENT, user_id TEXT, alias TEXT, status INTEGER, create_time TEXT, file_path TEXT, detail BLOB)"];
            
            if (!success) {
                NSLog(@"create table tb_result_history fail");
            }
        }];
    }
}

- (void)addResult:(FFCaculateResultHistoryModel *)result
          success:(void(^)())success
          failure:(void(^)(NSError *error))failure {
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        BOOL isSuccess;
        isSuccess = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO tb_result_history VALUES ('%@', '%@', %@, '%@', '%@', %@);",
                                       result.user_id, result.alias, result.status, result.create_time, result.file_path,
                                       [NSKeyedArchiver archivedDataWithRootObject:result.details]]];
        
        if (isSuccess && success) {
            success();
        }
        
        else {
            failure([self buildMyError]);
        }
        
    }];
}

- (void)updateResult:(FFCaculateResultHistoryModel *)result
             success:(void(^)())success
             failure:(void(^)(NSError *error))failure {
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        BOOL isSuccess;
        isSuccess = [db executeUpdate:[NSString stringWithFormat:@"UPDATE tb_result_history SET alias = '%@', status = %@, create_time = '%@', file_path = '%@', detail = %@ WHERE user_id = '%@' AND result_id = %@",
                                       result.alias, result.status, result.create_time, result.file_path,
                                       [NSKeyedArchiver archivedDataWithRootObject:result.details],
                                       result.user_id, result.result_id]];
        
        if (isSuccess && success) {
            success();
        }
        
        else {
            failure([self buildMyError]);
        }

    }];
}

- (void)getResultById:(NSNumber *)resultId
              success:(void(^)(FFCaculateResultHistoryModel *result))success
              failure:(void(^)(NSError *error))failure {
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        BOOL isSuccess;
        FMResultSet *rs;
        FFCaculateResultHistoryModel *result;
        
        isSuccess = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM tb_result_history WHERE result_id = %@", resultId]];
        while (rs.next) {
            
            result = [[FFCaculateResultHistoryModel alloc] init];
            result.user_id = [rs stringForColumn:@"user_id"];
            result.result_id = [NSNumber numberWithLongLong:[rs longLongIntForColumn:@"result_id"]];
            result.alias = [rs stringForColumn:@"alias"];
            result.status = [NSNumber numberWithInt:[rs intForColumn:@"status"]];
            result.create_time = [rs stringForColumn:@"create_time"];
            result.file_path = [rs stringForColumn:@"file_path"];
            result.details = [NSKeyedUnarchiver unarchiveObjectWithData:[rs dataForColumn:@"details"]];
        }
        
        if (isSuccess && success) {
            success(result);
        }
        
        else {
            failure([self buildMyError]);
            
        }
    }];
}

- (void)getResultsByUserId:(NSString *)userId
                   success:(void(^)(NSArray *results))success
                   failure:(void(^)(NSError *error))failure {
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        BOOL isSuccess;
        FMResultSet *rs;
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:5];
        
        isSuccess = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM tb_result_history WHERE user_id = %@", userId]];
        while (rs.next) {
            
            FFCaculateResultHistoryModel *result = [[FFCaculateResultHistoryModel alloc] init];
            result = [[FFCaculateResultHistoryModel alloc] init];
            result.user_id = [rs stringForColumn:@"user_id"];
            result.result_id = [NSNumber numberWithLongLong:[rs longLongIntForColumn:@"result_id"]];
            result.alias = [rs stringForColumn:@"alias"];
            result.status = [NSNumber numberWithInt:[rs intForColumn:@"status"]];
            result.create_time = [rs stringForColumn:@"create_time"];
            result.file_path = [rs stringForColumn:@"file_path"];
            result.details = [NSKeyedUnarchiver unarchiveObjectWithData:[rs dataForColumn:@"details"]];
            
            [results addObject:result];
        }
        
        if (isSuccess && success) {
            success(results);
        }
        
        else {
            failure([self buildMyError]);
            
        }
    }];

}

- (void)deleteResult:(NSNumber *)resultId
              byUser:(NSString *)userId
             success:(void(^)())success
             failure:(void(^)(NSError *error))failure {
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        BOOL isSuccess;
        isSuccess = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM tb_result_history WHERE result_id = %@ AND user_id = '%@'", resultId, userId]];
        
        if (isSuccess && success) {
            success();
        }
        
        else {
            failure([self buildMyError]);
        }
    }];
}
#pragma mark - private methods
- (NSError *)buildMyError {
    
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@"Insert contact error",
                               NSLocalizedFailureReasonErrorKey:@"Insert contact error"};
    
    NSError *error = [NSError errorWithDomain:FFDBErrorDomain code:-1 userInfo:userInfo];
    
    return error;
}

@end
