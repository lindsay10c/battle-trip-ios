//
//  UberService.m
//  Battleship_Uber
//
//  Created by Lindsay Chen on 9/12/15.
//  Copyright (c) 2015 Lindsay Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UberService.h"

static NSString * const BaseURLString = @"https://api.uber.com/v1/";
static NSString * const BaseSpoofServer = @"https://battletrip.herokuapp.com/uber-details";
static NSString * const FinalDestinationEndpoint = @"https://battletrip.herokuapp.com/destination";

@implementation UberService {
    NSTimer *_updatingTimer;
}

// start timer
- (void)startUpdating {
    _updatingTimer = [NSTimer scheduledTimerWithTimeInterval:4.0
                                     target:self
                                   selector:@selector(jsonSpoofDetails)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)stopUpdating {
    if (_updatingTimer) {
        [_updatingTimer invalidate];
        _updatingTimer = nil;
    }
}

// get spoof data from our node server
- (void)jsonSpoofDetails {
    NSLog(@"tick");
    //NSString *status = [NSString stringWithFormat: @"%@requestIDhere", BaseURLString];
    NSURL *url = [NSURL URLWithString:BaseSpoofServer];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // convert json to dictionary
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", json);
        NSString *status = [json objectForKey:@"status"];
        NSDictionary *location = [json objectForKey:@"location"];
        NSLog(@"%@", status);
        // check if trip is completed
        if([status  isEqual: @"completed"]){
            NSLog(@"let's ride");
            [self sendFinalDestinationWithLat:[location objectForKey:@"latitude"] withLon:[location objectForKey:@"longitude"]];
        }
        
    }];
    [dataTask resume];
    
}

// send post request to our node server to check geo fencing on ship radius'
- (void) sendFinalDestinationWithLat:(NSString *)lat withLon:(NSString *)lon {
    NSError *error;
    NSString *dataString = [NSString stringWithFormat:@"lat=%@&lon=%@", lat, lon];
    
    NSURL *url = [NSURL URLWithString:FinalDestinationEndpoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: lat, @"lat", lon, @"lon",
                             nil];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];

    NSURLSessionDataTask *postDataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSLog(@"%@", response);
        NSLog(@"%@", error);
        if([httpResponse statusCode] == 200){
            NSLog(@"success!");
        }
        // The server answers with an error because it doesn't receive the params
    }];
    [postDataTask resume];
}


// get data from uber
- (void)jsonUberDetails
{
    // NSLog(@"tick");
    // for the stringWithFormat put the {requestId} which we may need to get from the history endpoint?
    // not sure how often the history endpoint updates
    NSString *status = [NSString stringWithFormat: @"%@/requests/requestIDhere", BaseURLString];
    NSURL *url = [NSURL URLWithString:status];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"completed dataTask?");
    }];
    [dataTask resume];
    
//    AFHTTPRequestOperation *checkStatus = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *checkStatus, id carLocation) {
//        self.Battleship_Uber = (NSDictionary *)carLocation;
//        self.title = @"JSON Retrieved";
//        [self.tableView reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *checkStatus, NSError *error) {
//    
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Customer Status"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }];
//    [operation start];
}

//[NSTimer scheduledTimerWithTimeInterval:5.0
//                                 target:self
//                               selector:@selector(targetMethod:)
//                               userInfo:nil
//                                repeats:YES];

/*AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
[manager GET:@"http://example.com/resources.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"JSON: %@", responseObject);
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
}];
*/

@end
