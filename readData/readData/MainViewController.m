//
//  MainViewController.m
//  readData
//
//  Created by 赵超 on 14-8-28.
//  Copyright (c) 2014年 赵超. All rights reserved.
//

#import "MainViewController.h"
#import "CityDB.h"
#define dataBaseName @"China.sqlite"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor grayColor];
    
    UIPickerView *pickView=[[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 0, 0)];
    pickView.dataSource=self;
    pickView.delegate=self;
    pickView.showsSelectionIndicator=YES;
    pickView.backgroundColor=[UIColor whiteColor];

    
    [self.view addSubview:pickView];
    //加载所有省
    self.privices=[[CityDB ShareDB] selectAllProvince:dataBaseName];
    CityModel *city=[self.privices objectAtIndex:0];
    self.citys=[[CityDB ShareDB] selectCityByProvince:city dbName:dataBaseName];
    city=[self.citys objectAtIndex:0];
    self.subCitys=[[CityDB ShareDB] selectCityByProvince:city dbName:dataBaseName];
    city=[self.citys objectAtIndex:0];
    self.area=[[CityDB ShareDB] selectCityByProvince:city dbName:dataBaseName];
    
     selectCity=[[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 30)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component==0) {
        return self.privices.count;
    }else
    if (component==1) {
        NSInteger privoceIndex=[pickerView selectedRowInComponent:0];
        
        CityModel *privoice=[self.privices objectAtIndex:privoceIndex];
        self.citys=[[CityDB ShareDB] selectCityByProvince:privoice dbName:dataBaseName];
        return self.citys.count;
 
    }else
    if (component==2) {
        NSInteger cityIndex=[pickerView selectedRowInComponent:1];
        if (self.citys.count==0) {
            return 0;
        }
        CityModel *subCitys=[self.citys objectAtIndex:cityIndex];
        self.subCitys=[[CityDB ShareDB] selectCityByProvince:subCitys dbName:dataBaseName];
        return self.subCitys.count;
        
    }else
    if (component==3) {
        NSInteger subCityIndex=[pickerView selectedRowInComponent:2];
        if (self.subCitys.count==0) {
            return 0;
        }
        CityModel *ares=[self.subCitys objectAtIndex:subCityIndex];
        self.area=[[CityDB ShareDB] selectCityByProvince:ares dbName:dataBaseName];
        return self.area.count;
    
    }else{
        return 0;
    }
    
}

-(NSString*)getCityName:(NSInteger)row componet:(NSInteger) component{
    if (component==0) {
        CityModel *city=[self.privices objectAtIndex:row];
        return city.cityName;
    }else if (component==1) {
        CityModel *city=[self.citys objectAtIndex:row];
        return city.cityName;
    }else if (component==2) {
        if (self.subCitys==nil) {
            return @"";
        }else{
            CityModel *city=[self.subCitys objectAtIndex:row];
            return city.cityName;
        }
    }
    else if (component==3) {
        if (self.area==nil) {
            return @"";
        }else{
            CityModel *city=[self.area objectAtIndex:row];
            return city.cityName;
        }
        
    }
    
    return @"";
}

-(UIView*) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    lable.text=[self getCityName:row componet:component];
    lable.font=[UIFont systemFontOfSize:14];
    
    return lable;
}

-(NSString*)getSelectCity{
    NSMutableString *city=[[NSMutableString alloc]init];
  
    privceModel?[city appendFormat:@" %@ ",privceModel.cityName]:"";
    cityModel?[city appendFormat:@" %@ ",cityModel.cityName]:"";
    subCityModel?[city appendFormat:@" %@ ",subCityModel.cityName]:"";
    areaModel?[city appendFormat:@" %@ ",areaModel.cityName]:"";
    
    
    return  city;
}


-(void) showSelectResult:(NSInteger)row component:(NSInteger)component{
    
    switch (component) {
        case 0:
             privceModel= [self.privices objectAtIndex:row];
            break;
        case 1:
             cityModel= [self.citys objectAtIndex:row];
            break;
        case 2:
            subCityModel= [self.subCitys objectAtIndex:row];
            break;
        case 3:
            areaModel= [self.area objectAtIndex:row];
            break;
        default:
            break;
    }

    selectCity.text=[self getSelectCity];
    
    [self.view addSubview:selectCity];

}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView reloadComponent:3];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        cityModel=nil;
        subCityModel=nil;
        areaModel=nil;
    }else if (component==1) {
        if (privceModel==nil) {
            privceModel=[self.privices objectAtIndex:0];
        }
        [pickerView reloadComponent:2];
        [pickerView reloadComponent:3];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        subCityModel=nil;
        areaModel=nil;
    }else if (component==2) {
        if (cityModel==nil) {
            cityModel=[self.citys objectAtIndex:0];
        }
        [pickerView reloadComponent:3];
        [pickerView selectRow:0 inComponent:3 animated:YES];
        areaModel=nil;
    }else if (component==3){
        if (cityModel==nil) {
            cityModel=[self.citys objectAtIndex:0];
        }
        if (subCityModel==nil) {
            subCityModel=[self.subCitys objectAtIndex:0];
        }
    }
    [self showSelectResult:row component:component];
    
}

@end
