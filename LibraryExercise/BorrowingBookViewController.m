//
//  BorrowingBookViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/27/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "BorrowingBookViewController.h"
#import "BookInfoViewController.h"
@interface BorrowingBookViewController ()

@end

@implementation BorrowingBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _CoreData = [[CoreDataModel alloc] init];
    _SearchResult.delegate = self;
    _SearchResult.dataSource = self;
    _SearchResult.backgroundColor = [UIColor clearColor];
    
    [_SearchBtn addTarget:self action:@selector(SearchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    NSInteger Rows = 0;
    switch (section) {
        case 0:
            Rows = [_BookIDSearchResultArray count];
            break;
        case 1:
            Rows = [_BookNameSearchResultArray count];
            break;
        case 2:
            Rows = [_AuthorNameSearchResultArray count];
            break;
        case 3:
            Rows = [_PublisherNameSearchResultArray count];
            break;
        default:
            break;
    }
    
    return Rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *SectionString;
    switch (section) {
        case 0:
            SectionString = @"BookID";
            break;
        case 1:
            SectionString = @"BookName";
            break;
        case 2:
            SectionString = @"Author";
            break;
        case 3:
            SectionString = @"Publisher";
            break;
        default:
            break;
    }
    
    return SectionString;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [[_BookIDSearchResultArray objectAtIndex:indexPath.row] valueForKey:BOOK_DATA_KEY_TITLE];
            cell.detailTextLabel.text = [[_BookIDSearchResultArray objectAtIndex:indexPath.row] valueForKey:BOOK_DATA_KEY_ID];
            break;
        case 1:
            cell.textLabel.text = [[_BookNameSearchResultArray objectAtIndex:indexPath.row] valueForKey:BOOK_DATA_KEY_TITLE];
            cell.detailTextLabel.text = [[_BookNameSearchResultArray objectAtIndex:indexPath.row] valueForKey:BOOK_DATA_KEY_AUTHOR];
            break;
        case 2:
            cell.textLabel.text = [[_AuthorNameSearchResultArray objectAtIndex:indexPath.row] valueForKey:BOOK_DATA_KEY_TITLE];
            cell.detailTextLabel.text = [[_AuthorNameSearchResultArray objectAtIndex:indexPath.row] valueForKey:BOOK_DATA_KEY_AUTHOR];
            break;
        case 3:
            cell.textLabel.text = [[_PublisherNameSearchResultArray objectAtIndex:indexPath.row] valueForKey:BOOK_DATA_KEY_TITLE];
            cell.detailTextLabel.text = [[_PublisherNameSearchResultArray objectAtIndex:indexPath.row] valueForKey:BOOK_DATA_KEY_PUBLISHER];
            break;
        default:
            break;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select indexpath = %d - %d", indexPath.section, indexPath.row);
    NSManagedObject *BookObj;
    
    switch (indexPath.section) {
        case 0:
            BookObj = [_BookIDSearchResultArray objectAtIndex:indexPath.row];
            break;
        case 1:
            BookObj = [_BookNameSearchResultArray objectAtIndex:indexPath.row];
            break;
        case 2:
            BookObj = [_AuthorNameSearchResultArray objectAtIndex:indexPath.row];
            break;
        case 3:
            BookObj = [_PublisherNameSearchResultArray objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    [self performSegueWithIdentifier:@"BookInfo" sender:BookObj];

}

-(void) SearchBtnClicked
{
    // TODO: search the text in search text field
    
    
    _BookIDSearchResultArray = [_CoreData CoreDataSearchWithBookID:_SearchTextField.text];
    _BookNameSearchResultArray = [_CoreData CoreDataSearchWithBookName:_SearchTextField.text];
    _AuthorNameSearchResultArray = [_CoreData CoreDataSearchWithAuthorName:_SearchTextField.text];
    _PublisherNameSearchResultArray = [_CoreData CoreDataSearchWithPublisherName:_SearchTextField.text];
        
    [_SearchResult reloadData];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"BookInfo"]) {
        // Get destination view
        BookInfoViewController *vc = [segue destinationViewController];
        vc.BookID = [sender valueForKey:BOOK_DATA_KEY_ID];
        vc.UserID = _Borrowing_UserID;
    }
}



@end
