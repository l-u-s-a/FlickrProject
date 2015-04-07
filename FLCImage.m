//
//  FLCImage.m
//  FlickrProject
//
//  Created by Luka Usalj on 07/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import "FLCImage.h"
#import "FlickrKit.h"

@interface FLCImage()
@property (strong, nonatomic) NSDictionary *descriptionDictionary;
-(UIImage *)imageWithSize:(FKPhotoSize)photoSize;
-(void)initializeAttributes;
@end

@implementation FLCImage

-(instancetype)initWithDescriptionDictionary:(NSDictionary *)descriptionDictionary
{
    self = [super init];
    if (self) {
        self.descriptionDictionary = descriptionDictionary;
        [self initializeAttributes];
    }
    return self;
}

-(UIImage *)smallSizedImage
{
    return [self imageWithSize:FKPhotoSizeSmall320];
}

-(UIImage *)mediumSizedImage
{
    return [self imageWithSize:FKPhotoSizeMedium640];
}

-(UIImage *)largeSizedImage
{
    return [self imageWithSize:FKPhotoSizeLarge1024];
}

-(UIImage *)imageWithSize:(FKPhotoSize)photoSize
{
    NSURL *imageURL = [[FlickrKit sharedFlickrKit] photoURLForSize:photoSize fromPhotoDictionary:self.descriptionDictionary];
    
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
}

-(void)initializeAttributes
{
    self.title = [self.descriptionDictionary valueForKey:@"title"];
}

@end
