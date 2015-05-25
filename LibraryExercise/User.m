//
//  User.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/25/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "User.h"

@implementation User
-(User*) init
{
    if (self) {
        self.UserName = DEFAULT_STR;
        self.Password = DEFAULT_STR;

        Book *InitBook = [[Book alloc] init];
        self.Book1 = InitBook;
        self.Book2 = InitBook;
        self.Book3 = InitBook;
        self.Book4 = InitBook;
        self.Book5 = InitBook;
    }
    return self;
}
@end
