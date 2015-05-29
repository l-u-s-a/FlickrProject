//
//  FLCLoginFormView.m
//  FlickrProject
//
//  Created by Luka Usalj on 05/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import "FLCLoginFormView.h"
#import "FLCButton.h"

@interface FLCLoginFormView()
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) FLCButton *loginButton;
@property (nonatomic, strong) NSDictionary *viewsDictionary;
@end

@implementation FLCLoginFormView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addConstraints];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField) [self.passwordTextField becomeFirstResponder];
    
    else if (textField == self.passwordTextField && self.loginButton.enabled) [self performLogin];
    
    return NO;
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
        [self addSubview:_usernameTextField];
    }
    return _usernameTextField;
}

- (UITextField *)passwordTextField
{
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
        [self addSubview:_passwordTextField];
    }
    return _passwordTextField;
}

- (FLCButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [FLCButton new];
        _loginButton.backgroundColor = [UIColor colorWithRed:123/255.0 green:12/255.0 blue:114/255.0 alpha:1];
        [_loginButton setTitle:@"Sign in" forState:UIControlStateNormal];
        _loginButton.enabled = NO;
        [_loginButton addTarget:self action:@selector(performLogin) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginButton];
    }
    return _loginButton;
}

- (void)performLogin
{
    [self setWindowAsResponder];
    
    self.buttonTitle = ([self.buttonTitle isEqualToString:@"Sign in"]) ? @"Cancel" : @"Sign in";
}

- (void)setUsernameAsResponder
{
    [self.usernameTextField becomeFirstResponder];
}

- (void)setWindowAsResponder
{
    ([self.usernameTextField isFirstResponder]) ? [self.usernameTextField resignFirstResponder] : [self.passwordTextField resignFirstResponder];
}

- (void)textFieldChanged:(UITextField *)textField
{
    self.loginButton.enabled = (self.username.length > 0 && self.password.length > 0);
}

- (void)addConstraints
{
    NSDictionary *viewsDictionary = @{@"username":self.usernameTextField,
                                      @"password":self.passwordTextField,
                                      @"login":self.loginButton};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[username]-4-[password]-16-[login]|"
                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
    
   
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[username]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.usernameTextField
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.passwordTextField
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.usernameTextField
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.passwordTextField
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.usernameTextField
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.loginButton
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.usernameTextField
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.loginButton
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1
                                                      constant:0]];
}

- (NSString *)username
{
    return self.usernameTextField.text;
}

- (void)setUsername:(NSString *)username
{
    self.usernameTextField.text = username;
}

- (NSString *)password
{
    return self.passwordTextField.text;
}

- (void)setPassword:(NSString *)password
{
    self.passwordTextField.text = password;
}

- (NSString *)buttonTitle
{
    return self.loginButton.titleLabel.text;
}

- (void)setButtonTitle:(NSString *)buttonTitle
{
    [self.loginButton setTitle:buttonTitle forState:UIControlStateNormal];
}

@end
