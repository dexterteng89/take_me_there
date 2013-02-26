//
//  QueryListTableViewController.m
//  TakeMeThere
//
//  Created by Dexter Teng on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import "QueryListTableViewController.h"

@interface QueryListTableViewController ()

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


#pragma mark - Table view delegate


@end
