//
//  BookInfoViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/27/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "BookInfoViewController.h"
#import "CoreDataModel.h"
#import "BookInfoTableViewCell.h"

@interface BookInfoViewController () {
    CoreDataModel *_CoreData;
    NSArray       *_BookCopiesArray;
    NSArray       *_BranchArray;
    NSMutableArray *_GUIDArray; //saving the guid array
    NSManagedObject *_MoveBranchBookObj;
}

@end

@implementation BookInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _CoreData = [[CoreDataModel alloc] init];
    
    if (_MoveBranchMode) {
        self.title = @"點擊分館以搬動書籍";
    } else {
        self.title = @"書籍資料";
    }
    
    if (_BookID) {
        _GUIDArray = [[NSMutableArray alloc] initWithArray:@[DEFAULT_STR, DEFAULT_STR, DEFAULT_STR, DEFAULT_STR, DEFAULT_STR]];
        _BookCopiesArray = [_CoreData CoreDataSearchinCopiesWithString:_BookID];
        _BranchArray = [_CoreData FetchBranchObjInCoreData];
        NSLog(@"%s -- %d", __PRETTY_FUNCTION__, [_BookCopiesArray count]);

        [self init_InfoView];
        [self init_TableView];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger) GetTableCount
{
    NSUInteger Count = 0;
    return Count;
}

-(void)init_InfoView
{
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"UserInfoView"
                                                      owner:self
                                                    options:nil];
    
    _InfoView = (UserInfoView*)[nibViews objectAtIndex:0];
    CGRect Frame = _InfoView.frame;
    Frame.origin.y = 44.0f + 20.0f;
    Frame.size.height = 200;
    [_InfoView setFrame:Frame];
    [_InfoView.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [_InfoView.layer setShadowOffset:CGSizeMake(1,8)];
    [_InfoView.layer setShadowOpacity:0.5f];

    _InfoView.NameLab.text = [[[_CoreData CoreDataSearchWithBookID:_BookID] firstObject] valueForKey:BOOK_DATA_KEY_TITLE];
    _InfoView.CardIDLab.text = _BookID;
    [_InfoView.BorrowBrn setHidden:YES];
    [_InfoView.MobilePhoneLab setHidden:YES];
    [_InfoView.AddressLab setHidden:YES];
    
    [self.view addSubview:_InfoView];
}

-(void) init_TableView
{
    _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                               200,
                                                               self.view.frame.size.width,
                                                               self.view.frame.size.height - 200 - 44)];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    [self.view insertSubview:_TableView belowSubview:_InfoView];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *BookInfoTableViewCellID = @"BookInfoTableViewCell";
    
    BookInfoTableViewCell *cell = (BookInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:BookInfoTableViewCellID];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookInfoTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.BanchIdLab.text = [_BranchArray[indexPath.row] valueForKey:CORE_DATA_BRANCH_ID_ATTR];
    cell.BranchNameLab.text = [_BranchArray[indexPath.row] valueForKey:CORE_DATA_BRANCH_NAME_ATTR];
    cell.AddrLab.text = [_BranchArray[indexPath.row] valueForKey:CORE_DATA_BRANCH_ADDR_ATTR];
//    cell.CopiesLab.text = ;
    NSInteger CopyCount = [self GetInStockWithBranchArray:[_CoreData CoreDataSearchinCopiesWithBookID:_BookID WithBranchID:[self GetBranchIdWithRowNumber:indexPath.row]]];
    cell.CopiesLab.text = [NSString stringWithFormat:@"%02d", CopyCount];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger CopyCount = [self GetInStockWithBranchArray:[_CoreData CoreDataSearchinCopiesWithBookID:_BookID WithBranchID:[self GetBranchIdWithRowNumber:indexPath.row]]];

    
    if (_MoveBranchMode) {
        
        if (CopyCount > 0) {
            
            //show the app menu
            [[[UIActionSheet alloc] initWithTitle:@"搬動一本書至哪個分館"
                                         delegate:self
                                cancelButtonTitle:@"Cancel"
                           destructiveButtonTitle:nil
                                otherButtonTitles:@"台北巿立圖書館總館", @"台北巿立圖書館中正分館", @"台北巿立圖書館中山分館", @"台北巿立圖書館松山分館", @"台北巿立圖書館文山分館", @"台北巿立圖書館內湖分館", nil]
             showInView:self.view];
            _MoveBranchBookObj = [[_CoreData CoreDataSearchinCopiesWithBookID:_BookID WithBranchID:[self GetBranchIdWithRowNumber:indexPath.row]] firstObject];
            
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"沒有書可以搬動喔～" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 100;
            [alert show];
            
        }
        
        
    } else {
        
        if (CopyCount > 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確定要借書了嗎～？" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            alert.tag = indexPath.row;
            [alert show];
            
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"沒有書了唷" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 100;
            [alert show];
            
        }
        
    }
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%s, index = %d", __PRETTY_FUNCTION__, buttonIndex);
    [_CoreData UpdateBookCopyWithBookObj:_MoveBranchBookObj forNewBranch:[self GetBranchIdWithRowNumber:buttonIndex]];
    [_TableView reloadData];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag != 100) {
        if (buttonIndex == 0) {
            NSLog(@"TODO save to record and set isInStock as NO");
            
            NSDateFormatter *formatter;
            NSString        *dateString, *DueDateString;
            
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd"];
            
            dateString = [formatter stringFromDate:[NSDate date]];
            
            NSDate *DueDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 30];
            DueDateString = [formatter stringFromDate:DueDate];
            NSDictionary *RecordDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       _UserID, @"CardNo",
                                       [self GetBranchIdWithRowNumber:alertView.tag], @"BranchId",
                                       _BookID, @"BookId",
                                       dateString, @"outDate",
                                       DueDateString, @"dueDate", nil];
            NSLog(@"RecordDic = %@", RecordDic);
            
            // Get the first in stock book guid of the branch
            NSString *GuidStr = _GUIDArray[alertView.tag];
            NSLog(@"GuidStr = %@", GuidStr);
            [_CoreData UpdateBookCopyIsInStockWithBookGUID:GuidStr byIsInStockFlag:NO andRecordDictionary:RecordDic];
            [_CoreData SaveLoanRecordIntoCoreDataWithLoanRecord:RecordDic];
            
            [self.navigationController  popToRootViewControllerAnimated:YES];
        }
    }
}



-(NSInteger) GetInStockWithBranchArray : (id)BookBranchCopiesArray
{
    NSInteger Count = 0;
    NSInteger Index = 0;
    for (NSDictionary *BookCopies in BookBranchCopiesArray) {
        if ([[BookCopies valueForKey:BOOK_DATA_KEY_IN_STOCK] boolValue]) {
            [_GUIDArray replaceObjectAtIndex:Index withObject:[BookCopies valueForKey:BOOK_DATA_KEY_GUID]];
            Count++;
        }
        Index ++;
    }
    return Count;
}

-(NSString*) GetBranchIdWithRowNumber : (NSInteger) row
{

    switch (row) {
        case 0:
            return BRANCH_ID_1;
            break;
        case 1:
            return BRANCH_ID_2;
            break;
        case 2:
            return BRANCH_ID_3;
            break;
        case 3:
            return BRANCH_ID_4;
            break;
        case 4:
            return BRANCH_ID_5;
            break;
        case 5:
            return BRANCH_ID_6;
            break;
            
        default:
            break;
    }
    return DEFAULT_STR;
}

-(void) LogoutBtnClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void) BorrowBtnClicked:(id)sender
{
    [self performSegueWithIdentifier:@"BorrowingBook" sender:sender];
    
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
