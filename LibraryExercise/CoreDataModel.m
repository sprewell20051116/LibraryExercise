//
//  CoreDataModel.m
//  wayTruthLife
//
//  Created by CHIN-KANG CHANG on 3/6/15.
//  Copyright (c) 2015 hippocolors. All rights reserved.
//

#import "CoreDataModel.h"

@implementation CoreDataModel

-(CoreDataModel*) init
{
    self = [super init];
    if ( self ) {
        AppDelegate *theAppDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
        _context = [theAppDelegate managedObjectContext];
    }
    return self;
}


#pragma mark - Save User Object
-(BOOL) SaveIntoCoreDataWithObj : (User*) CoreDataObj
{
    
    NSString *CoreDataEntityName = CORE_DATA_ENTITY;
    NSManagedObject *NewObj = [NSEntityDescription insertNewObjectForEntityForName:CoreDataEntityName inManagedObjectContext:_context];
    
    if (CoreDataObj == nil) {
        return NO;
    }
    
    [NewObj setValue:CoreDataObj.UserName forKey:@"userName"];
    [NewObj setValue:CoreDataObj.Password forKey:@"password"];
    [NewObj setValue:CoreDataObj.Address forKey:@"address"];
    [NewObj setValue:CoreDataObj.CardId forKey:@"cardId"];
    [NewObj setValue:CoreDataObj.Phone forKey:@"mobile"];
    [NewObj setValue:CoreDataObj.Book1.GUID forKey:@"bookid1"];
    [NewObj setValue:CoreDataObj.Book2.GUID forKey:@"bookid2"];
    [NewObj setValue:CoreDataObj.Book3.GUID forKey:@"bookid3"];
    [NewObj setValue:CoreDataObj.Book4.GUID forKey:@"bookid4"];
    [NewObj setValue:CoreDataObj.Book5.GUID forKey:@"bookid5"];
    
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    return YES;
}



#pragma mark - Save User Object
-(BOOL) SaveBranchIntoCoreDataWithObj : (NSDictionary*) Branch
{
    
    NSString *CoreDataEntityName = CORE_DATA_BRANCH_ENTITY;
    NSManagedObject *NewObj = [NSEntityDescription insertNewObjectForEntityForName:CoreDataEntityName inManagedObjectContext:_context];
    
    if (Branch == nil) {
        return NO;
    }
    
    [NewObj setValue:[Branch valueForKey:@"BranchId"] forKey:CORE_DATA_BRANCH_ID_ATTR];
    [NewObj setValue:[Branch valueForKey:@"Address"] forKey:CORE_DATA_BRANCH_ADDR_ATTR];
    [NewObj setValue:[Branch valueForKey:@"BranchName"] forKey:CORE_DATA_BRANCH_NAME_ATTR];
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    return YES;
}



#pragma mark - Save Book Object
-(BOOL) SaveBookIntoCoreDataWithObj : (Book*) CoreDataObj
{
    
    NSString *CoreDataEntityName = CORE_DATA_BOOK_ENTITY;
    NSManagedObject *NewObj = [NSEntityDescription insertNewObjectForEntityForName:CoreDataEntityName inManagedObjectContext:_context];
    
    if (CoreDataObj == nil) {
        return NO;
    }
    [NewObj setValue:CoreDataObj.GUID forKey:BOOK_DATA_KEY_GUID];
    [NewObj setValue:CoreDataObj.Title forKey:BOOK_DATA_KEY_TITLE];
    [NewObj setValue:CoreDataObj.Id forKey:BOOK_DATA_KEY_ID];
    [NewObj setValue:CoreDataObj.Author forKey:BOOK_DATA_KEY_AUTHOR];
    [NewObj setValue:CoreDataObj.Publisher forKey:BOOK_DATA_KEY_PUBLISHER];
    [NewObj setValue:CoreDataObj.Branch forKey:BOOK_DATA_KEY_BRANCH];
    //[NewObj setValue:CoreDataObj.BorrowerID forKey:BOOK_DATA_KEY_BORROWER];
    //[NewObj setValue:CoreDataObj.OutDate forKey:BOOK_DATA_KEY_OUT_DATE];
    //[NewObj setValue:CoreDataObj.DueDate forKey:BOOK_DATA_KEY_DUE_DATE];
    [NewObj setValue:[NSNumber numberWithBool:CoreDataObj.isInStock] forKey:BOOK_DATA_KEY_IN_STOCK];

    
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    return YES;
}


