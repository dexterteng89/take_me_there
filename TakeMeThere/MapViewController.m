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
    Annotation *pictureAnnotation;
    Annotation *userAnnotation;

}

@end

@implementation MapViewController
@synthesize pictureLocation, picTitle, userLocation;

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
        .latitude = pictureLocation.coordinate.latitude,
        .longitude = pictureLocation.coordinate.longitude
    };
    
    MKCoordinateSpan span =
    {
        .latitudeDelta = 0.00810686f,
        .longitudeDelta = 0.00810686f
    };
    
    MKCoordinateRegion myRegion = {userLocation.coordinate, span};
    
    pictureAnnotation = [[Annotation alloc] init];
    pictureAnnotation.title = self.picTitle;
    pictureAnnotation.subtitle = @":)";
    pictureAnnotation.coordinate = picCoordinate;
    
    // add circle using our location as its center and half a kilometer as the radius
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:userLocation.coordinate radius:500];
    //add circle to map
    [myMapView addOverlay:circle];
    //this calls the mapview overlay method below
    
    
    [self setsUserLocation];
    
    [myMapView setRegion:myRegion];
    [myMapView addAnnotation:pictureAnnotation];
}

- (void)setsUserLocation
{
    userAnnotation = [[Annotation alloc] init];
    userAnnotation.coordinate = userLocation.coordinate;
    userAnnotation.title = @"My current Location";
    
    [myMapView addAnnotation:userAnnotation] ;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView
            viewForOverlay:(id<MKOverlay>)overlay
{
    //add the circleview
    MKCircleView *view = [[MKCircleView alloc] initWithCircle:overlay];
    view.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:.3];
    view.strokeColor = [[UIColor cyanColor] colorWithAlphaComponent:.9];
    view.lineWidth = 1;
    return view;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *myPinView =(MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"ATagPin"];
    
    if (myPinView == nil)
    {
        myPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ATagPin"];
    }
    
    if ([annotation.title isEqual: @"My current Location"]) {
        myPinView.pinColor = MKPinAnnotationColorPurple;
        myPinView.canShowCallout = YES;
        //annotationView.image = [UIImage imageNamed:@"images.png"];
        return myPinView;
    } else {
        myPinView.pinColor = MKPinAnnotationColorGreen;
        myPinView.canShowCallout = YES;
        //annotationView.image = [UIImage imageNamed:@"images.png"];
        return myPinView;
    }

    
}

-(void) showDetail
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
