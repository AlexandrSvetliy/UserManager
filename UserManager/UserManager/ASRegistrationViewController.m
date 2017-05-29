//
//  ASRegistrationViewController.m
//  UserManager
//
//  Created by Александр Светлый on 13.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASRegistrationViewController.h"

@interface ASRegistrationViewController ()

@property (strong, nonatomic) CountryPickerView    *countryPicker;
@property (strong, nonatomic) BirthdayPickerView   *birthdayPicker;
@property (weak  , nonatomic) UITextField          *lastResponder;

@property (strong, nonatomic) IBOutlet UIScrollView*scrollView;
@property (strong, nonatomic) IBOutlet UITextField *login;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *birthday;
@property (strong, nonatomic) IBOutlet UITextField *country;
@property (strong, nonatomic) IBOutlet UISegmentedControl *gender;
@property (strong, nonatomic) ASStorage *storage;

@end

@implementation ASRegistrationViewController

@synthesize login,password,firstName,lastName,email,birthday,country,gender;
@synthesize scrollView,lastResponder;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self subscribeToKeyboardNotifications];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAllPickers)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.storage = [[ASStorage alloc] init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self unsubscribeFromKeyboardNotifications];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Pickers manage methods

- (void)dismissAllPickers {
    [login resignFirstResponder];
    [firstName resignFirstResponder];
    [lastName resignFirstResponder];
    [email resignFirstResponder];
    [password resignFirstResponder];
    
    [self hideCountryPicker];
    [self hideBirthdayPicker];
}
- (void)showCountryPicker {
    if (!self.countryPicker) {
        CGRect screenFrame = scrollView.frame;
        CGRect pickerFrame = CGRectMake(0, screenFrame.size.height, screenFrame.size.width, ASPickerHeight);
        CountryPickerView *picker = [[CountryPickerView alloc] initWithFrame:pickerFrame];
        [picker awakeFromNib];
        [self.view addSubview:picker];
        pickerFrame.origin = CGPointMake(0, screenFrame.size.height - ASPickerHeight);
        [UIView animateWithDuration:0.3 animations:^{
            picker.frame = pickerFrame;
        }];
        self.countryPicker = picker;
        self.countryPicker.delegate = self;
    }
}
- (void)hideCountryPicker {
    if (self.countryPicker)
    {
        CGRect finalFrame = self.countryPicker.frame;
        finalFrame.origin = CGPointMake(0, self.view.frame.size.height);
        [UIView animateWithDuration:0.3 animations:^{
            self.countryPicker.frame = finalFrame;
        } completion:^(BOOL finished) {
            [self.countryPicker removeFromSuperview];
            self.countryPicker = nil;
        }];
        [scrollView setContentOffset:CGPointZero animated:YES];
    }
}
- (void)showBirthdayPicker {
    if (!self.birthdayPicker) {
        CGRect screenFrame = self.view.frame;
        CGRect pickerFrame = CGRectMake(0, screenFrame.size.height, screenFrame.size.width, ASPickerHeight);
        BirthdayPickerView *picker = [[BirthdayPickerView alloc] initWithFrame:pickerFrame];
        [picker awakeFromNib];
        [self.view addSubview:picker];
        pickerFrame.origin = CGPointMake(0, screenFrame.size.height - ASPickerHeight);
        [UIView animateWithDuration:0.3 animations:^{
            picker.frame = pickerFrame;
        }];
        self.birthdayPicker = picker;
        self.birthdayPicker.delegate = self;
    }
}
- (void)hideBirthdayPicker {
    if (self.birthdayPicker) {
        CGRect finalFrame = self.birthdayPicker.frame;
        finalFrame.origin = CGPointMake(0, self.view.frame.size.height);
        [UIView animateWithDuration:0.3 animations:^{
            self.birthdayPicker.frame = finalFrame;
        } completion:^(BOOL finished) {
            [self.birthdayPicker removeFromSuperview];
            self.birthdayPicker = nil;
        }];
        [scrollView setContentOffset:CGPointZero animated:YES];
    }
}

#pragma mark - CountryPickerView && BirthdayPickerView delegate functions

- (void)doneButtonPressedWithSelectedCountry:(NSString *)selectedCountry {
    [self hideCountryPicker];
}
- (void)pickerDidSelectCountry:(NSString *)selectedCountry {
    country.text = selectedCountry;
}
- (void)doneButtonPressedWithBirthdayDate:(NSDate *)birthdayDate{
    [self hideCountryPicker];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:dateFormat];
    birthday.text = [formater stringFromDate:birthdayDate];
    [self hideBirthdayPicker];
}

#pragma mark - TextFields states

- (void)textFieldDidBeginEditing:(UITextField *)textField {
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ((lastResponder == birthday || lastResponder == country) && ![textField isFirstResponder]) {
        [self dismissAllPickers];
    }
    if (textField == country || textField == birthday)
    {
        if (![textField isFirstResponder]) [self dismissAllPickers];
        (textField == country)?[self showCountryPicker]:[self showBirthdayPicker];
        [scrollView setContentOffset:CGPointMake(0, ASPickerHeight) animated:YES];
        lastResponder = textField;
        return NO;
    }
    lastResponder = textField;
    
    return YES;
}
- (void)cleanTextFeilds {
    firstName.text = @"";
    lastName.text = @"";
    [self.gender setSelectedSegmentIndex:0];
    country.text = @"";
    birthday.text = @"";
}

#pragma mark - Actions

- (IBAction)signInButtonPressed:(UIButton *)sender {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:dateFormat];
    
    ASUser *newUser = [[ASUser alloc] initWithFirstName:firstName.text
                                               LastName:lastName.text
                                                  Login:login.text
                                               Password:[password.text stringWithMD5]
                                                  Email:email.text
                                                 Gender:[NSNumber numberWithInteger:gender.selectedSegmentIndex]
                                               Birthday:[formater dateFromString:birthday.text]
                                                Country:country.text];
    [self.storage addUser:newUser];
}

#pragma mark - Keybord Notifications

- (void)subscribeToKeyboardNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(keyboardDidChange:)
                               name:UIKeyboardWillChangeFrameNotification
                             object:nil];
}

- (void)unsubscribeFromKeyboardNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self
                                  name:UIKeyboardWillChangeFrameNotification
                                object:nil];
}

- (void)keyboardDidChange:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0);
    [UIView animateWithDuration:duration animations:^{
        [scrollView scrollRectToVisible:CGRectMake(scrollView.contentSize.width,
                                                        scrollView.contentSize.height - keyboardFrame.size.height, 0, 0) animated:YES];
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        scrollView.contentInset = UIEdgeInsetsZero;
    }];
}
@end