-(BOOL) SaveBookCopiesIntoCoreDataWithObj : (Book*) CoreDataObj
{
    
    NSString *CoreDataEntityName = CORE_DATA_BOOK_COPIES_ENTITY;
    NSManagedObject *NewObj = [NSEntityDescription insertNewObjectForEntityForName:CoreDataEntityName inManagedObjectContext:_context];
    
    if (CoreDataObj == nil) {
        return NO;
    }
    [NewObj setValue:CoreDataObj.GUID forKey:BOOK_DATA_KEY_GUID];
    [NewObj setValue:CoreDataObj.Title forKey:BOOK_DATA_KEY_TITLE];
    [NewObj setValue:CoreDataObj.Id forKey:BOOK_DATA_KEY_ID];
    [NewObj setValue:CoreDataObj.Author forKey:BOOK_DATA_KEY_AUTHOR];
    [NewObj setValue:CoreDataObj.Publisher forKey:BOOK_DATA_KEY_PUBLISHER];
    [NewObj setValue:CoreDataObj.Branch forKey:BOOK_DATA_KEY_BRANCH];
    //[NewObj setValue:CoreDataObj.BorrowerID forKey:BOOK_DATA_KEY_BORROWER];
    //[NewObj setValue:CoreDataObj.OutDate forKey:BOOK_DATA_KEY_OUT_DATE];
    //[NewObj setValue:CoreDataObj.DueDate forKey:BOOK_DATA_KEY_DUE_DATE];
    [NewObj setValue:[NSNumber numberWithBool:CoreDataObj.isInStock] forKey:BOOK_DATA_KEY_IN_STOCK];
    
    
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    return YES;
}


- (BOOL) UpdateAuthor : (NSString*) Author WithBookID : (NSString*) BookIdStr
{
    NSManagedObject *BookObj = [[self CoreDataSearchWithBookID:BookIdStr] firstObject];
    NSLog(@"BookObj = %@", [BookObj valueForKey:BOOK_DATA_KEY_TITLE]);
    [BookObj setValue:Author forKey:BOOK_DATA_KEY_AUTHOR];
    
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    return YES;

}


