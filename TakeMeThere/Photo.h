//
//  Photo.h
//  TakeMeThere
//
//  Created by Nathan Levine on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol getDataFromFlickrIntoArray <NSObject>
@required

-(void) takeJSONAndPutIntoArray: (NSURLResponse *)myResponse withData: (NSData *)myData andError: (NSError *)theirError;
-(void) getJSONFromFlickr;

@end

@interface Photo : NSObject
@property (strong, nonatomic) NSDictionary* myPhoto;

- (NSString *)getPhotoURLBySizeSuffix:(char)sizeSuffix;
- (UIImage *)getPhotoThumbnail;
- (NSString *)getPhotoLatitude;
- (NSString *)getPhotoLongitude;
- (NSString *)getTitle;

@end
