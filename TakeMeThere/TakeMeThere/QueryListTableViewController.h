//
//  QueryListTableViewController.h
//  TakeMeThere
//
//  Created by Dexter Teng on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentLocationDelegate.h"

@interface QueryListTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *queryListTableView;
@property (strong, nonatomic) NSMutableArray* allPhotoJSONfileArray;
@property (retain, nonatomic) id <CurrentLocationDelegate> delegate;

@end
