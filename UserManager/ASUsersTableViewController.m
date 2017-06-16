//
//  ASUsersTableViewController.m
//  UserManager
//
//  Created by Александр Светлый on 04.06.17.
//  Copyright © 2017 Александр Светлый. All rights reserved.
//

#import "ASUsersTableViewController.h"

@interface ASUsersTableViewController () <UITableViewDataSource, UITableViewDelegate>
//@property (strong, nonatomic) ASStorage *storage;

@property (nonatomic, strong) NSArray *users;
@end

@implementation ASUsersTableViewController
//@synthesize storage;
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addUser)];
    self.navigationItem.rightBarButtonItem = item;
    [self reloadAllData];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reloadAllData) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshControl;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//- (void)setStorage:(ASStorage *)storage {
//    _storage = storage;
//}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addUser {
    
}
- (void)reloadAllData {
//    NSArray *addresses = [Address allAddresses];
//    for (Address *address in addresses) {
//        NSLog(@"%@ %@ %@ %@", address.country, address.city, address.street, address.code);
//    }
    
    self.users = [ASUser users];
    [self.usersTableView reloadData];
    [self.tableView.refreshControl endRefreshing];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    #warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    #warning Incomplete implementation, return the number of rows
    return self.users.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *identifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
//    }
//    ASUser *user = self.users[indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", [user getUserDictionary]];
//    
//    return cell;
    if (indexPath.row < self.users.count) {
        NSString *identifier = NSStringFromClass([ASTableViewCell class]);
        ASTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        ASUser *user = self.users[indexPath.row];
        //cell.imageView.image = user.icon;
        cell.imageView.layer.masksToBounds = YES;
        [cell fillWithPerson:user];
        
        return cell;
    } else {
        return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ASTableViewCell class])];
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
     //Return NO if you do not want the specified item to be editable.
    return YES;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
