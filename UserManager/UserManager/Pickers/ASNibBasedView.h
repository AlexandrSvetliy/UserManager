//
//  ASNibBasedView.h
//  TextFields
//
//  Created by Александр Светлый on 02.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASNibBasedView : UIView
- (UIView *)loadViewFromNib;
- (void)initializeProperties;
- (void)prepareForInterfaceBuilder;
@end
