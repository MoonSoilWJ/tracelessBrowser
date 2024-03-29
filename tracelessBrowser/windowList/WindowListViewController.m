//
//  WindowListViewController.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/31.
//

#import "WindowListViewController.h"
#import "WindowListCollectionCell.h"
#import "WindowManager.h"
#import "TBBrowserViewController.h"
#import "UIButton+TB.h"
#import "UIImage+RTTint.h"
#import "WindowListAddNewCell.h"
#import "UIViewController+DeviceOriention.h"

static NSString *cellId = @"windowListCell";
static NSString *addNewCellId = @"WindowListAddNewCell";

@interface WindowListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) NSArray *windows;

@end

@implementation WindowListViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.fd_interactivePopDisabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (WindowManager.sharedInstance.getcurrentWindow.windowOffSet.y > 0) {
        [_collectionView setContentOffset: WindowManager.sharedInstance.getcurrentWindow.windowOffSet];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.fd_interactivePopDisabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
     
    float itemWidth = 150;
    float screenWidth = ScreenWidth()>ScreenHeight()?ScreenHeight():ScreenWidth();
    float margin = (screenWidth - 2*itemWidth) / 4.0;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(itemWidth, 251);
    flowLayout.minimumLineSpacing = margin;
    flowLayout.minimumInteritemSpacing = margin;
    flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin*3.0/2.0, margin, margin*3.0/2.0);
    
    [self getWindows];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), ScreenHeight()) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = rgba(239, 238, 247, 1);
    [_collectionView registerClass:[WindowListCollectionCell class] forCellWithReuseIdentifier:cellId];
    [_collectionView registerClass:[WindowListAddNewCell class] forCellWithReuseIdentifier:addNewCellId];
    _collectionView.alwaysBounceVertical = true;
    [self.view addSubview:_collectionView];

}

- (void)dealloc {
    
}

- (void)getWindows {
    _windows = [WindowManager sharedInstance].windowsArray;
    [_collectionView reloadData];
}

//MARK: collecction delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _windows.count + 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == _windows.count) { //addNew
        [WindowManager.sharedInstance addNewWindow];
        WindowManager.sharedInstance.getcurrentWindow.windowOffSet = collectionView.contentOffset;
//        [WindowManager.sharedInstance archiveWindows];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    WindowModel *model = _windows[indexPath.row];
    model.windowOffSet = collectionView.contentOffset;
    WindowManager.sharedInstance.currentWindowIndex = indexPath.row;
//    [WindowManager.sharedInstance archiveWindows];
    if (model.isHome) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        
        TBBrowserViewController *browser;
        if (model.browserVC) {
            browser = model.browserVC;
        }else {
            browser = [TBBrowserViewController new];
            browser.url = model.url.absoluteString;
        }
        
        NSMutableArray *viewControllers = self.navigationController.viewControllers.mutableCopy;
//        if ([viewControllers containsObject:browser]) {
//            // 从浏览页过来的
//        }else {
            //从首页过来的
            [viewControllers insertObject:browser atIndex:viewControllers.count-1];
            self.navigationController.viewControllers = viewControllers;
//        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == _windows.count) {
        WindowListAddNewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:addNewCellId forIndexPath:indexPath];
        return cell;
    }
    WindowListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.model = _windows[indexPath.row];
    __weak typeof(self) ws = self;
    cell.deleteBlock = ^{
        [collectionView performBatchUpdates:^{
            [WindowManager.sharedInstance deleteWindow:ws.windows[indexPath.item]];
            [collectionView deleteItemsAtIndexPaths:@[indexPath] ];
        } completion:^(BOOL finished) {
            [collectionView reloadData];
        }];
    };
    return cell;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size
          withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //update views here, e.g. calculate your view
        _collectionView.frame = CGRectMake(0, 0, ScreenWidth(), ScreenHeight());
        [_collectionView reloadData];
    }completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
    }];
}

@end
