//
//  Photo.m
//  TakeMeThere
//
//  Created by Nathan Levine on 2/25/13.
//  Copyright (c) 2013 Nathan Levine. All rights reserved.
//

#import "Photo.h"

@implementation Photo
@synthesize myPhoto;

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

@end
