//
//  ASUser+CoreDataProperties.m
//  UserManager
//
//  Created by Александр Светлый on 12.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASUser+CoreDataProperties.h"

@implementation ASUser (CoreDataProperties)

+ (NSFetchRequest<ASUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Users"];
}

@dynamic birthday;
@dynamic country;
@dynamic email;
@dynamic firstName;
@dynamic gender;
@dynamic icon;
@dynamic lastName;
@dynamic login;
@dynamic password;

@end
