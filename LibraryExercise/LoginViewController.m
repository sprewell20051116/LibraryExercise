//
//  LoginViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/25/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "LoginViewController.h"
#import "CoreDataModel.h"
#import "UserNavViewController.h"
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"沒找到你的名字" message:@"就沒有找到啊！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    } else {

        NSString *PW = [[[CoreData CoreDataSearchUserWithName:_UsernameTextField.text] firstObject] valueForKey:USER_CORE_DATA_PASSWORD];
        if ([_PasswordTextfield.text isEqualToString:PW]) {
            // TODO: GO TO USER NAVICATION CONTROLLER
            [self GotoUserNavView];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密碼不對" message:@"就不對啊！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        
        }
    }
}

-(void) GotoUserNavView
{
    //CoreDataModel *CoreData = [[CoreDataModel alloc] init];

    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    UserNavViewController* AddVC = [sb instantiateViewControllerWithIdentifier:@"UserNavViewController"];
    
    AddVC.UserName = _UsernameTextField.text;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:AddVC animated:YES completion:nil];
    });
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
