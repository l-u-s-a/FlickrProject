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

static bool transitionIsForward = YES;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
        [self addSubview: self.imageView];
        self.delegate = self;
        self.contentSize = self.imageView.image.size;
    }
    
    return self;

}



- (void)startTransition
{
    [UIView transitionWithView:self.imageView
                      duration:40
                       options:UIViewAnimationOptionCurveLinear
                    animations:^{
                        self.contentOffset = CGPointMake(self.contentOffset.x - (self.zoomScale * self.contentSize.width)/20, self.contentOffset.y);
                    } completion:^(BOOL finished) {
                        if (!finished) {
                            NSLog(@"prekinut");
                        }
                    }];
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
    
    self.contentOffset = CGPointMake([self beginningOffsetX], 0);
}

- (float)beginningOffsetX
{
    return self.zoomScale * self.imageView.frame.size.width/6;
}

- (float)endingOffsetX
{
    return self.contentSize.width - self.zoomScale * self.imageView.bounds.size.width/6 - self.bounds.size.width;
}

@end
