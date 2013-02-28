//
//  MMViewController.m
//  TakeMeThere
//
//  Created by Nathan Levine on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import "MMViewController.h"



@interface MMViewController ()
//added an instance variable of cllocation

{
    NSString* flickrAPIString;
    CLLocationManager *mrLocationManager;
   
    //add some variables
    NSString *longString;
    NSString *latString;
    CLLocation *currentLocation;
}

@end

@implementation MMViewController
@synthesize searchField, allPhotoJSONfileArray;

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    QueryListTableViewController* qltvc = [segue destinationViewController];
    
    [qltvc setAllPhotoJSONfileArray:self.allPhotoJSONfileArray];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startLocationUpdates];

	// Do any additional setup after loading the view, typically from a nib.
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
-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    currentLocation = newLocation;
    
    if (currentLocation != nil) {
        longString = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        latString = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
    [mrLocationManager stopUpdatingLocation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void) getJSONFromFlickr
{
    allPhotoJSONfileArray = [[NSMutableArray alloc] init];
    
    flickrAPIString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=bd02a7a94fbe1f4c40a1661af4cb7bbe&tags=%@&format=json&nojsoncallback=1&lat=%@&lon=%@&radius=0.5&extras=geo", searchField.text, latString, longString];
    
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
        NSLog(@"hello");
    } else
    {
        NSError* jsonError;
        NSDictionary *myJSONDictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingAllowFragments error:&jsonError];
        
        //entireJSONfile is an Array of "photo"s
        NSArray *arrayOfDictionaryPhotos = [[myJSONDictionary valueForKey:@"photos"] valueForKey:@"photo"];
        
        for (int i=0; i < [arrayOfDictionaryPhotos count]; i++)
        {
            Photo *randomPhoto = [[Photo alloc] init];
            randomPhoto.myPhoto = [arrayOfDictionaryPhotos objectAtIndex:i];
            [self.allPhotoJSONfileArray addObject:randomPhoto];
            
        }
        [self performSegueWithIdentifier:@"queryToTable" sender:self];
    }
}
- (IBAction)searchButton:(id)sender
{
    [self getJSONFromFlickr];
}
@end
