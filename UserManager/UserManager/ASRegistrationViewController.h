//
//  ASRegistrationViewController.h
//  UserManager
//
//  Created by Александр Светлый on 13.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASUIButton.h"
#import "NSString+ASHash.h"
#import "UIViewController+ASMessageBox.h"
#import "NSDate+ASDate.h"
#import "CountryPickerView.h"
#import "BirthdayPickerView.h"

@class ASUser;

typedef void (^ObjectHandler)(id);
//#import "ASStorage.h"
//#import "ASUser+CoreDataClass.h"

static const CGFloat ASPickerHeight = 245;
static const CGFloat ASAnimationDuration = 0.4;

@interface ASRegistrationViewController : UIViewController <CountryPickerViewDelegate,BirthdayPickerViewDelegate>
@property (nonatomic, strong) ASUser *user;
@property (nonatomic, copy) ObjectHandler saveHandler;
//- (NSDictionary *)userDictionary;
@end
