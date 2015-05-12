//
//  directionFetcher.m
//  directionsETACalc
//
//  Created by Nicholas Rogers on 3/4/15.
//  Copyright (c) 2015 Nicholas Rogers. All rights reserved.
//

#import "directionFetcher.h"

@implementation directionFetcher
@synthesize startLatitude, startLongitude, endLatitude, endLongitude;

-(void)getETA {
    
    MKDirectionsRequest *directionRequest = [MKDirectionsRequest new];
    [directionRequest setTransportType:MKDirectionsTransportTypeAutomobile];
    [directionRequest setDepartureDate:[NSDate date]];
    
    MKPlacemark *startMark = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(startLatitude,
                                                                                               startLongitude)
                                                  addressDictionary:nil];
    //Why am I writing this... I mean, seriously
    MKPlacemark *endMark = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(endLatitude,
                                                                                             endLongitude)
                                                addressDictionary:nil];
    
    [directionRequest setSource:[[MKMapItem alloc]initWithPlacemark:startMark]];
    [directionRequest setDestination:[[MKMapItem alloc]initWithPlacemark:endMark]];
    
    MKDirections *directions = [[MKDirections alloc]initWithRequest:directionRequest];
    [directions calculateETAWithCompletionHandler:^(MKETAResponse *response, NSError *error) {
        if (error) {
            NSLog(@"LOL YOU GOT AN ERROR YOU SCRUB: %@", [error localizedDescription]);
            exit(1);
        }
        NSLog(@"ETA: %f", [response expectedTravelTime]/60);
        [self sendUpdatedETA:[response expectedTravelTime]/60 time:[NSDate date]];
    }];
    
    //MKUltra goes here
    
}

-(void)sendUpdatedETA:(float)eta time:(NSDate *)date {
    
    fileManager *updater = [[fileManager alloc]init];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM-dd',' HH:mm"];
    
    [updater updateWithTime:eta date:[dateFormat stringFromDate:date] withSaveLocation:saveLocation];
    
}

@end
