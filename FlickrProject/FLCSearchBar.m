//
//  FLCSearchBar.m
//  FlickrProject
//
//  Created by Luka Usalj on 22/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import "FLCSearchBar.h"

@implementation FLCSearchBar

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [self setShowsCancelButton:NO animated:YES];
//    self.showsCancelButton = NO;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self resignFirstResponder];
}

@end
