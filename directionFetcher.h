//
//  directionFetcher.h
//  directionsETACalc
//
//  Created by Nicholas Rogers on 3/4/15.
//  Copyright (c) 2015 Nicholas Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "fileManager.h"

@interface directionFetcher : NSObject {
    double startLatitude;
    double startLongitude;
    double endLatitude;
    double endLongitude;
    
    NSString *saveLocation;
}

@property double startLatitude;
@property double startLongitude;
@property double endLatitude;
@property double endLongitude;

@property (strong, nonatomic) NSString *saveLocation;

-(void)getETA;

@end
