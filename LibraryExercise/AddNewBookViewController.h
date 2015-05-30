//
//  AddNewBookViewController.h
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/30/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewBookViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *BookNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *BookIDTextField;
@property (strong, nonatomic) IBOutlet UITextField *BookAuthorTextField;
@property (strong, nonatomic) IBOutlet UITextField *BookPublisherTextField;
@property (strong, nonatomic) IBOutlet UITextField *Branch1TextField;
@property (strong, nonatomic) IBOutlet UITextField *Branch2TextField;
@property (strong, nonatomic) IBOutlet UITextField *Branch3TextField;
@property (strong, nonatomic) IBOutlet UITextField *Branch4TextField;
@property (strong, nonatomic) IBOutlet UITextField *Branch5TextField;
@property (strong, nonatomic) IBOutlet UITextField *Branch6TextField;
@property (strong, nonatomic) IBOutlet UIButton *ConfirmBtn;

@end
