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
#define CORE_DATA_LOANRECORD_ENTITY      @"LoanRecord"

@class User;
@class Book;

@interface CoreDataModel : NSObject
@property (nonatomic, strong)   NSManagedObjectContext  *context;

@property (strong, nonatomic) User *UserObj;
@property (strong, nonatomic) Book *BookObj;

-(CoreDataModel*) init;
-(BOOL) SaveIntoCoreDataWithObj : (User*) CoreDataObj;
-(NSMutableArray*) FetchObjInCoreData;

-(BOOL) SaveBookIntoCoreDataWithObj : (Book*) CoreDataObj;
-(NSMutableArray*) FetchBookObjInCoreData;
-(NSMutableArray*) FetchLoanRecord;



- (BOOL) deleteBookWithBookObj:(NSManagedObject*)CoreDataObj;
- (BOOL) UpdateAuthor : (NSString*) Author WithBookID : (NSString*) BookIdStr;
-(NSArray*) CoreDataSearchWithBookID : (NSString *) BookID;
-(BOOL) SaveLoanRecordIntoCoreDataWithLoanRecord : (NSDictionary*) LoanRecord;

-(NSArray*) CoreDataSearchinBranchWithString : (NSString *) SearchString;
-(void) deleteDefaultObj;

// not use
- (BOOL) LoanBookWithIDStr:(NSString*) BookID
                 inBranch : (NSString*) BranchID
              byStartDate : (NSDate*) OutDate
               andDueDate : (NSDate*) DueDate
                forUserID : (NSString*) UserID;

@end
