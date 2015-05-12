//
//  fileManager.m
//  directionsETACalc
//
//  Created by Nicholas Rogers on 3/4/15.
//  Copyright (c) 2015 Nicholas Rogers. All rights reserved.
//

#import "fileManager.h"

@implementation fileManager

-(void)updateWithTime:(float)newTime date:(NSString *)newDate withSaveLocation:(NSString *)saveLoc {
    
    NSError *err;
    
    NSMutableString *currentStr = [[NSMutableString alloc]initWithContentsOfFile:saveLoc
                                                          encoding:NSUTF8StringEncoding
                                                             error:&err];
    NSString *newStr = [NSString stringWithFormat:@"%@, %f\n", newDate, newTime];
    
    [currentStr appendString:newStr];
    [currentStr writeToFile:saveLoc
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:&err];
}

@end
