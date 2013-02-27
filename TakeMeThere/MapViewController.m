//
//  MapViewController.m
//  TakeMeThere
//
//  Created by Nathan Levine on 2/26/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
{
    Annotation *myAnnotation;
}

@end

@implementation MapViewController
@synthesize latitude, longitude, picTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CLLocationCoordinate2D picCoordinate =
    {
        .latitude = [self.latitude floatValue],
        .longitude = [self.longitude floatValue]
    };
    
    MKCoordinateSpan span =
    {
        .latitudeDelta = .002f,
        .longitudeDelta = .002f
    };
    
    MKCoordinateRegion myRegion = {picCoordinate, span};
    
    myAnnotation = [[Annotation alloc] init];
    myAnnotation.title = self.picTitle;
    myAnnotation.subtitle = @":)";
    myAnnotation.coordinate = picCoordinate;
    
    
    [myMapView setRegion:myRegion];
    [myMapView addAnnotation:myAnnotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
