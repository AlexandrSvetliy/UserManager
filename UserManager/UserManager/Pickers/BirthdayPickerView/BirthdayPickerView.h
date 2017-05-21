//
//  BirthdayPickerView.h
//  TextFields
//
//  Created by Александр Светлый on 07.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASNibBasedView.h"

@protocol BirthdayPickerViewDelegate <NSObject>
- (void)doneButtonPressedWithBirthdayDate:(NSDate *)birthday;
@end

@interface BirthdayPickerView : ASNibBasedView
@property (weak, nonatomic) id <BirthdayPickerViewDelegate> delegate;
@end
