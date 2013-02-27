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

@interface MMViewController : UIViewController <getDataFromFlickrIntoArray>

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) NSMutableArray* allPhotoJSONfileArray;

- (IBAction)searchButton:(id)sender;

@end
