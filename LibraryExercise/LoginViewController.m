//
//  LoginViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/25/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "LoginViewController.h"
#import "CoreDataModel.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_LoginBtn addTarget:self action:@selector(LoginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) LoginBtnClicked
{
    if ([_UsernameTextField.text length] == 0) {
        return;
    }
    CoreDataModel *CoreData = [[CoreDataModel alloc] init];

    
    if ([[CoreData CoreDataSearchUserWithName:_UsernameTextField.text] count] == 0) {
        // TODO: Alert not registed
    } else {

        NSString *PW = [[[CoreData CoreDataSearchUserWithName:_UsernameTextField.text] firstObject] valueForKey:USER_CORE_DATA_PASSWORD];
        if ([_PasswordTextfield.text isEqualToString:PW]) {
            // TODO: GO TO USER NAVICATION CONTROLLER
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
