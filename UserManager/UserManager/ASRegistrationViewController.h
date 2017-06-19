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
typedef BOOL (*ASValidationBool)(BOOL);
typedef NSString* (*ASValidationMessage)(NSString*);

struct ASValidateStruct;


@interface ASRegistrationViewController : UIViewController <CountryPickerViewDelegate,BirthdayPickerViewDelegate>
@property (nonatomic, strong) ASUser *user;
@property (nonatomic, copy) ObjectHandler saveHandler;
- (void)fillWithUserDictionary:(NSDictionary*)dictionary;
//- (NSDictionary *)userDictionary;
@end
