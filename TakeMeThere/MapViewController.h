//
//  MapViewController.h
//  TakeMeThere
//
//  Created by Nathan Levine on 2/26/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"

@interface MapViewController : UIViewController <MKMapViewDelegate , CLLocationManagerDelegate>
{

    IBOutlet MKMapView *myMapView;
    
}
@property (retain, nonatomic) NSString* latitude;
@property (retain, nonatomic) NSString* longitude;
@property (retain, nonatomic) NSString* picTitle;

@end
