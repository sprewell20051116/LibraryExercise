//
//  User.h
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/25/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
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
