//
//  ViewController.m
//  FlickrProject
//
//  Created by Luka Usalj on 03/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import "ViewController.h"
#import "FLCBackgroundView.h"

@interface ViewController ()
@property (nonatomic, strong)FLCBackgroundView *backgroundView;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UITextField *usernameTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) NSDictionary *viewsDictionary;
@property (strong, nonatomic) NSDictionary *metrics;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBackground];
    [self positionLogoInCenter];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{}

- (void)loadBackground
{
    self.backgroundView.frame = self.view.bounds;
    [self.view insertSubview:self.backgroundView atIndex:0];
}

- (void)positionLogoInCenter
{
    [self addSizeConstraintsToLogo];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logoImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.logoImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
    
}

- (void)addSizeConstraintsToLogo
{
    NSArray *size_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[logo(width)]"
                                                              options:0
                                                              metrics:self.metrics
                                                                views:self.viewsDictionary];
    
    NSArray *size_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[logo(height)]"
                                                              options:0
                                                              metrics:self.metrics
                                                                views:self.viewsDictionary];
    
    [self.logoImageView addConstraints:size_H];
    [self.logoImageView addConstraints:size_V];
}


- (IBAction)loginTapped:(UIButton *)sender {
    [self prepareLoginForm];
}

- (void)prepareLoginForm
{
    [self positionLogoOnTop];
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
//                         [self positionTextFields];
//                         [self textFieldsAppear];
                     }];
    
}

- (void)positionLogoOnTop
{
    [self.view.constraints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSLayoutConstraint class]]) {
            NSLayoutConstraint *constraint = (NSLayoutConstraint *)obj;
            if (constraint.firstAttribute == NSLayoutAttributeCenterY) {
                [self.view removeConstraint:constraint];
            }
        }
    }];
    
    NSArray *position_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[logo]"
                                                                  options:NSLayoutFormatAlignAllCenterX
                                                                  metrics:nil
                                                                    views:self.viewsDictionary];
    
    [self.view addConstraints:position_V];
}

- (void)positionTextFields
{
    [self setNewConstraints];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.view setNeedsUpdateConstraints];
                     }];
}

- (void)textFieldsAppear
{
    self.usernameTextField.alpha = 0;
    self.passwordTextField.alpha = 0;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.usernameTextField.alpha = 0.8;
                         self.passwordTextField.alpha = 0.8;
                     } completion:^(BOOL finished) {
                         [self.usernameTextField becomeFirstResponder];
                     }];
}

- (void)setNewConstraints
{
    self.usernameTextField = [UITextField new];
    self.usernameTextField.backgroundColor = [UIColor whiteColor];
    self.usernameTextField.placeholder = @"Username";
    self.usernameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.usernameTextField];
    
    self.passwordTextField = [UITextField new];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.placeholder = @"Password";

    self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.passwordTextField];
    

    
    NSArray *size_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[username(40)]"
                                                              options:0
                                                              metrics:nil
                                                                views:self.viewsDictionary];

    
    
    [self.usernameTextField addConstraints:size_V];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordTextField
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.usernameTextField
                                                                       attribute:NSLayoutAttributeHeight
                                                                      multiplier:1
                                                                        constant:0]];
   
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[username]-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:self.viewsDictionary];
    
    NSArray *constraint_V_username = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[logo]-20-[username]"
                                                              options:0
                                                              metrics:nil
                                                                views:self.viewsDictionary];
    
    
    [self.view addConstraints:constraint_H];
    [self.view addConstraints:constraint_V_username];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordTextField
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.usernameTextField
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0]];
    
    NSArray *constraint_V_password = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[username]-4-[password]"
                                                                             options:NSLayoutFormatAlignAllCenterX
                                                                             metrics:nil
                                                                               views:self.viewsDictionary];
    
    [self.view addConstraints:constraint_V_password];

}

- (NSDictionary *)viewsDictionary
{
    if (!_viewsDictionary) {
//        _viewsDictionary = @{@"username":self.usernameTextField,
//                             @"password":self.passwordTextField,
//                             @"logo":self.logoImageView};
        _viewsDictionary = @{@"logo":self.logoImageView};

    }
    return _viewsDictionary;
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        self.logoImageView = [UIImageView new];
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.logoImageView.image = [UIImage imageNamed:@"logo"];
        [self.view addSubview:self.logoImageView];
    }
    return _logoImageView;
}

- (FLCBackgroundView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [FLCBackgroundView new];
    }
    return _backgroundView;
}

- (NSDictionary *)metrics
{
    if (!_metrics) {
        float scaleFactor = self.logoImageView.image.size.width / self.logoImageView.image.size.height;
        
        float height = self.view.bounds.size.height/8;
        float width = scaleFactor * height;
        
        _metrics = @{@"width":[NSNumber numberWithFloat:width],
                     @"height":[NSNumber numberWithFloat:height]};
    }
    return _metrics;
}

@end
