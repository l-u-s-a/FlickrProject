//
//  FLCBackgroundView.m
//  FlickrProject
//
//  Created by Luka Usalj on 04/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import "FLCBackgroundView.h"

@interface FLCBackgroundView()
@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation FLCBackgroundView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
        [self addSubview:self.imageView];
        self.contentSize = self.imageView.bounds.size;
    }
    return self;
}
@end
