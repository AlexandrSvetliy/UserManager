//
//  ASTableViewCell.m
//  UserManager
//
//  Created by Александр Светлый on 05.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASTableViewCell.h"

@interface ASTableViewCell ()
@property (nonatomic, strong) ASUser *user;
@end

@implementation ASTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)prepareForReuse {
    //[self.user removeObserver:self forKeyPath:@"login"];
}

- (void)fillWithPerson:(ASUser *)user {
    self.user = user;
//    [user addObserver:self forKeyPath:@"login" options:NSKeyValueObservingOptionNew context:nil];
    
//    NSDictionary *userDictionary = [user getUserDictionary];
    self.userLogin.text = user.login;//[userDictionary valueForKey:@"login"];
    self.detailUserInfo.text = [NSString stringWithFormat:@"%@ %@",user.firstName, user.lastName];
//    person.updateHandler = ^(LUPerson *updatedPerson) {
//        self.nameLabel.text = updatedPerson.firstName;
//    };
}
@end
