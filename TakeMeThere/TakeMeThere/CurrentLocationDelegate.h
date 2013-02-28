//
//  CurrentLocationDelegate.h
//  TakeMeThere
//
//  Created by Nathan Levine on 2/28/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol CurrentLocationDelegate <NSObject>

- (CLLocation *)getLocation;

@end
