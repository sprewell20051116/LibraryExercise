//
//  DeleteBookViewController.h
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/30/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataModel.h"

@interface DeleteBookViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) UITableView *TableView;
@property (strong, nonatomic) CoreDataModel *CoreData;

@end
