//
//  MMViewController.m
//  TakeMeThere
//
//  Created by Nathan Levine on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import "MMViewController.h"
#import "Photo.h"
#import "QueryListTableViewController.h"

@interface MMViewController ()
{
    NSString* flickrAPIString;
    NSArray* allPhotoJSONfileArray;
}
@end

@implementation MMViewController
@synthesize searchField;

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QueryListTableViewController* qltvc = [segue destinationViewController];
    
    [qltvc setAllPhotoJSONfileArray:allPhotoJSONfileArray];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (IBAction)searchButton:(id)sender
{
    flickrAPIString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=bd02a7a94fbe1f4c40a1661af4cb7bbe&tags=%@&format=json&nojsoncallback=1", searchField.text];
    
    NSMutableURLRequest* myURLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:flickrAPIString]];
    
    myURLRequest.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:myURLRequest queue:[NSOperationQueue mainQueue] completionHandler:^ void (NSURLResponse* myResponse, NSData* myData, NSError* theirError)
    {
        if (theirError)
        {
            
        } else
        {
            NSError* jsonError;
            NSDictionary *myJSONDictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingAllowFragments error:&jsonError];
            
            //entireJSONfile is an Array of "photo"s 
            allPhotoJSONfileArray = [[myJSONDictionary valueForKey:@"photos"] valueForKey:@"photo"];
        }
    }];
}
@end
