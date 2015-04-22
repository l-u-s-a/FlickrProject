//
//  FLCBackgroundView.m
//  FlickrProject
//
//  Created by Luka Usalj on 04/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import "FLCBackgroundView.h"
#import "ImageFilter.h"
#import "FlickrKit.h"
#import "FLCImage.h"

@interface FLCBackgroundView()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *nextPicture;
@property (nonatomic, strong) UIImage *nextBlurredPicture;
@end

@implementation FLCBackgroundView

static bool transitionIsForward = YES;
static int transitionTime = 30;


- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:self.currentPicture];
    }
    return _imageView;
}

@synthesize currentPicture = _currentPicture;
- (UIImage *)currentPicture
{
    if (!_currentPicture) {
        _currentPicture = [UIImage imageNamed:@"background"];
        self.currentBlurredPicture = [UIImage imageNamed:@"backgroundBlurred"];
    }
    return _currentPicture;
}

- (void)setCurrentPicture:(UIImage *)currentPicture
{
    _currentPicture = currentPicture;
}

- (void)setNextPicture:(UIImage *)nextPicture
{
    _nextPicture = nextPicture;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageView = [[UIImageView alloc] initWithImage:self.currentPicture];
        self.currentBlurredPicture = [UIImage imageNamed:@"backgroundBlurred"];
        [self addSubview: self.imageView];
        self.delegate = self;
        self.contentSize = self.imageView.image.size;
        [self zoomToFill];
        self.frame = frame;
    }
    return self;
}

- (void)startTransition
{
    [self startTransitionWithDuration:transitionTime];
}


- (void)startTransitionWithDuration:(NSTimeInterval)interval
{
    if (!self.nextPicture) [self loadNextPicture];
    
    [UIView transitionWithView:self
                      duration:interval
                       options:UIViewAnimationOptionCurveLinear
                    animations:^{
                        self.contentOffset = (transitionIsForward) ? [self endingOffset] : [self beginningOffset];
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [self changePicture];
                        }
                    }];
}

- (void)zoomToFill
{
    self.minimumZoomScale = self.frame.size.height / self.contentSize.height;
    self.maximumZoomScale = self.minimumZoomScale;
    self.zoomScale = self.minimumZoomScale;
}

- (void)changePicture
{
    if (!self.nextPicture || !self.nextBlurredPicture) {
        NSLog(@"ovdje");
        transitionIsForward = (transitionIsForward) ? NO : YES;
        [self startTransition];
        return;
    }
    
    self.currentPicture = self.nextPicture;
    self.nextPicture = nil;
    self.currentBlurredPicture = self.nextBlurredPicture;
    self.nextBlurredPicture = nil;
    
    [UIView transitionWithView:self.imageView
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.imageView.image = self.currentPicture;

                    } completion:^(BOOL finished) {
                        transitionIsForward = (transitionIsForward) ? NO : YES;
                        [self startTransition];
                    }];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


//- (void)updateBackground
//{
//    NSLog(@"uhu");
//    self.contentSize = self.imageView.image.size;
//    
//    switch ([[UIDevice currentDevice] orientation]) {
//        case UIDeviceOrientationPortrait:
//            self.minimumZoomScale = self.bounds.size.height / self.imageView.frame.size.height;
//            self.maximumZoomScale = self.minimumZoomScale;
//            self.zoomScale = self.minimumZoomScale;
//            break;
//            
//        case UIDeviceOrientationLandscapeLeft:
//            
//        case UIDeviceOrientationLandscapeRight:
//            self.minimumZoomScale = self.bounds.size.width / self.imageView.bounds.size.width;
//            self.maximumZoomScale = self.minimumZoomScale;
//            self.zoomScale = self.minimumZoomScale;
//            break;
//            
//        default:
//            break;
//    }
//    
//    self.contentOffset = CGPointZero;
//}

- (CGPoint)beginningOffset
{
    return CGPointMake(self.contentSize.width/10, 0);
}

- (CGPoint)endingOffset
{
    return CGPointMake(0.9*self.contentSize.width - self.frame.size.width, 0);
}

- (void)loadNextPicture
{
    FlickrKit *flickrKit = [FlickrKit sharedFlickrKit];
    FKFlickrInterestingnessGetList *list = [[FKFlickrInterestingnessGetList alloc] init];
    
    [flickrKit call:list completion:^(NSDictionary *response, NSError *error) {
        if (!response) return;
        
        NSArray *photoDictionariesArray = [response valueForKeyPath:@"photos.photo"];
        NSDictionary *randomPhotoDictionary = [photoDictionariesArray objectAtIndex:arc4random() % photoDictionariesArray.count];
        self.nextPicture = [[[[FLCImage alloc] initWithDescriptionDictionary:randomPhotoDictionary] largeSizedImage] exposure:-1];
        self.nextBlurredPicture = [self.nextPicture blur:10];
    }];
}

- (void)stopBackground
{
    [UIView transitionWithView:self
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.layer removeAllAnimations];
                        self.imageView.image = self.currentBlurredPicture;
                        self.contentOffset = CGPointMake([self endingOffset].x/2, [self endingOffset].y/2);
                    } completion:^(BOOL finished) {
                    }];
}

- (void)resumeBackground
{
    [UIView transitionWithView:self
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.imageView.image = self.currentPicture;
                    } completion:^(BOOL finished) {}];
    
    
    [self startTransitionWithDuration:transitionTime/2];
    
}

@end
