//
//  AppDelegate.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/25/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "AppDelegate.h"
#import "JSONFileManager.h"
#import "User.h"
@interface AppDelegate () 

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _CoreData = [[CoreDataModel alloc] init];

//     //Override point for customization after application launch.
//    CoreDataModel *CoreData = [[CoreDataModel alloc] init];
//    NSArray *SeawrchResult = [CoreData CoreDataSearchWithBookID:@"ISBN 0-321-41442-X"];
//    NSUInteger Count = [SeawrchResult count];
//    NSLog(@"Count = %d", Count);
//    
//    for (NSUInteger index = 0; index < Count; index++) {
//        NSLog(@"Branch = %@", [[SeawrchResult objectAtIndex:index] valueForKey:BOOK_DATA_KEY_BRANCH]);
//    }
//
//    NSLog(@"Count %d", [[_CoreData FetchLoanRecord] count]);
//    NSLog(@"Count %@", [[[_CoreData FetchLoanRecord] firstObject] valueForKey:@"userID"]);
//    NSLog(@"Count %@", [[[_CoreData FetchLoanRecord] firstObject] valueForKey:@"branch"]);
    
    
    //[self ProcessBranchList];
    //[self PutThingsIntoCoreData];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Process data
-(void) PutUserListInCoreData
{

     NSDictionary *UserListDic = [JSONFileManager JSON_ReadJSONFileWithFileName:@"UserList"];
     User *UserObj = [[User alloc] init];
     //NSLog(@"Dic = %@", UserListDic);
     //NSLog(@"Dic = %d", [UserListDic count]);
     for (NSDictionary *UserDic in UserListDic) {
         NSLog(@"User Name = %@", [UserDic valueForKey:@"Name"]);
         UserObj.UserName = [UserDic valueForKey:@"Name"];
         UserObj.Password = [UserDic valueForKey:@"Password"];
         UserObj.Phone = [UserDic valueForKey:@"Phone"];
         UserObj.Address = [UserDic valueForKey:@"Address"];
         UserObj.CardId = [UserDic valueForKey:@"CardNo"];
         [_CoreData SaveIntoCoreDataWithObj:UserObj];
     }
}

-(void) PutBookListInCoreData
{
    
    
    NSDictionary *BookListDic = [JSONFileManager JSON_ReadJSONFileWithFileName:@"bookList"];
    Book *BookObj = [[Book alloc] init];
    //NSLog(@"Dic = %@", BookListDic);
    //NSLog(@"Dic = %d", [UserListDic count]);
    for (NSDictionary *BookDic in BookListDic) {
        NSLog(@"Book Title = %@", [BookDic valueForKey:@"Title"]);
        BookObj.Title = [BookDic valueForKey:@"Title"];
        BookObj.Id = [BookDic valueForKey:@"BookId"];
        BookObj.Publisher = [BookDic valueForKey:@"PublisherName"];
        BookObj.isInStock = YES;
        [_CoreData SaveBookIntoCoreDataWithObj:BookObj];
    }
}

-(void) ProcessAuthorList
{
    
    NSDictionary *AuthorListDic = [JSONFileManager JSON_ReadJSONFileWithFileName:@"AuthorList"];
    NSLog(@"Dic = %@", AuthorListDic);
    
    for (NSDictionary *BookCopy in AuthorListDic) {
        NSLog(@"Bookid = %@", [BookCopy valueForKey:@"BookID"]);
        [_CoreData UpdateAuthor:[BookCopy valueForKey:@"AuthorName"] WithBookID:[BookCopy valueForKey:@"BookID"]];
    }
}


