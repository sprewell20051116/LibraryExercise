//
//  AddNewBookViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/30/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "AddNewBookViewController.h"
#import "CoreDataModel.h"
#import "Book.h"
@interface AddNewBookViewController () {
    CoreDataModel *_CoreData;
}

@end

@implementation AddNewBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _CoreData = [[CoreDataModel alloc] init];

    [_ConfirmBtn addTarget:self action:@selector(ConfirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) ConfirmBtnClicked
{
    Book *BookObj = [[Book alloc] init];
    
    BookObj.Title = _BookNameTextField.text;
    BookObj.Id = _BookIDTextField.text;
    BookObj.Author = _BookAuthorTextField.text;
    BookObj.Publisher = _BookPublisherTextField.text;

    [_CoreData SaveBookIntoCoreDataWithObj:BookObj];
    
    [self SaveBookCopyWithBookObj:BookObj inBranch:BRANCH_ID_1 forCopies:[_Branch1TextField.text integerValue]];
    [self SaveBookCopyWithBookObj:BookObj inBranch:BRANCH_ID_2 forCopies:[_Branch2TextField.text integerValue]];
    [self SaveBookCopyWithBookObj:BookObj inBranch:BRANCH_ID_3 forCopies:[_Branch3TextField.text integerValue]];
    [self SaveBookCopyWithBookObj:BookObj inBranch:BRANCH_ID_4 forCopies:[_Branch4TextField.text integerValue]];
    [self SaveBookCopyWithBookObj:BookObj inBranch:BRANCH_ID_5 forCopies:[_Branch5TextField.text integerValue]];
    [self SaveBookCopyWithBookObj:BookObj inBranch:BRANCH_ID_6 forCopies:[_Branch6TextField.text integerValue]];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) SaveBookCopyWithBookObj : (Book*) Book inBranch : (NSString*) BranchName forCopies : (NSInteger) Copies
{
    Book.Branch = BranchName;
    for (int count = 0; count < Copies; count++) {
        Book.GUID = [NSUUID UUID].UUIDString;
        [_CoreData SaveBookCopiesIntoCoreDataWithObj:Book];
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
