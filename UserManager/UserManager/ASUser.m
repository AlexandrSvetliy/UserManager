//
//  ASUser.m
//  UserManager
//
//  Created by Александр Светлый on 21.05.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASUser.h"

@interface ASUser()
@property (nonatomic, copy)   NSString  *firstName;
@property (nonatomic, copy)   NSString  *lastName;
@property (nonatomic, assign) NSDate    *birthday;
@property (nonatomic, assign) NSNumber  *gender;
@property (nonatomic, copy)   NSString  *country;
@property (nonatomic, copy)   NSString  *login;
@property (nonatomic, copy)   NSString  *password;
@property (nonatomic, copy)   NSString  *email;
@end

@implementation ASUser
- (instancetype)init {
    self = [super init];
    if (self) {
        _firstName  = @"";
        _lastName   = @"";
        _gender     = nil;
        _birthday   = nil;
        _country    = @"";
        _login      = @"";
        _password   = @"";
        _email      = @"";
        
    }
    return self;
}
- (instancetype)initWithFirstName:(NSString*)firstName
                         LastName:(NSString*)lastName
                            Login:(NSString*)login
                         Password:(NSString*)password
                            Email:(NSString*)email
                           Gender:(NSNumber*)gender
                         Birthday:(NSDate*)  birthday
                          Country:(NSString*)country
{
    _firstName  = firstName;
    _lastName   = lastName;
    _gender     = gender;
    _birthday   = birthday;
    _country    = country;
    _login      = login;
    _password   = password;
    _email      = email;
    
    return self;
}
- (NSDictionary*)getUserDictionary {
    return @{@"login":self.login,@"firstName":self.firstName,@"lastName":self.lastName,@"password":self.password,@"email":self.email,@"gender":self.gender,@"birthday":self.birthday,@"country":self.country};
}
@end
