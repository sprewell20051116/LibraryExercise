//
//  AdminViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/25/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "AdminViewController.h"
#import "AdminNavViewController.h"
@interface AdminViewController ()

@end

@implementation AdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_LoginAsUserBtn addTarget:self action:@selector(LoginAsUserBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_AdminLoginBtn addTarget:self action:@selector(AdminLoginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)LoginAsUserBtnClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)AdminLoginBtnClicked
{
    if ([_AdminPasswordTextField.text isEqualToString:@"admin"]) {
        [self GotoAdminNavView];
    }
}

-(void) GotoAdminNavView
{
    //CoreDataModel *CoreData = [[CoreDataModel alloc] init];
    
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    AdminNavViewController* AddVC = [sb instantiateViewControllerWithIdentifier:@"AdminNavViewController"];
    
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
