//
//  BirthdayPickerView.m
//  TextFields
//
//  Created by Александр Светлый on 07.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "BirthdayPickerView.h"

@interface BirthdayPickerView()
@property (strong, nonatomic) IBOutlet UIDatePicker *birthdayDatePicker;
@end

@implementation BirthdayPickerView

#pragma mark - Public

- (void)awakeFromNib {
    [super awakeFromNib];
    self.birthdayDatePicker.maximumDate = [NSDate date];
}

#pragma mark - Actions

- (IBAction)nowButtonPressed:(id)sender {
    [self.birthdayDatePicker setDate:[NSDate date] animated:YES];
}
- (IBAction)doneButtonPressed:(id)sender {
    [self.delegate doneButtonPressedWithBirthdayDate:self.birthdayDatePicker.date];
}
@end
