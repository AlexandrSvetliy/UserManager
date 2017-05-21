//
//  ASRegistrationViewController.h
//  UserManager
//
//  Created by Александр Светлый on 13.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryPickerView.h"
#import "BirthdayPickerView.h"

static const CGFloat ASPickerHeight = 245;
static const CGFloat ASAnimationDuration = 0.4;
static NSString* dateFormat = @"dd.MM.YYYY";

@interface ASRegistrationViewController : UIViewController <CountryPickerViewDelegate,BirthdayPickerViewDelegate>

@end
