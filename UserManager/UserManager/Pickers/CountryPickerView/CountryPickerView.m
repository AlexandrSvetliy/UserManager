//
//  CountryPickerView.m
//  TextFields
//
//  Created by Александр Светлый on 02.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "CountryPickerView.h"

@interface CountryPickerView ()

@property (strong, nonatomic) IBOutlet UIPickerView *picker;

@property (strong, nonatomic) NSArray *countries;
@property (copy  , nonatomic) NSString *selectedCountry;

@end

@implementation CountryPickerView

#pragma mark - Public

- (void)awakeFromNib {
    [super awakeFromNib];
    self.countries = [NSLocale ISOCountryCodes];
}
#pragma mark - Actions

- (IBAction)doneButtonPressed:(UIButton *)sender {
    [self.delegate doneButtonPressedWithSelectedCountry:self.selectedCountry];
}
- (IBAction)locateButtonPressed:(UIButton *)sender {
    NSString *countryCode = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    [self.picker selectRow:[self.countries indexOfObject:countryCode] inComponent:0 animated:YES];
    [self pickerView:self.picker didSelectRow:[self.countries indexOfObject:countryCode] inComponent:0];
}

#pragma mark - Picker DataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.countries.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:self.countries[row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedCountry = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:self.countries[row]];
    [self.delegate pickerDidSelectCountry:self.selectedCountry];
}
@end
