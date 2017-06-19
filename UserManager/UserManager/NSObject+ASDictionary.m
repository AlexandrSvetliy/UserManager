//
//  NSObject+ASDictionary.m
//  UserManager
//
//  Created by Александр Светлый on 17.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "NSObject+ASDictionary.h"
#import <objc/runtime.h>

@implementation NSObject (ASDictionary)
- (NSDictionary *)dictionaryRepresentation {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        NSString *value = [self valueForKey:key];
        if (value) [dictionary setObject:value forKey:key];
    }
    return dictionary;
}
@end
