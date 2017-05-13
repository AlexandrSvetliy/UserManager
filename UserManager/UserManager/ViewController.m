//
//  ViewController.m
//  UserManager
//
//  Created by Александр Светлый on 13.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *login;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *signinButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginButton.layer setCornerRadius:4.0];
    [self.signinButton.layer setCornerRadius:4.0];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dismissKeyboard {
    [self.login resignFirstResponder];
    [self.password resignFirstResponder];
}

#pragma mark - Actions

- (IBAction)loginButtonPressed:(UIButton *)sender {
}

@end
