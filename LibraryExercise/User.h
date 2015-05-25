//
//  User.h
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/25/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

#define USER_CORE_DATA_NAME         @"userName"
#define USER_CORE_DATA_PASSWORD     @"password"
#define USER_CORE_DATA_ADDR         @"address"
#define USER_CORE_DATA_CARDID       @"cardId"
#define USER_CORE_DATA_MOBILE       @"mobile"
#define USER_CORE_DATA_BOOK1        @"bookid1"
#define USER_CORE_DATA_BOOK2        @"bookid2"
#define USER_CORE_DATA_BOOK3        @"bookid3"
#define USER_CORE_DATA_BOOK4        @"bookid4"
#define USER_CORE_DATA_BOOK5        @"bookid5"


@interface User : NSObject
-(User*) init;

@property (strong, nonatomic) NSString *UserName;
@property (strong, nonatomic) NSString *Password;
@property (strong, nonatomic) NSString *Address;
@property (strong, nonatomic) NSString *CardId;
@property (strong, nonatomic) NSString *Phone;

@property (strong, nonatomic) Book     *Book1;
@property (strong, nonatomic) Book     *Book2;
@property (strong, nonatomic) Book     *Book3;
@property (strong, nonatomic) Book     *Book4;
@property (strong, nonatomic) Book     *Book5;
@end
