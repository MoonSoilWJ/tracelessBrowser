//
//  WindowListViewController.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/31.
//

#import "WindowListViewController.h"
#import "WindowListCollectionCell.h"
#import "WindowManager.h"

static NSString *cellId = @"windowListCell";

@interface WindowListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSArray *windows;

@end

@implementation WindowListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float itemWidth = 150;
    float margin = (ScreenWidth() - 2*itemWidth) / 3.0 - 1;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(itemWidth, 251);
    flowLayout.minimumLineSpacing = margin;
    flowLayout.minimumInteritemSpacing = margin;
    flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin+HOME_INDICATOR_HEIGHT, margin);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), ScreenHeight()) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = rgba(51, 51, 51, 1);
    [_collectionView registerClass:[WindowListCollectionCell class] forCellWithReuseIdentifier:cellId];
    _collectionView.alwaysBounceVertical = true;
    [self.view addSubview:_collectionView];
}

- (void)getWindows {
    _windows = [WindowManager sharedInstance].windowsArray;
    [_collectionView reloadData];
}

//MARK: collecction delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _windows.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WindowListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    return cell;
}

@end
