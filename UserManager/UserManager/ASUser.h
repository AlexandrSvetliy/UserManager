//
//  ASUser.h
//  UserManager
//
//  Created by Александр Светлый on 21.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface ASUser : NSObject
- (NSDictionary*) getUserDictionary;
- (instancetype)initWithFirstName:(NSString*)firstName
                         LastName:(NSString*)lastName
                            Login:(NSString*)login
                         Password:(NSString*)password
                            Email:(NSString*)email
                           Gender:(NSNumber*)gender
                         Birthday:(NSDate*)  birthday
                          Country:(NSString*)country;
@end
