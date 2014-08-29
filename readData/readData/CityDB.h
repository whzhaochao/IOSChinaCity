//
//  CityDB.h
//  readData
//
//  Created by 赵超 on 14-8-28.
//  Copyright (c) 2014年 赵超. All rights reserved.
//

#import "BaseDB.h"
#import "CityModel.h"

@interface CityDB : BaseDB
/**
 *CityDB单例
 */
+(id)ShareDB;

/**
 * 创建数据库
 * dbName:数据库名称
 */
-(void)creatTableWithDataBaseName:(NSString*) dbName;

/**
 * 增加一个城市
 * city:城市
 * dbName:数据库名称
 */
-(BOOL)addCity:(CityModel*)city dbName:(NSString*)dbName;
/**
 * 选择所有的城市
 * dbName:数据库名称
 */
-(id)selectAllCity:(NSString*)dbName;
/**
 * 选择所有的省份
 * dbName:数据库名称
 */
-(id)selectAllProvince:(NSString *)dbName;
/**
 * 删除所有城市
 * dbName:数据库名称
 */
-(BOOL)deleteAllCity:(NSString*)dbName;
/**
 * 通过上一级省份选择下级市
 * city:上一级城市
 * dbName:数据库名称
 */
-(id)selectCityByProvince:(CityModel*)provice dbName:(NSString*)dbName;


@end
