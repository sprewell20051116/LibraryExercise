//
//  UserListViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/30/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "UserListViewController.h"
#import "UserViewController.h"
@interface UserListViewController () {
    NSArray *_UserListArray;
}

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _CoreData = [[CoreDataModel alloc] init];
    _UserListArray = [_CoreData FetchObjInCoreData];
    
    _TableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _TableView.dataSource = self;
    _TableView.delegate = self;
    [self.view addSubview:_TableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_UserListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_UserListArray[indexPath.row] valueForKey:USER_CORE_DATA_NAME];
    
    /*
    NSManagedObject *LoanObj = [_LoanListData objectAtIndex:indexPath.row];
    NSManagedObject *BookObj = [[_CoreData CoreDataSearchWithBookID:[LoanObj valueForKey:@"bookId"]] firstObject];
    cell.textLabel.text = [BookObj valueForKey:BOOK_DATA_KEY_TITLE];
    cell.detailTextLabel.text = [LoanObj valueForKey:@"branch"];
    [cell.textLabel setFont:[UIFont systemFontOfSize:30.0f]];
    */
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self performSegueWithIdentifier:@"UserList" sender:_UserListArray[indexPath.row]];
    
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    UserViewController* AddVC = [sb instantiateViewControllerWithIdentifier:@"UserNavViewController"];
    
    AddVC.UserName = [_UserListArray[indexPath.row] valueForKey:USER_CORE_DATA_NAME];
    //[AddVC.UserInfoSubView.BorrowBrn setHidden:YES];
    [self.navigationController pushViewController:AddVC animated:YES];
    
}


-(void) LogoutBtnClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//    if ([[segue identifier] isEqualToString:@"UserList"]) {
//        
//        // Get destination view
//        UserViewController *vc = [segue destinationViewController];
//        vc.UserID = [sender valueForKey:USER_CORE_DATA_CARDID];
//        vc.UserID = [sender valueForKey:USER_CORE_DATA_NAME];
//    }
//
//}

@end
