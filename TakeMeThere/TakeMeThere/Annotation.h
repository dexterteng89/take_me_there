//
//  MMAnnotation.h
//  TakeMeThere
//
//  Created by Nathan Levine on 2/27/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@end
