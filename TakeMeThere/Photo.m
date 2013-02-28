//
//  Photo.m
//  TakeMeThere
//
//  Created by Nathan Levine on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import "Photo.h"

@implementation Photo
@synthesize myPhoto, title, pictureLocation;

- (NSString *)getPhotoURLBySizeSuffix:(char)sizeSuffix
{
    NSString* myURL = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_%c.jpg", [self.myPhoto valueForKey:@"farm"], [self.myPhoto valueForKey:@"server"], [self.myPhoto valueForKey:@"id"], [self.myPhoto valueForKey:@"secret"], sizeSuffix];
    return myURL;
}

- (UIImage *)getPhotoThumbnail
{
    UIImage *myImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self getPhotoURLBySizeSuffix:'m']]]];
    return myImage;
}

- (id) initWithDictionary:(NSDictionary *)photoDictionary
{
    self = [super init];
    
    //Gets Current Location latitude
    NSString* latitudeString = [photoDictionary valueForKey:@"latitude"];
    float latitudeFloat = [latitudeString floatValue];
    CLLocationDegrees latitudeDegrees = latitudeFloat;
    
    //Gets Current Location longitude
    NSString* longitudeString = [photoDictionary valueForKey:@"longitude"];
    float longitudeFloat = [longitudeString floatValue];
    CLLocationDegrees longitudeDegrees = longitudeFloat;
    
    //Assigns current location longitude and latitude to a new CLLocation called newLocation
    CLLocation* newLocation = [[CLLocation alloc] initWithLatitude:latitudeDegrees longitude:longitudeDegrees];
    
    //assigns newLocation to property pictureLocation
    pictureLocation = newLocation;
        
    self.myPhoto = photoDictionary;
    
    self.title = [photoDictionary valueForKey:@"title"];
    return self;
}

@end