#pragma mark - Save Loan record
-(BOOL) SaveLoanRecordIntoCoreDataWithLoanRecord : (NSDictionary*) LoanRecord
{
    
    NSString *CoreDataEntityName = CORE_DATA_LOANRECORD_ENTITY;
    NSManagedObject *NewObj = [NSEntityDescription insertNewObjectForEntityForName:CoreDataEntityName inManagedObjectContext:_context];
    
    if (LoanRecord == nil) {
        return NO;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //    [formatter setDateFormat:@"MM/dd/yyyy HH:mm a"];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    
    NSDate *OutDate = [formatter dateFromString:[LoanRecord valueForKey:@"DateOut"]];
    NSDate *DueDate = [formatter dateFromString:[LoanRecord valueForKey:@"DueDate"]];

    [NewObj setValue:[LoanRecord valueForKey:@"CardNo"] forKey:@"userID"];
    [NewObj setValue:[LoanRecord valueForKey:@"BookId"] forKey:@"bookId"];
    [NewObj setValue:[LoanRecord valueForKey:@"BranchId"] forKey:@"branch"];
    [NewObj setValue:DueDate forKey:@"dueDate"];
    [NewObj setValue:OutDate forKey:@"outDate"];
    
    
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    return YES;
}



#pragma mark - Fetch User Object
-(NSMutableArray*) FetchObjInCoreData
{
    NSMutableArray *CoreDataArray = [[NSMutableArray alloc] init];
    NSString *CoreDataEntityName;
    CoreDataEntityName = CORE_DATA_ENTITY;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:CoreDataEntityName];
    CoreDataArray = [[_context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    return CoreDataArray;
    
}


#pragma mark - Fetch Book Object
-(NSMutableArray*) FetchBookObjInCoreData
{
    NSMutableArray *CoreDataArray = [[NSMutableArray alloc] init];
    NSString *CoreDataEntityName;
    CoreDataEntityName = CORE_DATA_BOOK_ENTITY;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:CoreDataEntityName];
    CoreDataArray = [[_context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    return CoreDataArray;
    
}


#pragma mark - Fetch branch Object
-(NSMutableArray*) FetchBranchObjInCoreData
{
    NSMutableArray *CoreDataArray = [[NSMutableArray alloc] init];
    NSString *CoreDataEntityName;
    CoreDataEntityName = CORE_DATA_BRANCH_ENTITY;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:CoreDataEntityName];
    CoreDataArray = [[_context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    return CoreDataArray;
    
}




#pragma mark - Fetch LoanRocord Object
-(NSMutableArray*) FetchLoanRecord
{
    NSMutableArray *CoreDataArray = [[NSMutableArray alloc] init];
    NSString *CoreDataEntityName;
    CoreDataEntityName = CORE_DATA_LOANRECORD_ENTITY;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:CoreDataEntityName];
    CoreDataArray = [[_context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    return CoreDataArray;
    
}



#pragma mark - Delete Book Object
- (BOOL)deleteBookWithBookObj:(NSManagedObject*)CoreDataObj
{
    [_context deleteObject:CoreDataObj];
    
    NSError *error = nil;
    
    if (![_context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    
    return YES;
    
}


#pragma mark - Search User Object
-(NSArray*) CoreDataSearchUserWithName : (NSString *) Name
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSString *BookCoreDataEntityName = CORE_DATA_ENTITY;
    
    // NSSortDescriptor tells defines how to sort the fetched results
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"userName" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // fetchRequest needs to know what entity to fetch
    NSEntityDescription *entity = [NSEntityDescription entityForName:BookCoreDataEntityName inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    
    NSFetchedResultsController  *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_context sectionNameKeyPath:nil cacheName:@"Root"];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"userName = %@", Name];
    
    [fetchedResultsController.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    return fetchedResultsController.fetchedObjects;
    
}


-(NSArray*) CoreDataSearchUserWithCardID : (NSString *) CardID
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSString *BookCoreDataEntityName = CORE_DATA_ENTITY;
    
    // NSSortDescriptor tells defines how to sort the fetched results
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:USER_CORE_DATA_CARDID ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // fetchRequest needs to know what entity to fetch
    NSEntityDescription *entity = [NSEntityDescription entityForName:BookCoreDataEntityName inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    
    NSFetchedResultsController  *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_context sectionNameKeyPath:nil cacheName:@"Root"];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"cardId = %@", CardID];
    
    [fetchedResultsController.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    return fetchedResultsController.fetchedObjects;
    
}


#pragma mark - Get Loan list with user id
-(NSArray*) CoreDataSearchLoanListWithUserID : (NSString *) UserID
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSString *BookCoreDataEntityName = CORE_DATA_LOANRECORD_ENTITY;
    
    // NSSortDescriptor tells defines how to sort the fetched results
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"userID" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // fetchRequest needs to know what entity to fetch
    NSEntityDescription *entity = [NSEntityDescription entityForName:BookCoreDataEntityName inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    
    NSFetchedResultsController  *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_context sectionNameKeyPath:nil cacheName:@"Root"];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"userID = %@", UserID];
    
    [fetchedResultsController.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    return fetchedResultsController.fetchedObjects;
    
}



#pragma mark - Search Book Object
-(NSArray*) CoreDataSearchWithBookID : (NSString *) BookID
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSString *BookCoreDataEntityName = CORE_DATA_BOOK_ENTITY;
    
    // NSSortDescriptor tells defines how to sort the fetched results
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:BOOK_DATA_KEY_ID ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // fetchRequest needs to know what entity to fetch
    NSEntityDescription *entity = [NSEntityDescription entityForName:BookCoreDataEntityName inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    
    NSFetchedResultsController  *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_context sectionNameKeyPath:nil cacheName:@"Root"];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"id contains[cd] %@", BookID];
    
    [fetchedResultsController.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    return fetchedResultsController.fetchedObjects;
    
}


-(NSArray*) CoreDataSearchWithBookName : (NSString *) BookName
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSString *BookCoreDataEntityName = CORE_DATA_BOOK_ENTITY;
    
    // NSSortDescriptor tells defines how to sort the fetched results
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:BOOK_DATA_KEY_TITLE ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // fetchRequest needs to know what entity to fetch
    NSEntityDescription *entity = [NSEntityDescription entityForName:BookCoreDataEntityName inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    
    NSFetchedResultsController  *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_context sectionNameKeyPath:nil cacheName:@"Root"];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"title contains[cd] %@", BookName];
    
    [fetchedResultsController.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    return fetchedResultsController.fetchedObjects;
    
}



-(NSArray*) CoreDataSearchWithPublisherName : (NSString *) PublisherName
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSString *BookCoreDataEntityName = CORE_DATA_BOOK_ENTITY;
    
    // NSSortDescriptor tells defines how to sort the fetched results
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:BOOK_DATA_KEY_PUBLISHER ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // fetchRequest needs to know what entity to fetch
    NSEntityDescription *entity = [NSEntityDescription entityForName:BookCoreDataEntityName inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    
    NSFetchedResultsController  *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_context sectionNameKeyPath:nil cacheName:@"Root"];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"publisher contains[cd] %@", PublisherName];
    
    [fetchedResultsController.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    return fetchedResultsController.fetchedObjects;
    
}


-(NSArray*) CoreDataSearchWithAuthorName : (NSString *) AuthorName
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSString *BookCoreDataEntityName = CORE_DATA_BOOK_ENTITY;
    
    // NSSortDescriptor tells defines how to sort the fetched results
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:BOOK_DATA_KEY_AUTHOR ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // fetchRequest needs to know what entity to fetch
    NSEntityDescription *entity = [NSEntityDescription entityForName:BookCoreDataEntityName inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    
    NSFetchedResultsController  *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_context sectionNameKeyPath:nil cacheName:@"Root"];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"author contains[cd] %@", AuthorName];
    
    [fetchedResultsController.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    return fetchedResultsController.fetchedObjects;
    
}




