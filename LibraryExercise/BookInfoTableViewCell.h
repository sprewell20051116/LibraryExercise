//
//  BookInfoTableViewCell.h
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/29/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookInfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *BanchIdLab;
@property (strong, nonatomic) IBOutlet UILabel *BranchNameLab;
@property (strong, nonatomic) IBOutlet UILabel *AddrLab;
@property (strong, nonatomic) IBOutlet UILabel *CopiesLab;

@end
