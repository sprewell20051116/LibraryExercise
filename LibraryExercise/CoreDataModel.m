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
    [NewObj setValue:CoreDataObj.BorrowerID forKey:BOOK_DATA_KEY_BORROWER];
    [NewObj setValue:CoreDataObj.OutDate forKey:BOOK_DATA_KEY_OUT_DATE];
    [NewObj setValue:CoreDataObj.DueDate forKey:BOOK_DATA_KEY_DUE_DATE];
    [NewObj setValue:[NSNumber numberWithBool:CoreDataObj.isInStock] forKey:BOOK_DATA_KEY_IN_STOCK];

    
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


#pragma mark - Fetch User Object
-(NSMutableArray*) FetchBookObjInCoreData
{
    NSMutableArray *CoreDataArray = [[NSMutableArray alloc] init];
    NSString *CoreDataEntityName;
    CoreDataEntityName = CORE_DATA_BOOK_ENTITY;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:CoreDataEntityName];
    CoreDataArray = [[_context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    return CoreDataArray;
    
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
