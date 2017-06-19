//
//  ASTableViewCell.m
//  UserManager
//
//  Created by Александр Светлый on 05.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASTableViewCell.h"

@interface ASTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *userIcon;
@end

@implementation ASTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:47.0f/255.0f
                                                  green:103.0f/255.0f
                                                   blue:97.0f/255.0f
                                                  alpha:1.0f];
    [self setSelectedBackgroundView:bgColorView];
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
    self.userIcon.image = [UIImage imageWithData:user.icon];
//    person.updateHandler = ^(LUPerson *updatedPerson) {
//        self.nameLabel.text = updatedPerson.firstName;
//    };
}
@end