-(void) SetupBookCopies
{

    NSDictionary *BookCopyDic = [JSONFileManager JSON_ReadJSONFileWithFileName:@"bookCopies"];
    // 1. Find the isbn
    NSLog(@"Dic = %@", BookCopyDic);
    //NSLog(@"find count = %d", [CoreData CoreDataSearchWithBookID:[BookCopyDic firstObj]]);
    
    for (NSDictionary *BookCopy in BookCopyDic) {
        
        NSLog(@"Book  = %@", [BookCopy valueForKey:@"BookId"]);
        NSLog(@"BookBranch  = %@", [BookCopy valueForKey:@"BranchId"]);
        NSLog(@"BookCopies  = %@", [BookCopy valueForKey:@"No-Of_Copies"]);

        NSManagedObject *generalBookObj = [[_CoreData CoreDataSearchWithBookID:[BookCopy valueForKey:@"BookId"]] firstObject];
        
        NSInteger Loops = [[BookCopy valueForKey:@"No-Of_Copies"] integerValue];
        for (NSInteger index = 0; index < Loops; index++) {
            
            Book *BookObj = [[Book alloc] init];
            BookObj.Title = [generalBookObj valueForKey:BOOK_DATA_KEY_TITLE];
            BookObj.Id = [generalBookObj valueForKey:BOOK_DATA_KEY_ID];
            BookObj.Publisher = [generalBookObj valueForKey:BOOK_DATA_KEY_PUBLISHER];
            BookObj.Author = [generalBookObj valueForKey:BOOK_DATA_KEY_AUTHOR];
            BookObj.GUID = [NSUUID UUID].UUIDString;
            BookObj.Branch = [BookCopy valueForKey:@"BranchId"];
            
            NSLog(@"Looping index = %d", index);
            
            [_CoreData SaveBookCopiesIntoCoreDataWithObj:BookObj];
        }
        
        //[_CoreData deleteBookWithBookObj:generalBookObj];
        
    }
     
}

-(void) ProcessBookLoanList
{
    NSDictionary *LoanDic = [JSONFileManager JSON_ReadJSONFileWithFileName:@"bookLoans"];
    NSLog(@"Dic = %@", LoanDic);
    for (NSDictionary *Loans in LoanDic) {
        [_CoreData SaveLoanRecordIntoCoreDataWithLoanRecord:Loans];
    }
    
    /*
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"MM/dd/yyyy HH:mm a"];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    for (NSDictionary *Loans in LoanDic) {
        
        
        NSLog(@"Bookid = %@", [Loans valueForKey:@"BookId"]);
        NSLog(@"OutDate = %@", [Loans valueForKey:@"DateOut"]);
        NSLog(@"DueDate = %@", [Loans valueForKey:@"DueDate"]);
        
        NSDate *OutDate = [formatter dateFromString:[Loans valueForKey:@"DateOut"]];
        NSDate *DueDate = [formatter dateFromString:[Loans valueForKey:@"DueDate"]];
        [_CoreData LoanBookWithIDStr:[Loans valueForKey:@"BookId"]
                            inBranch:[Loans valueForKey:@"BranchId"]
                         byStartDate:OutDate
                          andDueDate:DueDate
                           forUserID:[Loans valueForKey:@"CardNo"]];
        
        
        //[_CoreData UpdateAuthor:[BookCopy valueForKey:@"AuthorName"] WithBookID:[BookCopy valueForKey:@"BookID"]];
    }
     
     */
}

-(void) ProcessBranchList
{
    NSDictionary *BranchDic = [JSONFileManager JSON_ReadJSONFileWithFileName:@"BranchList"];
    NSLog(@"Dic = %@", BranchDic);
    for (NSDictionary *Branches in BranchDic) {
        [_CoreData SaveBranchIntoCoreDataWithObj:Branches];
    }
    
}

-(void) PutThingsIntoCoreData
{
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self PutUserListInCoreData];
        [self PutBookListInCoreData];
        [self ProcessAuthorList];
        [self ProcessBranchList];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            [self SetupBookCopies];
            [self ProcessBookLoanList];
        });
    });
    
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.iOSTutor.LibraryExercise" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LibraryExercise" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LibraryExercise.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
