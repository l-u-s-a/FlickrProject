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
@property (strong, nonatomic) NSArray *tableCells;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@end

@implementation FLCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableCells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
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
                break;
                
            case 1:     //password
                textField.returnKeyType = UIReturnKeyGo;
                textField.secureTextEntry = YES;
                break;
                
            default:
                break;
        }
        [cell addSubview:textField];
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

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"dada");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger tag = textField.tag + 1;
    if (tag == self.tableCells.count) {
        [textField resignFirstResponder];
        NSLog(@"LOGIN");
    } else {
        UITextField *nextField = (UITextField *)[self.tableView viewWithTag:tag];
        [nextField becomeFirstResponder];
    }
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
