//
//  CityModel.h
//  readData
//
//  Created by 赵超 on 14-8-28.
//  Copyright (c) 2014年 赵超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

@property (nonatomic,copy) NSString  *pid;      //父级城市ID
@property (nonatomic,copy) NSString  *cityName; //城市名
@property (nonatomic,copy) NSString  *ids;      //城市ID

@end
