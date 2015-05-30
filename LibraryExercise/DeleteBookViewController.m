//
//  DeleteBookViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/30/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "DeleteBookViewController.h"

@interface DeleteBookViewController () {
    NSArray *_UserListArray;

}

@end

@implementation DeleteBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.title = @"點擊來刪除書";
    _CoreData = [[CoreDataModel alloc] init];
    _UserListArray = [_CoreData FetchBookObjInCoreData];
    
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
    
    cell.textLabel.text = [_UserListArray[indexPath.row] valueForKey:BOOK_DATA_KEY_TITLE];
    
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確定刪除嗎" message:@"此動作將會刪除所有分館的 copy" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"OK", nil];
    alert.tag = indexPath.row;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"index = %d", buttonIndex);
    if(buttonIndex == 1) {
        [_CoreData deleteBookWithBookObj:_UserListArray[alertView.tag]];
        [self.navigationController  popToRootViewControllerAnimated:YES];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
