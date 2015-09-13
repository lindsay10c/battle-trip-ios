//
//  UberService.m
//  Battleship_Uber
//
//  Created by Lindsay Chen on 9/12/15.
//  Copyright (c) 2015 Lindsay Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UberService.h"

static NSString * const BaseURLString = @"https://api.uber.com/v1/requests/";
static NSString * const BaseSpoofServer = @"https://battletrip.herokuapp.com/uber-details";

@implementation UberService {
    NSTimer *_updatingTimer;
}

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

- (void)jsonSpoofDetails {
    NSLog(@"tick");
    //NSString *status = [NSString stringWithFormat: @"%@requestIDhere", BaseURLString];
    NSURL *url = [NSURL URLWithString:BaseSpoofServer];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", json);
        NSString *status = [json objectForKey:@"status"];
        NSLog(@"%@", status);
        if([status  isEqual: @"completed"]){
            NSLog(@"let's ride");
            
        }
        
        
    }];
    [dataTask resume];
    
}

- (IBAction)jsonUberDetails:(id)sender
{
    // NSLog(@"tick");
    NSString *status = [NSString stringWithFormat: @"%@requestIDhere", BaseURLString];
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
