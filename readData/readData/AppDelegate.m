//
//  AppDelegate.m
//  readData
//
//  Created by 赵超 on 14-8-28.
//  Copyright (c) 2014年 赵超. All rights reserved.
//

#import "AppDelegate.h"
#import "CityModel.h"
#import "CityDB.h"
#import "MainViewController.h"

#define dataBaseName @"China.sqlite"

@implementation AppDelegate


-(void)addCity:(CityModel* )city{
    [[CityDB ShareDB] addCity:city dbName:@"China.sqlite"];
}

-(void)readData{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"china" ofType:@"txt"];
    NSLog(@"%@",path);
    char  pid[30],name[30],ids[30];
    
    FILE *f=fopen([path UTF8String], "r");
    int i=0;
    while (!feof(f)) {
        CityModel *city=[[CityModel alloc] init];
        fscanf(f, " %s %s %s ",ids,name,pid);
        NSString *pids=[NSString stringWithUTF8String:pid];
        NSString *names=[NSString stringWithUTF8String:name];
        NSString *idss=[NSString stringWithUTF8String:ids];
        city.ids=idss;
        city.pid=pids;
        city.cityName=names;
        [self addCity:city];
        NSLog(@"%@ %@ %@ %d",pids,names,idss,++i);
        
    }
}

-(void)testselectAllPrice{
    id result=[[CityDB ShareDB] selectAllProvince:dataBaseName];
    int i=0;
    for (CityModel *city in result) {
        NSLog(@"%@ %@ %@ %d ",city.pid,city.cityName,city.ids,++i);
    }
}
-(void)testselctCity{
    CityModel *city=[[CityModel alloc]init];
    city.ids=@"330101";
    id result=[[CityDB ShareDB] selectCityByProvince:city dbName:dataBaseName];
    int i=0;
    for (CityModel *city in result) {
        NSLog(@"%@ %@ %@ %d ",city.pid,city.cityName,city.ids,++i);
    }
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
  //   [[CityDB ShareDB] deleteAllCity:dataBaseName];
  //   [[CityDB ShareDB] creatTableWithDataBaseName:@"China.sqlite"];
  //   [self readData];
  //    [self testselectAllPrice];
  //   [self testselctCity];
    
    MainViewController *main=[[MainViewController alloc] init];
    self.window.rootViewController=main;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
