//
//  UserViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/26/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserViewController.h"
#import "UserNavViewController.h"
#import "BorrowingBookViewController.h"

@interface UserViewController () {
    NSArray *_LoanListData;
    NSManagedObject *_UserObj;
}

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s name = %@", __PRETTY_FUNCTION__, _UserName);
    // Do any additional setup after loading the view.
    
    _CoreData = [[CoreDataModel alloc] init];
    
    _UserObj = [[_CoreData CoreDataSearchUserWithName:_UserName] firstObject];
    _LoanListData = [_CoreData CoreDataSearchLoanListWithUserID:[_UserObj valueForKey:USER_CORE_DATA_CARDID]];
    if ([_LoanListData count] != 0) {
        [self init_UserLoanTableView];
    } 
    
    [self init_UserInfoSubView];

    [_LogoutBtn setTarget:self];
    [_LogoutBtn setAction:@selector(LogoutBtnClicked)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super viewDidAppear:animated];
    _LoanListData = [_CoreData CoreDataSearchLoanListWithUserID:[_UserObj valueForKey:USER_CORE_DATA_CARDID]];
    //if ([_LoanListData count] != 0) {
    [_UserLoanTableView reloadData];
    //}

}

-(void) reloadList
{
    _LoanListData = [_CoreData CoreDataSearchLoanListWithUserID:[_UserObj valueForKey:USER_CORE_DATA_CARDID]];
    //if ([_LoanListData count] != 0) {
    [_UserLoanTableView reloadData];
}

-(void) init_UserInfoSubView
{
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"UserInfoView"
                                                      owner:self
                                                    options:nil];
    
    _UserInfoSubView = (UserInfoView*)[nibViews objectAtIndex:0];
    CGRect Frame = _UserInfoSubView.frame;
    Frame.origin.y = 44.0f + 20.0f;
    [_UserInfoSubView setFrame:Frame];
    [_UserInfoSubView.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [_UserInfoSubView.layer setShadowOffset:CGSizeMake(1,8)];
    [_UserInfoSubView.layer setShadowOpacity:0.5f];
    
    
    _UserInfoSubView.NameLab.text = _UserName;
    _UserInfoSubView.CardIDLab.text =  [_UserObj valueForKey:USER_CORE_DATA_CARDID];
    _UserInfoSubView.MobilePhoneLab.text = [_UserObj valueForKey:USER_CORE_DATA_MOBILE];
    _UserInfoSubView.AddressLab.text = [_UserObj valueForKey:USER_CORE_DATA_ADDR];
    [_UserInfoSubView.BorrowBrn addTarget:self action:@selector(BorrowBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_UserInfoSubView];
}

-(void) init_UserLoanTableView
{
    _UserLoanTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250 + 44 + 20, self.view.frame.size.width, self.view.frame.size.height - 250 - 44 - 20)];
    _UserLoanTableView.delegate = self;
    _UserLoanTableView.dataSource = self;
    //[_UserLoanTableView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_UserLoanTableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_LoanListData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     
     static NSString *CellIdentifier = @"Cell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     BOOL NotHandle = YES;
     // Configure the cell...
     if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
     }
     NSManagedObject *LoanObj = [_LoanListData objectAtIndex:indexPath.row];
     if ([[LoanObj valueForKey:@"bookGuid"] isEqualToString:DEFAULT_STR]) {
         // not handle, because this is already given back
         
     } else {
         NotHandle = NO;
     }
     
     
     NSManagedObject *BookCopyObj;
     if (NotHandle) {
         BookCopyObj = [[_CoreData CoreDataSearchWithBookID:[LoanObj valueForKey:@"bookId"]] firstObject];

     } else {
         BookCopyObj = [[_CoreData CoreDataSearchinCopiesWithGUIDString:[LoanObj valueForKey:@"bookGuid"]] firstObject];
     }
     
     cell.textLabel.text = [BookCopyObj valueForKey:BOOK_DATA_KEY_TITLE];

     BOOL isInStock = [[BookCopyObj valueForKey:BOOK_DATA_KEY_IN_STOCK] boolValue];
     if (isInStock) {
         
         NSString *SubtitleStr = [NSString stringWithFormat:@"分館 : %@ | 已還書", [LoanObj valueForKey:@"branch"]];
         cell.detailTextLabel.text = SubtitleStr;
         [cell.textLabel setTextColor:[UIColor blackColor]];

         
     } else {
         
         [cell.textLabel setTextColor:[UIColor redColor]];
         NSDateFormatter *formatter;
         NSString        *DueDateString;
         NSDate *DueDate = [BookCopyObj valueForKey:BOOK_DATA_KEY_DUE_DATE];
         formatter = [[NSDateFormatter alloc] init];
         [formatter setDateFormat:@"yyyy/MM/dd"];
         
         DueDateString = [formatter stringFromDate:DueDate];
         
         NSString *SubtitleStr = [NSString stringWithFormat:@"分館 : %@ | 到期日 : %@", [LoanObj valueForKey:@"branch"], DueDateString];
         cell.detailTextLabel.text = SubtitleStr;

     }
     [cell.textLabel setFont:[UIFont systemFontOfSize:30.0f]];
     
 return cell;
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSManagedObject *LoanObj = [_LoanListData objectAtIndex:indexPath.row];
    NSManagedObject *BookCopyObj;
    
    
    if ([[LoanObj valueForKey:@"bookGuid"] isEqualToString:DEFAULT_STR]) {
        // not handle, because this is already given back
        
    } else {
        BookCopyObj = [[_CoreData CoreDataSearchinCopiesWithGUIDString:[LoanObj valueForKey:@"bookGuid"]] firstObject];
        if ([[BookCopyObj valueForKey:BOOK_DATA_KEY_IN_STOCK] boolValue]) {
            
            // not handle
        } else {
            
            NSDictionary *RecordDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       [LoanObj valueForKey:@"userID"], @"CardNo",
                                       [LoanObj valueForKey:@"branch"], @"BranchId",
                                       [LoanObj valueForKey:@"bookId"], @"BookId",
                                       [LoanObj valueForKey:@"outDate"], @"outDate",
                                       [LoanObj valueForKey:@"dueDate"], @"dueDate",
                                       [LoanObj valueForKey:@"bookGuid"], @"bookGuid" ,nil];
            NSLog(@"RecordDic = %@", RecordDic);
            
            [_CoreData UpdateBookCopyIsInStockWithBookGUID:[LoanObj valueForKey:@"bookGuid"] byIsInStockFlag:YES andRecordDictionary:RecordDic];
            [_UserLoanTableView reloadData];
        }
        
    }
    

}

-(void) LogoutBtnClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void) BorrowBtnClicked:(id)sender
{
    [self performSegueWithIdentifier:@"BorrowingBook" sender:sender];

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"BorrowingBook"]) {
        
        // Get destination view
        BorrowingBookViewController *vc = [segue destinationViewController];
        vc.Borrowing_UserID = [_UserObj valueForKey:USER_CORE_DATA_CARDID];
        vc.MoveBranchMode = NO;
    }
}


@end
