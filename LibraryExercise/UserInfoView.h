//
//  UserInfoView.h
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/26/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoView.h"

@interface UserInfoView : UIView
@property (strong, nonatomic) IBOutlet UILabel *NameLab;
@property (strong, nonatomic) IBOutlet UILabel *MobilePhoneLab;
@property (strong, nonatomic) IBOutlet UILabel *AddressLab;
@property (strong, nonatomic) IBOutlet UIButton *BorrowBrn;
@property (strong, nonatomic) IBOutlet UILabel *CardIDLab;
@end
