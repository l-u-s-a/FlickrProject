
//
//  FLCExploreViewController.m
//  FlickrProject
//
//  Created by Luka Usalj on 22/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import "FLCExploreViewController.h"
#import "FlickrKit.h"
#import "FLCCollectionViewCell.h"
#import "FLCImage.h"

@interface FLCExploreViewController ()

@property (strong, nonatomic) NSMutableArray *cells;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation FLCExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadPhotos];
    // Do any additional setup after loading the view.
}

- (void)setup
{
    self.searchBar.delegate = self;
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.collectionView reloadData];
}

- (void)loadPhotos
{
    FlickrKit *flickrKit = [FlickrKit sharedFlickrKit];
    FKFlickrInterestingnessGetList *list = [[FKFlickrInterestingnessGetList alloc] init];
    
    [flickrKit call:list completion:^(NSDictionary *response, NSError *error) {
        if (!response) return;
        NSArray *photos = [response valueForKeyPath:@"photos.photo"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photos = photos;
            [self.collectionView reloadData];
        });
    }];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.collectionView.alpha = 0.4;
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    self.collectionView.alpha = 1;
    [self.searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [[FlickrKit sharedFlickrKit] call:@"flickr.photos.search" args:@{@"text": searchBar.text} maxCacheAge:FKDUMaxAgeOneHour completion:^(NSDictionary *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response) {
                self.photos = [response valueForKeyPath:@"photos.photo"];
            } else {
                // show the error
            }
        });
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.cells[indexPath.item]) {
        return self.cells[indexPath.item];
    }
    
    static NSString *cellIdentifier = @"Flickr Photo Cell";
    FLCCollectionViewCell *cell = (FLCCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    self.cells[indexPath.item] = cell;
    
    dispatch_async(dispatch_queue_create(NULL, NULL), ^{
        NSDictionary *photo = self.photos[indexPath.item];
        
        FLCImage *flcimage = [[FLCImage alloc] initWithDescriptionDictionary:photo];
        
        UIImage *cellImage = [flcimage smallSizedImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell loadCellImage:cellImage];
        });
    });
    
    return cell;
}

@end
