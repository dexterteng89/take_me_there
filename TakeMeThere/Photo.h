//
//  Photo.h
//  TakeMeThere
//
//  Created by Nathan Levine on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Photo : NSObject
@property (strong, nonatomic) NSDictionary* myPhoto;

@property (retain, nonatomic) CLLocation* pictureLocation;

@property (strong, nonatomic) NSString* title;

- (NSString *)getPhotoURLBySizeSuffix:(char)sizeSuffix;
- (UIImage *)getPhotoThumbnail;
- (id) initWithDictionary:(NSDictionary *)photoDictionary;
@end
