//
//  TBAboutUsViewController.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/6/21.
//

#import "TBAboutUsViewController.h"

@interface TBAboutUsViewController ()

@end

@implementation TBAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"关于我们", @"");
    self.versionLab.text = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
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
