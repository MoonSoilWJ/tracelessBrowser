//
//  ChangeSkinViewController.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/1.
//

#import "ChangeSkinViewController.h"
#import "ChangeSkinSwitchCell.h"
#import "ChangeSkinSelectImageCell.h"
#import "TBEnginsManager.h"
#import "UIViewController+DeviceOriention.h"

@interface ChangeSkinViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UITableView *_tableView;
}
@end

@implementation ChangeSkinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"换肤中心";
    [UINavigationBar appearance].tintColor = THEME_COLOR;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), ScreenHeight()) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionHeaderHeight = 0.1;
    [self.view addSubview:_tableView];
    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageForColor:UIColor.whiteColor] forBarMetrics:UIBarMetricsDefault];
//    _tableView.backgroundColor = UIColor.whiteColor;
    
//    [self initSkin];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *cellSwitchId = @"ChangeSkinTableViewCellSwitchId";
        ChangeSkinSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSwitchId];
        if (!cell) {
            cell = [[ChangeSkinSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSwitchId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.uiswitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        }
        
        NSDictionary *changeSkinDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"changeSkin"];
        cell.uiswitch.tag =  indexPath.row;
        if (indexPath.row == 0) {
            bool close = [changeSkinDic[@"type_close"][@"close"] boolValue];
            cell.uiswitch.on = close;
            cell.titleLab.text = @"关闭皮肤";
        }else if(indexPath.row == 1) {
            bool blur = [changeSkinDic[@"type_blur"][@"close"] boolValue];
            cell.uiswitch.on = blur;
            cell.titleLab.text = @"关闭皮肤毛玻璃效果";
        }
        return cell;
    }
    
    static NSString *cellImageId = @"ChangeSkinTableViewCellImageId";
    ChangeSkinSelectImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellImageId];
    if (!cell) {
        cell = [[ChangeSkinSelectImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellImageId];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 0) {
        UIImagePickerController *pick = [[UIImagePickerController alloc] init];
        pick.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pick.delegate = self;
        pick.allowsEditing = NO;
        [self.navigationController presentViewController:pick animated:YES completion:nil];
    }
}

#pragma mark - image Pciker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
[picker dismissViewControllerAnimated:YES completion:nil];

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data = [self compressOriginalImage:image toMaxDataSizeKBytes:50000];
    [TBEnginsManager saveImage:data ToDocmentWithFileName:@"changeSkin"];
    
    NSDictionary *userInfo = @{@"type":@(2)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeSkin" object:nil userInfo:userInfo];
   
    NSDictionary *changeSkinDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"changeSkin"];
    bool close = [changeSkinDic[@"type_close"][@"close"] boolValue];
    if (!close) {
        NSDictionary *closeUserInfo = @{@"type":@(0),@"close":@(0)};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeSkin" object:nil userInfo: closeUserInfo];
        [self saveSetting:closeUserInfo];
    }
    [self saveSetting:userInfo];
}

- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size
{
    UIImage *OriginalImage = image;
    
    // 执行这句代码之后会有一个范围 例如500m 会是 100m～500k
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    
    // 执行while循环 如果第一次压缩不会小雨100k 那么减小尺寸在重新开始压缩
    while (dataKBytes > size)
    {
        while (dataKBytes > size && maxQuality > 0.1f)
        {
            maxQuality = maxQuality - 0.1f;
            data = UIImageJPEGRepresentation(image, maxQuality);
            dataKBytes = data.length / 1000.0;
            if(dataKBytes <= size )
            {
                return data;
            }
        }
        OriginalImage =[self compressOriginalImage:OriginalImage toWidth:OriginalImage.size.width * 0.8];
        image = OriginalImage;
        data = UIImageJPEGRepresentation(image, 1.0);
        dataKBytes = data.length / 1000.0;
        maxQuality = 0.9f;
    }
    return data;
}

#pragma mark - 改变图片的大小
-(UIImage *)compressOriginalImage:(UIImage *)image toWidth:(CGFloat)targetWidth
{
    CGSize imageSize = image.size;
    CGFloat Originalwidth = imageSize.width;
    CGFloat Originalheight = imageSize.height;
    CGFloat targetHeight = Originalheight / Originalwidth * targetWidth;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [image drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//MARK: ---action

- (void)switchChanged:(UISwitch *)uiswitch {
    
    NSDictionary *info = @{@"type":@(uiswitch.tag),@"close":@(uiswitch.on)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeSkin" object:nil userInfo:info];
    
    [self saveSetting:info];
}

- (void)saveSetting:(NSDictionary *)info {
    
    NSDictionary *userDefaultDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"changeSkin"];
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:userDefaultDict];
    
    NSInteger type = [info[@"type"] integerValue];
    if (type == 0) { //关闭
        [mutDic setObject:info forKey:@"type_close"];
    }else if (type == 1) { // blur
        [mutDic setObject:info forKey:@"type_blur"];
    }else if (type == 2) {
        [mutDic setObject:info forKey:@"type_image"];
    }

    [[NSUserDefaults standardUserDefaults] setObject:mutDic forKey:@"changeSkin"];
}
//
//- (void)skinDidChanged:(NSDictionary *)info {
//    NSInteger type = [info[@"type"] integerValue];
//    if (type == 0) { //关闭
//        bool close = [info[@"close"] boolValue];
//        if (close) {
//            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageForColor:UIColor.whiteColor] forBarMetrics:UIBarMetricsDefault];
////            _tableView.backgroundColor = UIColor.whiteColor;
//        }else {
//            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageForColor:UIColor.clearColor] forBarMetrics:UIBarMetricsDefault];
////            _tableView.backgroundColor = UIColor.clearColor;
//        }
//    }
//}

- (void)deviceOrientionChanged:(UIDeviceOrientation)deviceOrientation {
    [super deviceOrientionChanged:deviceOrientation];
    
    _tableView.frame =  CGRectMake(0, 0, ScreenWidth(), ScreenHeight());
}

@end
