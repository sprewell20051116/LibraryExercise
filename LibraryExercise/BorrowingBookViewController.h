//
//  BorrowingBookViewController.h
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/27/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataModel.h"
@interface BorrowingBookViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *SearchTextField;
@property (strong, nonatomic) IBOutlet UIButton *SearchBtn;
@property (strong, nonatomic) CoreDataModel *CoreData;
@property (strong, nonatomic) IBOutlet UITableView *SearchResult;
@property (strong, nonatomic) NSString *Borrowing_UserID;

@property (strong, nonatomic) NSArray *BookNameSearchResultArray;
@property (strong, nonatomic) NSArray *BookIDSearchResultArray;
@property (strong, nonatomic) NSArray *AuthorNameSearchResultArray;
@property (strong, nonatomic) NSArray *PublisherNameSearchResultArray;
@end
