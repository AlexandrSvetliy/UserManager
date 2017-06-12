//
//  NSDate+ASDate.m
//  UserManager
//
//  Created by Александр Светлый on 06.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "NSDate+ASDate.h"

@implementation NSDate (ASDate)
- (NSString*)stringWithNormalDate {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:dateFormat];
    return [formater stringFromDate:self];
}
- (instancetype)dateFromNormalString:(NSString*)string {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:dateFormat];
    return [formater dateFromString:string];
}
@end
