//
//  FLCLoginViewController.m
//  FlickrProject
//
//  Created by Luka Usalj on 28/04/15.
//  Copyright (c) 2015 Luka Usalj. All rights reserved.
//

#import "FLCLoginViewController.h"

@interface FLCLoginViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) UITextField *usernameTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (assign) BOOL *loginEnabled;
@property (strong, nonatomic) NSArray *tableCells;
@property (strong, nonatomic) NSMutableArray *textFields;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@end

@implementation FLCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)setup
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [self.loginButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateDisabled];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addConstraintsToTableView];
}

- (void)addConstraintsToTableView
{
    NSNumber *tableSize = [NSNumber numberWithFloat:self.tableView.rowHeight];
    NSDictionary *viewsDictionary = @{@"table" : self.tableView};
    NSDictionary *metrics = @{@"tableSize" : tableSize};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[table(tableSize)]"
                                                                      options:NSLayoutFormatAlignAllCenterX
                                                                      metrics:metrics
                                                                        views:viewsDictionary]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    [self login];
}

- (void)login
{
    
    [self setFocusOnView];

    NSString *nextTitle = ([self.loginButton.titleLabel.text isEqualToString:@"Login"]) ? @"Cancel" : @"Login";
    [self.loginButton setTitle:nextTitle forState:UIControlStateNormal];
    
}

- (void)setFocusOnView
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableCells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FLCLoginTableViewCell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"%@", indexPath);
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        CGRect frame = CGRectMake(cell.frame.origin.x + cell.frame.size.width/16, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        UITextField *textField = [[UITextField alloc] initWithFrame:frame];
        textField.tag = indexPath.row;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.returnKeyType = UIReturnKeyDone;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.delegate = self;
        
        NSString *cellName = self.tableCells[indexPath.row];
        textField.placeholder = cellName;
        
        switch (indexPath.row) {
            case 0:     //username
                textField.returnKeyType = UIReturnKeyNext;
                self.usernameTextField = textField;
                break;
                
            case 1:     //password
                textField.returnKeyType = UIReturnKeyGo;
                textField.secureTextEntry = YES;
                self.passwordTextField = textField;
                break;
                
            default:
                break;
        }
        [cell addSubview:textField];
        [self.textFields addObject:textField];
    }
    return cell;
}

- (NSArray *)tableCells
{
    if (!_tableCells) {
        _tableCells = @[@"Username", @"Password"];
    }
    return _tableCells;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger tag = textField.tag + 1;
    if (tag == self.tableCells.count) {
        [self login];
    } else {
        UITextField *nextField = (UITextField *)[self.tableView viewWithTag:tag];
        [nextField becomeFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    BOOL loginEnabled = NO;
    
    if (string.length == 0) {
        NSLog(@"%d", range.location);
        if (textField == self.usernameTextField) {
            loginEnabled = (username.length > 1 && password.length > 0);
        } else {
            loginEnabled = NO;
        }
    } else {
        loginEnabled = (textField == self.usernameTextField) ? (password.length > 0) : (username.length > 0);
    }
    
    self.loginButton.enabled = loginEnabled;
    
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
