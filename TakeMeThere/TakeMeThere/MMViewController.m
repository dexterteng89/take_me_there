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

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

  
- (IBAction)searchButton:(id)sender
{
    allPhotoJSONfileArray = [[NSMutableArray alloc] init];

    flickrAPIString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=bd02a7a94fbe1f4c40a1661af4cb7bbe&tags=%@&format=json&nojsoncallback=1", searchField.text];
    
    NSMutableURLRequest* myURLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:flickrAPIString]];
    
    myURLRequest.HTTPMethod = @"GET";
    
    [NSURLConnection sendAsynchronousRequest:myURLRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^ void (NSURLResponse* myResponse, NSData* myData, NSError* theirError)
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
    }];
}
@end
