//
//  fileManager.h
//  directionsETACalc
//
//  Created by Nicholas Rogers on 3/4/15.
//  Copyright (c) 2015 Nicholas Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fileManager : NSObject

-(void)updateWithTime:(float)newTime date:(NSString *)newDate withSaveLocation:(NSString *)saveLoc;

@end
