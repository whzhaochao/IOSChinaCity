//
//  CityDB.m
//  readData
//
//  Created by 赵超 on 14-8-28.
//  Copyright (c) 2014年 赵超. All rights reserved.
//

#import "CityDB.h"

@implementation CityDB

static CityDB *citydb;

+(id)ShareDB{
    if (citydb==nil) {
        citydb=[[CityDB alloc] init];
    }
    return citydb;
}

-(void)creatTableWithDataBaseName:(NSString *)dbName{
     NSString *sql=@"create table china (ids text primary key,cityName text,pid text )";
    [self createTable:sql dataBaseName:dbName];
}

-(BOOL)addCity:(CityModel *)city dbName:(NSString *)dbName{
    NSString *sql=@"insert into china values (?,?,?)";
    NSArray *params=@[city.ids,city.cityName,city.pid];
    return [self execSql:sql parmas:params dataBaseName:dbName];
}

-(id)selectAllCity:(NSString *)dbName{
    NSString *sql=@"select ids,cityName,pid from china";
    return [self selectCity:sql parmas:nil dbName:dbName];
}

-(id)selectCity:(NSString*)sql parmas:(NSArray*)params dbName:(NSString*)dbName{
    NSArray *result= [self selectSql:sql parmas:params dataBaseName:dbName];
    NSMutableArray *citys=[NSMutableArray array];
    for (NSDictionary *dic in result) {
        CityModel *city=[[CityModel alloc]init];
        city.ids=[dic objectForKey:@"ids"];
        city.cityName=[dic objectForKey:@"cityName"];
        city.pid=[dic objectForKey:@"pid"];
        [citys addObject:city];
    }
    return citys;
}

-(id)selectAllProvince:(NSString *)dbName{
    NSString *sql=@"select ids,cityName,pid from china where pid=?";
    NSArray  *parmas=@[@"0"];
    return [self selectCity:sql parmas:parmas dbName:dbName];
}

-(id)selectCityByProvince:(CityModel *)provice dbName:(NSString *)dbName{
    NSString *sql=@"select * from china where pid=?";
    NSArray  *params=@[provice.ids];
    return [self selectCity:sql parmas:params dbName:dbName];
}

-(BOOL)deleteAllCity:(NSString *)dbName{
    NSString *sql=@"delete from china";
    return [self execSql:sql parmas:nil dataBaseName:dbName];
}

@end
