//
//  ASRegistrationViewController.m
//  UserManager
//
//  Created by Александр Светлый on 13.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASRegistrationViewController.h"

@interface ASRegistrationViewController ()
@property (strong, nonatomic) IBOutlet UIButton *signinButton;
@property (strong, nonatomic) IBOutlet UITextField *login;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *birthday;
@property (strong, nonatomic) IBOutlet UITextField *country;

@end

@implementation ASRegistrationViewController

@synthesize login,password,firstName,lastName,email,birthday,country;

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAllPickers)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dismissAllPickers {
    [login resignFirstResponder];
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [email resignFirstResponder];
    [password resignFirstResponder];
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
