//
//  Book.h
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/25/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEFAULT_STR @"default"

#define BRANCH_ID_1   @"TPEL01"
#define BRANCH_ID_2   @"TPEL02"
#define BRANCH_ID_3   @"TPEL03"
#define BRANCH_ID_4   @"TPEL04"
#define BRANCH_ID_5   @"TPEL05"
#define BRANCH_ID_6   @"TPEL06"

#define BOOK_DATA_KEY_BORROWER      @"borrower"
#define BOOK_DATA_KEY_AUTHOR        @"author"
#define BOOK_DATA_KEY_BRANCH        @"branch"
#define BOOK_DATA_KEY_IN_STOCK      @"isInStock"
#define BOOK_DATA_KEY_PUBLISHER     @"publisher"
#define BOOK_DATA_KEY_GUID          @"guid"
#define BOOK_DATA_KEY_ID            @"id" //ISBN
#define BOOK_DATA_KEY_TITLE         @"title"
#define BOOK_DATA_KEY_OUT_DATE      @"outDate"
#define BOOK_DATA_KEY_DUE_DATE      @"dueDate"

@interface Book : NSObject
-(Book*) init;

@property (strong, nonatomic) NSString *GUID;
@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *Title;
@property (strong, nonatomic) NSString *Author;
@property (strong, nonatomic) NSString *Publisher;
@property (strong, nonatomic) NSString *Branch;
@property (strong, nonatomic) NSString *BorrowerID; // CardID
@property (strong, nonatomic) NSDate   *OutDate;
@property (strong, nonatomic) NSDate   *DueDate;
@property BOOL isInStock;
@end
