//
//  UserNavViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/26/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "UserNavViewController.h"
#import "UserViewController.h"
@interface UserNavViewController ()

@end

@implementation UserNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *viewControllers = self.viewControllers;
    NSLog(@"viewcontrollers = %@", viewControllers);
    UserViewController *rootViewController = [viewControllers firstObject];
    rootViewController.UserName =_UserName;
    rootViewController.UserID = _UserID;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
