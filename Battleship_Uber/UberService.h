//
//  UberService.h
//  Battleship_Uber
//
//  Created by Lindsay Chen on 9/12/15.
//  Copyright (c) 2015 Lindsay Chen. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>


@interface UberService : NSObject

- (void)startUpdating;
- (void)stopUpdating;
- (void)jsonSpoofDetails;

@property (nonatomic) CLLocation *location;


@end