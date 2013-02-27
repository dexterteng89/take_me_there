//
//  QueryListTableViewController.m
//  TakeMeThere
//
//  Created by Dexter Teng on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import "QueryListTableViewController.h"
#import "MapViewController.h"

@interface QueryListTableViewController ()
{
    MapViewController *mvc;
    NSString *latitudeString;
    NSString *longitudeString;
    NSString *picTitle;
}
@end

@implementation QueryListTableViewController
@synthesize queryListTableView, allPhotoJSONfileArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    mvc = [segue destinationViewController];
    
    [mvc setLatitude:latitudeString];
    [mvc setLongitude:longitudeString];
    [mvc setPicTitle:picTitle];
}

- (void)viewDidLoad
{

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (allPhotoJSONfileArray == nil)
    {
        return 0;
    }
    else
    {
        return [allPhotoJSONfileArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QueryCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"QueryCell"];
    }
        
    UIImageView *myPicture = (UIImageView *) [cell viewWithTag:100];
    myPicture.image = [[self.allPhotoJSONfileArray objectAtIndex:[indexPath row]] getPhotoThumbnail];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    mvc = [[MapViewController alloc] init];
    latitudeString = [[allPhotoJSONfileArray objectAtIndex:[indexPath row]] getPhotoLatitude];
    longitudeString = [[allPhotoJSONfileArray objectAtIndex:[indexPath row]] getPhotoLongitude];
    picTitle = [[allPhotoJSONfileArray objectAtIndex:[indexPath row]] getTitle];
    [self performSegueWithIdentifier:@"tableToMap" sender:self];
}


#pragma mark - Table view delegate


@end
