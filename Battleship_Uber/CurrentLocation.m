//
//  SecondViewController.m
//  Battleship_Uber
//
//  Created by Lindsay Chen on 9/12/15.
//  Copyright (c) 2015 Lindsay Chen. All rights reserved.
//

#import "CurrentLocation.h"

@interface CurrentLocation ()

@end

@implementation CurrentLocation


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Something is happening! %f", [[[UIDevice currentDevice] systemVersion] floatValue]);
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];

    [locationManager startUpdatingLocation];
    
 
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [locations lastObject];
    NSLog(@"Location is %@", [locations lastObject]);
    
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    CLLocation *coord = (CLLocation *)([locations lastObject]);
//    point.coordinate = coord.coordinate;
//    [point setTitle:@"myLocation"];
//    [point setSubtitle: @"myLoc"];
//    
//    [mapView addAnnotation:point];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
