//
//  UserViewController.h
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/26/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoView.h"
#import "CoreDataModel.h"

@interface UserViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *LogoutBtn;
@property (strong, nonatomic) CoreDataModel     *CoreData;
@property (strong, nonatomic) UserInfoView      *UserInfoSubView;
@property (strong, nonatomic) UITableView       *UserLoanTableView;
@end
