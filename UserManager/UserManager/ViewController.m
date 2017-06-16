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
//@property (strong, nonatomic)          ASStorage   *storage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
//    self.storage = [[ASStorage alloc] init];
    
    self.login.text = @"alexandr";
    self.password.text = @"12345";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dismissKeyboard {
    [self.login resignFirstResponder];
    [self.password resignFirstResponder];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma mark - Actions

- (IBAction)loginButtonPressed:(UIButton *)sender {
    
}

#pragma mark - Seque

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:ASLoginSequeID]) {
        if(![ASUser isUserExistWithFormat:@"login == %@ AND password == %@" AndArguments:@[self.login.text, [self.password.text stringWithMD5]]]) {
            [self showAlertWithMessage:@"Wrong login or password." Title:@"Access deny"];
            return NO;
        }
    }
    return YES;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:ASLoginSequeID]) {
        id destinationController = [segue destinationViewController];
//        [destinationController setStorage:self.storage];
            ASUser* user = [ASUser getUserWithLogin:self.login.text];
//        user.login = self.login.text;
//        [user setUserLogin:self.login.text];
        
        [destinationController setCurrentUser:user];
    }
}
@end
