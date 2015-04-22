//
//  FLCExploreViewController.m
//  FlickrProject
//
//  Created by Luka Usalj on 22/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import "FLCExploreViewController.h"
#import "FLCSearchBar.h"

@interface FLCExploreViewController ()

@property (strong, nonatomic) IBOutlet FLCSearchBar *searchBar;
@end

@implementation FLCExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self.searchBar;
    // Do any additional setup after loading the view.
}


- (FLCSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [FLCSearchBar new];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"Nevera");
    searchBar.showsCancelButton = YES;
//    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}


@end
