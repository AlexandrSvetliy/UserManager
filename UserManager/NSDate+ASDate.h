//
//  NSDate+ASDate.h
//  UserManager
//
//  Created by Александр Светлый on 06.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASConstants.h"

@interface NSDate (ASDate)
- (NSString*)stringWithNormalDate;
- (instancetype)dateFromNormalString:(NSString*)string;
@end
