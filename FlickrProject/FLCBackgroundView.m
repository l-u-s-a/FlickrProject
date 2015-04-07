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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
        [self addSubview: self.imageView];
        self.delegate = self;
        self.contentSize = self.imageView.frame.size;
    }
    
    return self;

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)updateBackground
{
    switch ([[UIDevice currentDevice] orientation]) {
        case UIDeviceOrientationPortrait:
            self.minimumZoomScale = self.bounds.size.height / self.imageView.bounds.size.height;
            self.maximumZoomScale = self.minimumZoomScale;
            self.zoomScale = self.minimumZoomScale;
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            
        case UIDeviceOrientationLandscapeRight:
            self.minimumZoomScale = self.bounds.size.width / self.imageView.bounds.size.width;
            self.maximumZoomScale = self.minimumZoomScale;
            self.zoomScale = self.minimumZoomScale;
            break;
            
        default:
            break;
    }
}

@end
