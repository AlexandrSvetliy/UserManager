//
//  ASUserProfileViewController.m
//  UserManager
//
//  Created by Александр Светлый on 04.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASUserProfileViewController.h"

@interface ASUserProfileViewController () <UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *userLoginLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstName;
@property (strong, nonatomic) IBOutlet UILabel *lastName;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *birthday;
@property (strong, nonatomic) IBOutlet UILabel *country;
@property (strong, nonatomic) IBOutlet UILabel *gender;
@property (strong, nonatomic) IBOutlet UIImageView *userIcon;
//@property (strong, nonatomic)          ASStorage   *storage;
@property (strong, nonatomic)          ASUser      *currentUser;


@end

@implementation ASUserProfileViewController

#pragma mark - Private

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUserInfo];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)loadUserInfo {
//    self.currentUser = [ASUser getUserWithLogin:self.currentUser.login];
//    NSDictionary *userDictionary = [self.currentUser getUserDictionary];
    
    self.userLoginLabel.text = self.currentUser.login;//userDictionary[@"login"];
    self.firstName.text = self.currentUser.firstName;//userDictionary[@"firstName"];
    self.lastName.text = self.currentUser.lastName;//userDictionary[@"lastName"];
    self.email.text = self.currentUser.email;//userDictionary[@"email"];
    self.birthday.text = [self.currentUser.birthday stringWithNormalDate];//[userDictionary[@"birthday"] stringWithNormalDate];
    self.country.text = self.currentUser.country;//userDictionary[@"country"];
    self.gender.text = self.currentUser.gender?@"WOMAN":@"MAN";//[userDictionary[@"gender"] integerValue]?@"WOMAN":@"MAN";
    self.userIcon.image = [UIImage imageWithData:self.currentUser.icon];//[UIImage imageWithData:userDictionary[@"icon"]];
}

#pragma mark - Public
//
//- (void)setStorage:(ASStorage *)storage {
//    _storage = storage;
//}
- (void)setCurrentUser:(ASUser*)user {
    _currentUser = user;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:ASUsersListSequeID]) {
//        id destinationController = [segue destinationViewController];
//        [destinationController setStorage:self.storage];
    }
}

#pragma mark - Actions

- (IBAction)imageButtonPressed:(UIButton *)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *selectionController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [selectionController addAction:[UIAlertAction actionWithTitle:@"Take photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self showPickerForSource:UIImagePickerControllerSourceTypeCamera];
        }]];
        [selectionController addAction:[UIAlertAction actionWithTitle:@"Select from album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self showPickerForSource:UIImagePickerControllerSourceTypePhotoLibrary];
        }]];
        [selectionController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
        [self presentViewController:selectionController animated:YES completion:nil];
    } else {
        [self showPickerForSource:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}
- (IBAction)logoutButtonPressed:(ASUIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)showPickerForSource:(UIImagePickerControllerSourceType)source {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = source;
    imagePicker.editing = YES;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.userIcon.image = image;
    self.currentUser.icon = UIImagePNGRepresentation(image);
    [self.currentUser save];
//    if (self.saveHandler) {
//        self.saveHandler(self.currentUser);
//    }
//    else NSLog(@"Can't save user %@",self.currentUser.login);
//    [self.currentUser saveUser];
//    [self.currentUser updateUserWithUser:self.currentUser];
//    if (!self.user) {
//        self.user = [ASUser addUserWithDictionary:self.userDictionary];
//        if (self.saveHandler) {
//            self.saveHandler(self.user);
//        }
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    } else {
//        [self showAlertWithMessage:@"Can't add user to storage." Title:@"Error"];
//        //        [self.user updateUserWithDictionary:self.userDictionary];
//    }
//    [self.currentUser setIcon:UIImagePNGRepresentation(image)];
//    [self.storage editUser:self.currentUser];
    //[self.tableView reloadData];
    
    [self dismissViewControllerAnimated:picker completion:nil];
}
@end
