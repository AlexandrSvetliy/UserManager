//
//  CountryPickerView.h
//  TextFields
//
//  Created by Александр Светлый on 02.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASNibBasedView.h"

@protocol CountryPickerViewDelegate <NSObject>

- (void)doneButtonPressedWithSelectedCountry:(NSString *)selectedCountry;
- (void)pickerDidSelectCountry:(NSString*)selectedCountry;

@end

IB_DESIGNABLE @interface CountryPickerView : ASNibBasedView

@property (weak,nonatomic) id <CountryPickerViewDelegate>delegate;

@end


