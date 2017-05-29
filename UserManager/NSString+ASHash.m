//
//  NSString+ASHash.m
//  UserManager
//
//  Created by Александр Светлый on 21.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "NSString+ASHash.h"

@implementation NSString (ASHash)
- (instancetype) stringWithMD5 {
    const char *ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return [output copy];
}
@end
