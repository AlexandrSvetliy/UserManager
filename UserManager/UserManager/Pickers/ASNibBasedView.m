//
//  ASNibBasedView.m
//  TextFields
//
//  Created by Александр Светлый on 02.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASNibBasedView.h"

@implementation ASNibBasedView

#pragma mark - Public

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self xibSetup];
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self xibSetup];
    
    return self;
}
- (void)initializeProperties {
}
- (UIView *)loadViewFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:bundle];
    UIView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    
    return view;
}
- (void)prepareForInterfaceBuilder {
    [self xibSetup];
}

#pragma mark - Private

- (void)xibSetup {
    UIView *view = [self loadViewFromNib];
    view.frame = self.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
    [self initializeProperties];
}

@end