#pragma mark - Search branch
-(NSArray*) CoreDataSearchinBranchWithString : (NSString *) SearchString
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSString *BookCoreDataEntityName = CORE_DATA_BOOK_COPIES_ENTITY;
    
    // NSSortDescriptor tells defines how to sort the fetched results
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:BOOK_DATA_KEY_BRANCH ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // fetchRequest needs to know what entity to fetch
    NSEntityDescription *entity = [NSEntityDescription entityForName:BookCoreDataEntityName inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    
    NSFetchedResultsController  *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_context sectionNameKeyPath:nil cacheName:@"Root"];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"branch = %@", SearchString];
    
    [fetchedResultsController.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    return fetchedResultsController.fetchedObjects;
    
}


#pragma mark - Search branch

#pragma mark - Search branch
-(NSArray*) CoreDataSearchinCopiesWithString : (NSString *) SearchString
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSString *BookCoreDataEntityName = CORE_DATA_BOOK_COPIES_ENTITY;

    // NSSortDescriptor tells defines how to sort the fetched results
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:BOOK_DATA_KEY_ID ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];

    //fetchRequest needs to know what entity to fetch
    NSEntityDescription *entity = [NSEntityDescription entityForName:BookCoreDataEntityName inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    
    NSFetchedResultsController  *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_context sectionNameKeyPath:nil cacheName:@"Root"];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"id = %@ ", SearchString];
    
    [fetchedResultsController.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    return fetchedResultsController.fetchedObjects;
    
}



-(NSArray*) CoreDataSearchinCopiesWithBookID : (NSString *) SearchString WithBranchID : (NSString*) BranchID
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSString *BookCoreDataEntityName = CORE_DATA_BOOK_COPIES_ENTITY;
    
    // NSSortDescriptor tells defines how to sort the fetched results
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:BOOK_DATA_KEY_ID ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // fetchRequest needs to know what entity to fetch
    NSEntityDescription *entity = [NSEntityDescription entityForName:BookCoreDataEntityName inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    
    NSFetchedResultsController  *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_context sectionNameKeyPath:nil cacheName:@"Root"];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"id = %@ && branch = %@", SearchString, BranchID];
    
    [fetchedResultsController.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    }
    
    return fetchedResultsController.fetchedObjects;
    
}


- (BOOL) LoanBookWithIDStr : (NSString*) BookID
                  inBranch : (NSString*) BranchID
               byStartDate : (NSDate*) OutDate
                andDueDate : (NSDate*) DueDate
                 forUserID : (NSString*) UserID

{
    // Find available Book in sertain branch
    //NSMutableArray *BookArray = [[NSMutableArray alloc] init];
    
    NSArray *SearchArray = [self CoreDataSearchWithBookID:BookID];
    for (NSUInteger index = 0; index < [SearchArray count]; index++) {
        if ([[[SearchArray objectAtIndex:index] valueForKey:BOOK_DATA_KEY_BRANCH] isEqualToString:BranchID]) {
            if ([[[SearchArray objectAtIndex:index] valueForKey:BOOK_DATA_KEY_IN_STOCK] boolValue]) {
                
                
                // found a Book in stock
                // Set Borrower
                NSManagedObject *LoanBookObj = [SearchArray objectAtIndex:index];
                [LoanBookObj setValue:UserID forKey:BOOK_DATA_KEY_BORROWER];
                [LoanBookObj setValue:[NSNumber numberWithBool:NO] forKey:BOOK_DATA_KEY_IN_STOCK];
                [LoanBookObj setValue:OutDate forKey:BOOK_DATA_KEY_OUT_DATE];
                [LoanBookObj setValue:DueDate forKey:BOOK_DATA_KEY_DUE_DATE];
                
                NSError *error = nil;
                if (![_context save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                    return NO;
                }
                
                return YES;

            }
        }
    }
    NSLog(@"NOOOOOOO");
    
    return NO;
}

-(void) deleteDefaultObj
{
    NSArray *resultArray = [self CoreDataSearchinBranchWithString:DEFAULT_STR];
    for (NSManagedObject *Obj in resultArray) {
        [self deleteBookWithBookObj:Obj];
    }
}

/*
 Sample : Save Obj
 
 CoreDataModel *coredata = [[CoreDataModel alloc] init];
 Diary *DiaryObj = [[Diary alloc] init];
 [coredata SaveIntoCoreDataWithObj:DiaryObj];

 Sample : Fetch Obj
 CoreDataModel *coredata = [[CoreDataModel alloc] init];
 NSLog(@"topic = %@",     [[[coredata FetchObjInCoreData] firstObject] valueForKey:KEY_DIARY_TOPIC]);
 */


@end
