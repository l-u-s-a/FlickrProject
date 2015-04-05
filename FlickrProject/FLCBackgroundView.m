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
        [self addSubview: self.imageView];
        self.delegate = self;
        self.contentSize = self.imageView.bounds.size;
        self.minimumZoomScale = self.frame.size.height / self.imageView.image.size.height;
        self.maximumZoomScale = 2;
//        self.zoomScale = 0.6;
//        self.minimumZoomScale = self.bounds.size.height / self.imageView.bounds.size.height;
//        self.maximumZoomScale = self.bounds.size.height / self.imageView.bounds.size.height;;
        self.zoomScale = self.minimumZoomScale;
//        self.contentOffset = CGPointMake(self.bounds.size.height/2, 0);
    }
    return self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
