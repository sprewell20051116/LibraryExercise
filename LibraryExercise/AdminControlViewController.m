//
//  AdminControlViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/30/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "AdminControlViewController.h"
#import "DeleteBookViewController.h"
#import "BorrowingBookViewController.h"
@interface AdminControlViewController ()

@end

@implementation AdminControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_LogoutBtn addTarget:self action:@selector(LogoutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_BookListBtn addTarget:self action:@selector(BookListBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) LogoutBtnClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void) BookListBtnClicked
{
    [self performSegueWithIdentifier:@"BookList" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"BookList"]) {
        // Get destination view
        DeleteBookViewController *vc = [segue destinationViewController];
        
        vc.DeleteMode = NO;
    } else if ([[segue identifier] isEqualToString:@"DeleteBook"]) {
        // Get destination view
        DeleteBookViewController *vc = [segue destinationViewController];
        
        vc.DeleteMode = YES;
    }  else if ([[segue identifier] isEqualToString:@"MoveBranch"]) {
        // Get destination view
        BorrowingBookViewController *vc = [segue destinationViewController];
        vc.MoveBranchMode = YES;
    }

}


@end
