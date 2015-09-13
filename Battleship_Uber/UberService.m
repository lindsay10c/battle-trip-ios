//
//  UberService.m
//  Battleship_Uber
//
//  Created by Lindsay Chen on 9/12/15.
//  Copyright (c) 2015 Lindsay Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UberService.h"

static NSString * const BaseURLString = @"https://api.uber.com/v1/products";

@implementation UberService {
    NSTimer *_updatingTimer;
}

- (void)startUpdating {
    _updatingTimer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                     target:self
                                   selector:@selector(jsonLocation:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)stopUpdating {
    if (_updatingTimer) {
        [_updatingTimer invalidate];
        _updatingTimer = nil;
    }
}

- (IBAction)jsonLocation:(id)sender
{
    NSString *status = [NSString stringWithFormat: @"%@Battleship_Uber.php?format=jason", BaseURLString];
    NSURL *url = [NSURL URLWithString:status];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
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
