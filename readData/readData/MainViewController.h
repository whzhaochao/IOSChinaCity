//
//  MainViewController.h
//  readData
//
//  Created by 赵超 on 14-8-28.
//  Copyright (c) 2014年 赵超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

@interface MainViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    CityModel *privceModel;
    CityModel *cityModel;
    CityModel *subCityModel;
    CityModel *areaModel;
    UILabel *selectCity;
}


@property (nonatomic,retain) NSArray *privices;

@property (nonatomic,retain) NSArray *citys;

@property (nonatomic,retain) NSArray *subCitys;

@property (nonatomic,retain) NSArray *area;




@end
