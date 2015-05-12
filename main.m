//
//  main.m
//  directionsETACalc
//
//  Created by Nicholas Rogers on 3/4/15.
//  Copyright (c) 2015 Nicholas Rogers. All rights reserved.
//

/*

 The "parameters.txt" file that this program reads needs the following formatting (saved in /tmp):
    start_lat:[ ]
    start_long:[ ]
 
    end_lat:[ ]
    end_long:[ ]
 
    save_location:[ ]
*/

#import <Foundation/Foundation.h>

#import "directionFetcher.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        /* Use this if compiling the files manually
        NSURL *relURL = [[NSBundle mainBundle]resourceURL];
        NSURL *fileURL = [relURL URLByAppendingPathComponent:@"parameters.txt" isDirectory:NO];
         */
        
        NSString *fileURL = @"/tmp/parameters.txt";
        
        NSError *err;
        
        NSString *paramStr = [[NSString alloc]initWithContentsOfFile:fileURL
                                                            encoding:NSUTF8StringEncoding
                                                               error:&err];
        NSMutableString *startLatStr = [NSMutableString new];
        NSMutableString *startLongStr = [NSMutableString new];
        NSMutableString *endLatStr = [NSMutableString new];
        NSMutableString *endLongStr = [NSMutableString new];
        NSMutableString *saveLocationStr = [NSMutableString new];
        
        NSScanner *scanner = [[NSScanner alloc]initWithString:paramStr];
        [scanner setScanLocation:0];
        
        if (![scanner isAtEnd]) {
            [scanner scanUpToString:@"start_lat:[" intoString:nil];
            [scanner scanString:@"start_lat:[" intoString:nil];
            [scanner scanUpToString:@"]" intoString:&startLatStr];
            
            [scanner scanUpToString:@"start_long:[" intoString:nil];
            [scanner scanString:@"start_long:[" intoString:nil];
            [scanner scanUpToString:@"]" intoString:&startLongStr];
            
            [scanner scanUpToString:@"end_lat:[" intoString:nil];
            [scanner scanString:@"end_lat:[" intoString:nil];
            [scanner scanUpToString:@"]" intoString:&endLatStr];
            
            [scanner scanUpToString:@"end_long:[" intoString:nil];
            [scanner scanString:@"end_long:[" intoString:nil];
            [scanner scanUpToString:@"]" intoString:&endLongStr];
            
            [scanner scanUpToString:@"save_location:[" intoString:nil];
            [scanner scanString:@"save_location:[" intoString:nil];
            [scanner scanUpToString:@"]" intoString:&saveLocationStr];
        }
        
        directionFetcher *ETACalc = [[directionFetcher alloc]init];
        [ETACalc setStartLatitude:[startLatStr floatValue]];
        [ETACalc setStartLongitude:[startLongStr floatValue]];
        [ETACalc setEndLatitude:[endLatStr floatValue]];
        [ETACalc setEndLongitude:[endLongStr floatValue]];
        [ETACalc setSaveLocation:saveLocationStr];
        
        [ETACalc getETA];
        
        __unused NSTimer *updateTimer = [NSTimer scheduledTimerWithTimeInterval:900
                                                                         target:ETACalc
                                                                       selector:@selector(getETA)
                                                                       userInfo:nil
                                                                        repeats:YES];
        /*
        NSDate *endDate = [NSDate dateWithTimeInterval:25200 sinceDate:[NSDate date]];
        [[NSRunLoop currentRunLoop]runUntilDate:endDate];
         */
        
        startLatStr = nil;
        startLongStr = nil;
        endLatStr = nil;
        endLongStr = nil;
        saveLocationStr = nil;
        scanner = nil;
        fileURL = nil;
        paramStr = nil;
        
        [[NSRunLoop currentRunLoop]run];
    }
    return 0;
}