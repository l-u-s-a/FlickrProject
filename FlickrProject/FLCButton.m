//
//  FLCLoginButton.m
//  FlickrProject
//
//  Created by Luka Usalj on 05/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import "FLCButton.h"

@interface FLCButton()
@property (nonatomic, strong) UIColor *originalColor;
@property (nonatomic, strong) UIColor *highlightedColor;
@end

@implementation FLCButton

static float highlightedFactor = 1.2;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 5;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.showsTouchWhenHighlighted = YES;
        [self setTitleColor:[[UIColor alloc] initWithWhite:1 alpha:0.2] forState:UIControlStateDisabled];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    self.backgroundColor = (highlighted) ? self.highlightedColor : self.originalColor;
}

- (UIColor *)originalColor
{
    if (!_originalColor) _originalColor = self.backgroundColor;
    return _originalColor;
}

- (UIColor *)highlightedColor
{
    if (!_highlightedColor) {
        const CGFloat* colors = CGColorGetComponents(self.originalColor.CGColor);
        float red, green, blue;
        
        red = colors[0] * highlightedFactor;
        green = colors[1] * highlightedFactor;
        blue = colors[2] * highlightedFactor;
        
        _highlightedColor = [UIColor colorWithRed:red
                                               green:green
                                                blue:blue
                                               alpha:CGColorGetAlpha(self.originalColor.CGColor)];
    }
    return _highlightedColor;
}


@end
