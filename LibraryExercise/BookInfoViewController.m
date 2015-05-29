//
//  BookInfoViewController.m
//  LibraryExercise
//
//  Created by CHIN-KANG CHANG on 5/27/15.
//  Copyright (c) 2015 iOSTutor. All rights reserved.
//

#import "BookInfoViewController.h"
#import "CoreDataModel.h"

@interface BookInfoViewController () {
    CoreDataModel *_CoreData;
    NSArray       *_BookCopiesArray;
}

@end

@implementation BookInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _CoreData = [[CoreDataModel alloc] init];
    if (_BookID) {
        _BookCopiesArray = [_CoreData CoreDataSearchinCopiesWithString:_BookID];
        NSLog(@"%s -- %d", __PRETTY_FUNCTION__, [_BookCopiesArray count]);
        [self init_InfoView];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)init_InfoView
{
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"UserInfoView"
                                                      owner:self
                                                    options:nil];
    
    _InfoView = (UserInfoView*)[nibViews objectAtIndex:0];
    CGRect Frame = _InfoView.frame;
    Frame.origin.y = 44.0f + 20.0f;
    Frame.size.height = 200;
    [_InfoView setFrame:Frame];
    [_InfoView.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
    [_InfoView.layer setShadowOffset:CGSizeMake(1,8)];
    [_InfoView.layer setShadowOpacity:0.5f];

    _InfoView.NameLab.text = [[[_CoreData CoreDataSearchWithBookID:_BookID] firstObject] valueForKey:BOOK_DATA_KEY_TITLE];
    _InfoView.CardIDLab.text = _BookID;
    [_InfoView.BorrowBrn setHidden:YES];
    [_InfoView.MobilePhoneLab setHidden:YES];
    [_InfoView.AddressLab setHidden:YES];
    
    [self.view addSubview:_InfoView];
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
