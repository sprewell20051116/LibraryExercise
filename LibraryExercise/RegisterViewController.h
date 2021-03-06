//
//  RegisterViewController.h
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/25/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *RegistBtn;
@property (strong, nonatomic) IBOutlet UIButton *CancelBtn;
@property (strong, nonatomic) IBOutlet UITextField *UserName;
@property (strong, nonatomic) IBOutlet UITextField *Password;
@property (strong, nonatomic) IBOutlet UITextField *PasswordVerify;
@property (strong, nonatomic) IBOutlet UITextField *CardNumber;
@property (strong, nonatomic) IBOutlet UITextField *MobilePhone;
@property (strong, nonatomic) IBOutlet UITextField *Address;

@end
