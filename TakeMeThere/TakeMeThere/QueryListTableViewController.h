//
//  QueryListTableViewController.h
//  TakeMeThere
//
//  Created by Dexter Teng on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryListTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *queryListTableView;
@property (strong, nonatomic) NSArray* allPhotoJSONfileArray;
@end
