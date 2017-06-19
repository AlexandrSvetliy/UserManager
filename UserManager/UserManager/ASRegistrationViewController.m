//
//  ASRegistrationViewController.m
//  UserManager
//
//  Created by Александр Светлый on 13.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASRegistrationViewController.h"
#import "ASUser+CoreDataManagerExtention.h"

struct ASValidateStruct {
    ASValidationBool isValid;
    ASValidationMessage message;
};

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
//@property (strong, nonatomic) ASStorage *storage;

@end

@implementation ASRegistrationViewController

@synthesize login,password,firstName,lastName,email,birthday,country,gender;
@synthesize scrollView,lastResponder;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self subscribeToKeyboardNotifications];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAllPickers)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    if (self.user) {
        [self fillWithUserDictionary:self.user.dictionaryRepresentation];
    }
    
//    firstName.text = @"Alexandr";
//    lastName.text = @"Svetliy";
//    [self.gender setSelectedSegmentIndex:0];
//    country.text = @"Dnepr";
//    birthday.text = @"18.07.1986";
//    email.text = @"it@example.com";
//    login.text = @"alexandr";
//    password.text = @"12345";
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self unsubscribeFromKeyboardNotifications];
}
- (void)fillWithUserDictionary:(NSDictionary*)dictionary {
    firstName.text = dictionary[@"firstName"];
    lastName.text = dictionary[@"lastName"];
    [self.gender setSelectedSegmentIndex:[dictionary[@"gender"] integerValue]];
    country.text = dictionary[@"country"];
    birthday.text = [dictionary[@"birthday"] stringWithNormalDate];
    email.text = dictionary[@"email"];
    login.text = dictionary[@"login"];
    password.text = @"";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    //if (identifier == ASRegi)
}

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
    if (self.countryPicker) {
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
    birthday.text = [birthdayDate stringWithNormalDate];
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
    if (textField == country || textField == birthday) {
        if (![textField isFirstResponder]) [self dismissAllPickers];
        (textField == country)?[self showCountryPicker]:[self showBirthdayPicker];
        [scrollView setContentOffset:CGPointMake(0, ASPickerHeight) animated:YES];
        lastResponder = textField;
        return NO;
    }
    lastResponder = textField;
    
    return YES;
}
- (void)cleanTextFields {
    firstName.text = @"";
    lastName.text = @"";
    [self.gender setSelectedSegmentIndex:0];
    country.text = @"";
    birthday.text = @"";
}
- (NSDictionary *)userDictionary {
    return @{@"login":login.text,@"firstName":firstName.text,@"lastName":lastName.text,
             @"password":[password.text stringWithMD5],
             @"gender":[NSNumber numberWithInteger:gender.selectedSegmentIndex],
             @"country":country.text,
             @"birthday":[[NSDate alloc] dateFromNormalString:birthday.text],
             @"email":email.text,
             @"icon":UIImagePNGRepresentation([UIImage imageNamed:@"Hamelion Head"])};
}
- (NSDictionary*)validateFields {
    BOOL isValid = YES;
    NSMutableString *message = [NSMutableString stringWithString:@"Please fix following errors and try again:\r"];
    NSMutableString *errors = [NSMutableString stringWithString:@""];
    if (!login.text.length)
        [errors appendString:@"Login field is requeried.\r"];
    if (!firstName.text.length) [errors appendString:@"First Name field is requeried.\r"];
    if (!lastName.text.length) [errors appendString:@"Last Name field is requeried.\r"];
    if (!country.text.length) [errors appendString:@"Country field is requeried.\r"];
    if (!birthday.text.length) [errors appendString:@"Birthday field is requeried.\r"];
    if (!password.text.length) [errors appendString:@"Password field is requeried.\r"];
    if (!email.text.isValidEmail)
        [errors appendString:@"Please enter the valid email.\r"];
    if (errors.length) {
        isValid = NO;
        [message appendString:errors];
    }
    else {
        [message setString:@""];
    }
    return @{@"isValid":[NSNumber numberWithBool:isValid],@"message":[message copy]};
}

#pragma mark - Actions

- (IBAction)backButtonPressed:(ASUIButton *)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)signInButtonPressed:(ASUIButton *)sender {
    NSDictionary *isValidFields = self.validateFields;
    if ([isValidFields[@"isValid"] boolValue]) {
        if (!self.user) self.user = [ASUser addUserWithDictionary:self.userDictionary];
        else [self.user setUserWithDictionary:self.userDictionary];
        [self.user save];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        [self showAlertWithMessage:isValidFields[@"message"] Title:@"Error"];
    }
}

#pragma mark - Keyboard Notifications

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
