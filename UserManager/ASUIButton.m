//
//  ASUIButton.m
//  UserManager
//
//  Created by Александр Светлый on 30.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASUIButton.h"

@implementation ASUIButton

-(void)awakeFromNib {
    [super awakeFromNib];
    [self.layer setCornerRadius:4.0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
