//
//  FLCImage.h
//  FlickrProject
//
//  Created by Luka Usalj on 07/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FLCImage : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *smallSquareSizedImage;
@property (strong, nonatomic) UIImage *smallSizedImage;
@property (strong, nonatomic) UIImage *mediumSizedImage;
@property (strong, nonatomic) UIImage *largeSizedImage;

-(instancetype)initWithDescriptionDictionary:(NSDictionary *)descriptionDictionary;
@end
