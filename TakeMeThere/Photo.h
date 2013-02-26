//
//  Photo.h
//  TakeMeThere
//
//  Created by Nathan Levine on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject
@property (strong, nonatomic) NSDictionary* myPhoto;

- (NSString *)getPhotoURLBySizeSuffix:(char)sizeSuffix;
- (UIImage *)getPhotoThumbnail;



@end
