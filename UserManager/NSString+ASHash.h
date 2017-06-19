//
//  NSString+ASHash.h
//  UserManager
//
//  Created by Александр Светлый on 21.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import <Foundation/Foundation.h>
#import	<CommonCrypto/CommonHMAC.h>

@interface NSString (ASHash)
- (instancetype)stringWithMD5;
- (BOOL)isValidEmail;
@end
