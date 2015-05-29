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
}

@end

@implementation BookInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _CoreData = [[CoreDataModel alloc] init];
    if (_BookID) {
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
    
    if (CopyCount > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確定要借書了嗎～？" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert show];

    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"沒有書了唷" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
    
}

-(NSInteger) GetInStockWithBranchArray : (id)BookBranchCopiesArray
{
    NSInteger Count = 0;
    for (NSDictionary *BookCopies in BookBranchCopiesArray) {
        if ([[BookCopies valueForKey:BOOK_DATA_KEY_IN_STOCK] boolValue]) {
            Count++;
        }
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
