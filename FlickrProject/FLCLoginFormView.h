//
//  FLCLoginFormView.h
//  FlickrProject
//
//  Created by Luka Usalj on 05/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLCLoginFormView : UIView <UITextFieldDelegate>
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
- (void)setUsernameAsResponder;
- (void)setWindowAsResponder;
@end
