//
//  BookInfoViewController.h
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/27/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoView.h"


@interface BookInfoViewController : UIViewController
@property (strong, nonatomic) NSString *BookID;
@property (strong, nonatomic) NSString *UserID;
@property (strong, nonatomic) UserInfoView *InfoView;
@end
