//
//  FLCBackgroundView.h
//  FlickrProject
//
//  Created by Luka Usalj on 04/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLCBackgroundView : UIScrollView <UIScrollViewDelegate>
- (void)updateBackground;
- (void)startTransition;
- (void)stopTransition;
@end
