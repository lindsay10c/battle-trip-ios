//
//  SecondViewController.h
//  Battleship_Uber
//
//  Created by Lindsay Chen on 9/12/15.
//  Copyright (c) 2015 Lindsay Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CurrentLocation : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    IBOutlet MKMapView *mapView;

}
@end

