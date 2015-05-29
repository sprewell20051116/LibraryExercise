//
//  CoreDataModel.h
//  wayTruthLife
//
//  Created by CHIN-KANG CHANG on 3/6/15.
//  Copyright (c) 2015 hippocolors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "User.h"
#import "Book.h"

#define CORE_DATA_ENTITY                 @"Users"
#define CORE_DATA_BOOK_ENTITY            @"Books"
#define CORE_DATA_BOOK_COPIES_ENTITY     @"BooksCopies"
#define CORE_DATA_LOANRECORD_ENTITY      @"LoanRecord"
#define CORE_DATA_BRANCH_ENTITY          @"Branch"

// Branch attr
#define CORE_DATA_BRANCH_ID_ATTR          @"branchId"
#define CORE_DATA_BRANCH_ADDR_ATTR        @"branchAddr"
#define CORE_DATA_BRANCH_NAME_ATTR        @"branchName"

@class User;
@class Book;

@interface CoreDataModel : NSObject
@property (nonatomic, strong)   NSManagedObjectContext  *context;

@property (strong, nonatomic) User *UserObj;
@property (strong, nonatomic) Book *BookObj;

-(CoreDataModel*) init;
-(BOOL) SaveIntoCoreDataWithObj : (User*) CoreDataObj;
-(NSMutableArray*) FetchObjInCoreData;
-(NSArray*) CoreDataSearchUserWithName : (NSString *) Name;
-(NSArray*) CoreDataSearchUserWithCardID : (NSString *) CardID;


-(BOOL) SaveBookIntoCoreDataWithObj : (Book*) CoreDataObj;
-(BOOL) SaveBookCopiesIntoCoreDataWithObj : (Book*) CoreDataObj;
-(BOOL) SaveBranchIntoCoreDataWithObj : (NSDictionary*) Branch;

-(NSMutableArray*) FetchBookObjInCoreData;
-(NSMutableArray*) FetchLoanRecord;
-(NSMutableArray*) FetchBranchObjInCoreData;



- (BOOL) deleteBookWithBookObj:(NSManagedObject*)CoreDataObj;
- (BOOL) UpdateAuthor : (NSString*) Author WithBookID : (NSString*) BookIdStr;
-(NSArray*) CoreDataSearchWithBookID : (NSString *) BookID;
-(BOOL) SaveLoanRecordIntoCoreDataWithLoanRecord : (NSDictionary*) LoanRecord;

-(NSArray*) CoreDataSearchinBranchWithString : (NSString *) SearchString;
-(void) deleteDefaultObj;

-(NSArray*) CoreDataSearchLoanListWithUserID : (NSString *) UserID;
-(NSArray*) CoreDataSearchWithPublisherName : (NSString *) PublisherName;
-(NSArray*) CoreDataSearchWithBookName : (NSString *) BookName;
-(NSArray*) CoreDataSearchWithAuthorName : (NSString *) AuthorName;
-(NSArray*) CoreDataSearchinCopiesWithString : (NSString *) SearchString;
-(NSArray*) CoreDataSearchinCopiesWithBookID : (NSString *) SearchString WithBranchID : (NSString*) BranchID;


// not use
- (BOOL) LoanBookWithIDStr:(NSString*) BookID
                 inBranch : (NSString*) BranchID
              byStartDate : (NSDate*) OutDate
               andDueDate : (NSDate*) DueDate
                forUserID : (NSString*) UserID;

@end
