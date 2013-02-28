//
//  MMViewController.h
//  TakeMeThere
//
//  Created by Nathan Levine on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "QueryListTableViewController.h"
#import "MapViewController.h"
// added teh corlocation framework to vc
#import <CoreLocation/CoreLocation.h>

//added the cllocationmanagerdelegate
@interface MMViewController : UIViewController <getDataFromFlickrIntoArray , CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) NSMutableArray* allPhotoJSONfileArray;

- (IBAction)searchButton:(id)sender;

//added the startLocationUpdates method
- (void) startLocationUpdates;
//if we fail to get the location popup alert saying so.
-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
//when we get the new location do this
-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;

@end
