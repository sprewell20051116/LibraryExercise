//
//  RegisterViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/25/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "RegisterViewController.h"
#import "CoreDataModel.h"
#import "User.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_RegistBtn addTarget:self action:@selector(RegisterBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_CancelBtn addTarget:self action:@selector(CancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)RegisterBtnClicked
{
    CoreDataModel *CoreData = [[CoreDataModel alloc] init];
    // 1. check user name
    
    if ([_UserName.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"輸入你的名字" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }

    
    if ([[CoreData CoreDataSearchUserWithName:_UserName.text] count] != 0) {
        // UserName is used
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"名字已經被用了唷" message:@"再取一個吧" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // 2. check password
    if ([_UserName.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"輸入你的密碼" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if ([_Password.text isEqualToString:_PasswordVerify.text] != TRUE) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密碼不一樣唷" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    // 3. check CardID
    if ([_CardNumber.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"輸入你的 CardID" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if ([[CoreData CoreDataSearchUserWithCardID:_UserName.text] count] != 0) {
        // UserName is used
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ID 已經被用過囉" message:@"再想一個吧" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    User *UserObj = [[User alloc] init];
    UserObj.UserName = _UserName.text;
    UserObj.Password = _Password.text;
    UserObj.CardId = _CardNumber.text;
    
    if ([_MobilePhone.text length] != 0) {
        UserObj.Phone = _MobilePhone.text;
    }
    
    if ([_Address.text length] != 0) {
        UserObj.Address = _Address.text;
    }
    
    [CoreData SaveIntoCoreDataWithObj:UserObj];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)CancelBtnClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
