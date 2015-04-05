//
//  ViewController.m
//  FlickrProject
//
//  Created by Luka Usalj on 03/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import "ViewController.h"
#import "FLCBackgroundView.h"
#import "FLCLoginFormView.h"

@interface ViewController ()
@property (nonatomic, strong)FLCBackgroundView *backgroundView;
@property (nonatomic, strong)FLCLoginFormView *loginFormView;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UITextField *usernameTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) NSDictionary *viewsDictionary;
@property (strong, nonatomic) NSDictionary *metrics;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *exploreViewButton;
@property (strong, nonatomic) IBOutlet UIButton *loginFormButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBackground];
    [self positionLogoInCenter];
}

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
    [self loginElementsAppear];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
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
    
    NSArray *position_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[logo]"
                                                                  options:NSLayoutFormatAlignAllCenterX
                                                                  metrics:nil
                                                                    views:self.viewsDictionary];
    
    [self.view addConstraints:position_V];
}

- (void)loginElementsAppear
{
    [UIView animateWithDuration:0.6
                          delay:0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.usernameTextField.alpha = 0.8;
                         self.passwordTextField.alpha = 0.8;
                         self.loginButton.alpha = 0.5;
                        [self.usernameTextField becomeFirstResponder];
                     } completion:^(BOOL finished) {
                         self.exploreViewButton.alpha = 0;
                         self.loginFormButton.alpha = 0;
                     }];
}

- (NSDictionary *)viewsDictionary
{
    if (!_viewsDictionary) {
        _viewsDictionary = @{@"username":self.usernameTextField,
                             @"password":self.passwordTextField,
                             @"login":self.loginButton,
                             @"logo":self.logoImageView};
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

- (UITextField *)usernameTextField
{
    if (!_usernameTextField) {
        _usernameTextField = [UITextField new];
        _usernameTextField.backgroundColor = [UIColor whiteColor];
        _usernameTextField.placeholder = @"Username";
        _usernameTextField.spellCheckingType = UITextSpellCheckingTypeNo;
        _usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _usernameTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _usernameTextField.returnKeyType = UIReturnKeyNext;
        _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _usernameTextField.delegate = self;
        [_usernameTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        _usernameTextField.alpha = 0;
        [self.view addSubview:_usernameTextField];
        [self addConstraintsToUsername];
    }
    return _usernameTextField;
}

- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [UITextField new];
        _passwordTextField.backgroundColor = [UIColor whiteColor];
        _passwordTextField.placeholder = @"Password";
        _passwordTextField.spellCheckingType = UITextSpellCheckingTypeNo;
        _passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _passwordTextField.returnKeyType = UIReturnKeyGo;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.delegate = self;
        [_passwordTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        _passwordTextField.alpha = 0;
        [self.view addSubview:_passwordTextField];
        [self addConstraintsToPassword];
    }
    return _passwordTextField;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton new];
//        _loginButton.backgroundColor = [UIColor colorWithRed:161/255.0 green:16/255.0 blue:149/255.0 alpha:1];
//        _loginButton.backgroundColor = [[UIColor alloc] initWithWhite:1 alpha:1];
        _loginButton.backgroundColor = [UIColor colorWithRed:161/255.0 green:16/255.0 blue:149/255.0 alpha:1];
//        [_loginButton setTitleColor:[UIColor colorWithRed:161/255.0 green:16/255.0 blue:149/255.0 alpha:1] forState:UIControlStateNormal];
        _loginButton.enabled = NO;
        _loginButton.layer.cornerRadius = 5;
        _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[[UIColor alloc] initWithWhite:1 alpha:0.3] forState:UIControlStateHighlighted];
        _loginButton.alpha = 0;
        [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginButton];
        [self addConstraintsToLoginButton];
    }
    return _loginButton;
}


- (void)textFieldChanged:(UITextField *)textField
{
    [self updateLoginButton];
}

- (void)updateLoginButton
{
    self.loginButton.enabled = (self.usernameTextField.text.length > 0 && self.passwordTextField.text.length > 0);
    self.loginButton.alpha = (self.loginButton.enabled) ? 1 : 0.5;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
        return NO;
    } else if (textField == self.passwordTextField) {
        if (self.loginButton.enabled) [self login];
        return NO;
    }
    return YES;
}

- (void)login
{
    if (self.usernameTextField.isFirstResponder) [self.usernameTextField resignFirstResponder];
    else if (self.passwordTextField.isFirstResponder) [self.passwordTextField resignFirstResponder];
    NSString *buttonTitle = [self.loginButton.titleLabel.text isEqualToString:@"Login"] ? @"Cancel" : @"Login";
    [self.loginButton setTitle:buttonTitle forState:UIControlStateNormal];
}

- (void)addConstraintsToUsername
{
    NSArray *size_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[username(40)]"
                                                              options:0
                                                              metrics:nil
                                                                views:self.viewsDictionary];
    
    
    
    [self.usernameTextField addConstraints:size_V];
    
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[username]-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:self.viewsDictionary];
    [self.view addConstraints:constraint_H];
    
    NSArray *constraint_V_username = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[logo]-30-[username]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:self.viewsDictionary];
    
    
    [self.view addConstraints:constraint_V_username];
}

- (void)addConstraintsToPassword
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordTextField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.usernameTextField
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1
                                                           constant:0]];
    
    
    
    
    
    
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

- (void)addConstraintsToLoginButton
{
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.passwordTextField
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.passwordTextField
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[password]-16-[login]"
                                                                      options:NSLayoutFormatAlignAllCenterX
                                                                      metrics:nil
                                                                        views:self.viewsDictionary]];
}

- (FLCLoginFormView *)loginFormView
{
    if (!_loginFormView) {
        _loginFormView = [[FLCLoginFormView alloc] init];
        _loginFormView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/3);
        _loginFormView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _loginFormView;
}

@end
