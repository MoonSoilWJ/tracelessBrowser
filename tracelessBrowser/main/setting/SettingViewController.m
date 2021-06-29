//
//  SettingViewController.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/24.
//

#import "ChangeSkinViewController.h"
#import "SettingViewController.h"
#import "UIViewController+DeviceOriention.h"
#import <WebKit/WebKit.h>
#import "TBAboutUsViewController.h"
#import "TBUseTechViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableview;
    NSArray *_array;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    _array = @[
        @"清除缓存",
//        @"换肤中心",
        @"使用指南",
        @"关于我们"
    ];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), ScreenHeight()) style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.sectionHeaderHeight = 0;
    _tableview.sectionFooterHeight = 0;
//    _tableview.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_tableview];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *iden = @"settingVCecll";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.textLabel.text = _array[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        // 清除缓存;
            [self clearCatcheCookie];
            break;
//        case 1:
//            [self.navigationController pushViewController:[ChangeSkinViewController new] animated:YES];
//            break;
        case 1:
            //使用教程; pageViewController
        {
            TBUseTechViewController *use = [[TBUseTechViewController alloc] init];
            [self.navigationController pushViewController:use animated:YES];
        }
            break;
        case 2:
            //关于我们
        { TBAboutUsViewController *aboutUs = [[TBAboutUsViewController alloc] init];
            [self.navigationController pushViewController:aboutUs animated:YES];
        }
            break;
        default:
            break;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.1;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

//MARK: private

- (void)clearCatcheCookie {
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    indicator.frame = CGRectMake(ScreenWidth()/2-50, ScreenHeight()/2-50, 100, 100);
    indicator.backgroundColor = [UIColor grayColor];
    [indicator bezierPathRectCorner:UIRectCornerAllCorners conrnerRadius:8];
    [self.view addSubview:indicator];
    
    [indicator startAnimating];
    NSSet *allType = [WKWebsiteDataStore allWebsiteDataTypes];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:allType modifiedSince:[NSDate dateWithTimeIntervalSince1970:0] completionHandler:^{
        [indicator removeFromSuperview];
        [self.view makeToast:@"清除成功"];
    }];
    
}

//MARK: 横竖屏切换 delegate

- (void)deviceOrientionChanged:(UIDeviceOrientation)deviceOrientation {
//    [super deviceOrientionChanged:deviceOrientation];
    
    _tableview.frame =  CGRectMake(0, 0, ScreenWidth(), ScreenHeight());
}

@end
