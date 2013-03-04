//
//  MMViewController.m
//  TakeMeThere
//
//  Created by Nathan Levine on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import "MMViewController.h"
#import "QueryListTableViewController.h"
#import "MapViewController.h"
#import "MMYelpKitFramework.h"

@interface MMViewController ()
//added an instance variable of cllocation

{
    NSString* flickrAPIString;
    CLLocationManager *mrLocationManager;
    CLLocation *currentLocation;
    NSDictionary* myYelpVenues;
}

@end

@implementation MMViewController
@synthesize searchField, allPhotoJSONfileArray;

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    QueryListTableViewController* queryListTableVC = [segue destinationViewController];
    queryListTableVC.delegate = self;
    [queryListTableVC setAllPhotoJSONfileArray:self.allPhotoJSONfileArray];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startLocationUpdates];
}

// Delegate protocol for CurrentLocationDelegate
- (CLLocation *)getLocation
{
    return currentLocation;
}

//added the startLocationUpdates method
- (void) startLocationUpdates
{
    //if we dont have an instantiated clloactionmanager object make one
    if (mrLocationManager == nil)
    {
        mrLocationManager = [[CLLocationManager alloc] init];
    }
    mrLocationManager.delegate = self;
    
    //get location that is decently close
    mrLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    //update location
    [mrLocationManager startUpdatingLocation];
}

//if we fail to get the location popup alert saying so.
-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error"
                                     message:@"Failed to Get Your Location"
                                    delegate:nil
                           cancelButtonTitle:@"OK"
                           otherButtonTitles:nil];
    [errorAlert show];
}

//when we get the new location do this
-(void) locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    currentLocation = newLocation;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)searchButton:(id)sender
{
    [self getJSONFromFlickr];
    [self getJSONfromYelp];
}

-(void) getJSONfromYelp
{
    NSString *myYelpURLString = [NSString stringWithFormat:@"http://api.yelp.com/business_review_search?lat=%f&long=%f&radius=10&category=%@&limit=20&ywsid=SHvJpobPrBabhrCyJ8FMag",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, searchField.text];
    
    YKURL *myYelpURL = [YKURL URLString:myYelpURLString];
    
    [YKJSONRequest requestWithURL:myYelpURL
                      finishBlock:^ void (id myData)
                                     {
                                         [self setUpYelpVenuesWithData:myData];
                                     }
                        failBlock:^ void (YKHTTPError *error)
                                     {
                                         if (error) {
                                             NSLog(@"%@", [error description]);
                                         }
                                     }
                                     ];
}

-(void) setUpYelpVenuesWithData: (id)data
{
    myYelpVenues = (NSDictionary *)data;
    NSArray* myYelpBusinesses = [myYelpVenues valueForKey:@"businesses"];
    
}

-(void) getJSONFromFlickr   
{
    allPhotoJSONfileArray = [[NSMutableArray alloc] init];
    
    flickrAPIString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=bd02a7a94fbe1f4c40a1661af4cb7bbe&tags=%@&format=json&nojsoncallback=1&lat=%f&lon=%f&radius=0.5&extras=geo", searchField.text, currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    
    NSMutableURLRequest* myURLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:flickrAPIString]];
    
    myURLRequest.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:myURLRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^ void (NSURLResponse* myResponse, NSData* myData, NSError* theirError)
     {
         [self takeJSONAndPutIntoArray:myResponse withData:myData andError:theirError];
     }];
}

-(void) takeJSONAndPutIntoArray: (NSURLResponse *)myResponse withData: (NSData *)myData andError: (NSError *)theirError
{
    if (theirError)
    {
        NSLog(@"%@", [theirError description]);
    } else
    {
        NSError* jsonError;
        NSDictionary *myJSONDictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingAllowFragments error:&jsonError];
        
        NSArray *arrayOfDictionaryPhotos = [[myJSONDictionary valueForKey:@"photos"] valueForKey:@"photo"];
        
        for (int i=0; i < [arrayOfDictionaryPhotos count]; i++)
        {
            Photo *randomPhoto = [[Photo alloc] initWithDictionary:[arrayOfDictionaryPhotos objectAtIndex:i]];
            [self.allPhotoJSONfileArray addObject:randomPhoto];
        }
        [self performSegueWithIdentifier:@"queryToTable" sender:self];
    }
}

@end
