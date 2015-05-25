//
//  Book.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/25/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "Book.h"


@implementation Book
-(Book*) init
{
    if (self) {
        self.GUID = DEFAULT_STR;
        self.Title = DEFAULT_STR;
        self.Id = DEFAULT_STR;
        self.Publisher = DEFAULT_STR;
        self.Author = DEFAULT_STR;
        self.Branch = DEFAULT_STR;
        self.isInStock = YES;
        self.BorrowerID = DEFAULT_STR;
        NSDate *Date = [NSDate date];
        self.OutDate = Date;
        self.DueDate = Date;
    }
    return self;
}
@end
