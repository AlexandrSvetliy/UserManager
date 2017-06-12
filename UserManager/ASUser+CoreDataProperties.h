//
//  ASUser+CoreDataProperties.h
//  UserManager
//
//  Created by Александр Светлый on 12.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ASUser (CoreDataProperties)

+ (NSFetchRequest<ASUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *birthday;
@property (nullable, nonatomic, copy) NSString *country;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nonatomic) int16_t gender;
@property (nullable, nonatomic, retain) NSData *icon;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *login;
@property (nullable, nonatomic, copy) NSString *password;

@end

NS_ASSUME_NONNULL_END
