//
//  FLCCollectionViewCell.m
//  FlickrProject
//
//  Created by Luka Usalj on 27/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import "FLCCollectionViewCell.h"

@interface FLCCollectionViewCell()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation FLCCollectionViewCell

- (void)loadCellImage:(UIImage *)image
{
    self.imageView.image = image;
}

@end
