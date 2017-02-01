//
//  DRZHomeViewController.m
//  Drizzzle
//
//  Created by Jatin Pandey on 10/29/16.
//  Copyright © 2016 JKP. All rights reserved.
//

#import "DRZHomeViewController.h"

#import "DRZPostCollectionViewCell.h"
#import "DRZPostDetailViewController.h"
#import "DRZServiceManager.h"
#import "ShotObject.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString * const reuseIdentifier = @"postCell";
static const CGFloat itemSpacing = 2.0f;
static const CGFloat kDRZCutesyUnderlineHeight = 3.0f;

@interface DRZHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

typedef NS_ENUM(NSInteger, DRZSortType) {
    DRZSortTypePopular = 0,
    DRZSortTypeRecent,
    DRZSortTypeDebuts,
    DRZSortTypeCount
};

//@property (nonatomic) UIView *customNavigationBar;
@property (nonatomic) UIView *cutesyUnderline;
@property (nonatomic) UIButton *sortButton;
@property (nonatomic) DRZSortType *currentSortType;
@property (nonatomic) NSMutableDictionary *sortTypeToString;

@property (nonatomic) UICollectionView *postCollectionView;
@property (nonatomic) UICollectionViewFlowLayout *collectionViewLayout;

@property (nonatomic) NSArray *shotsArray;
@property (nonatomic) DRZServiceManager *serviceManager;

/*
@property (nonatomic) UIScrollView *sv;
@property (nonatomic) UILabel *label;
*/

@end

@implementation DRZHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);

}
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    
}

- (void)viewWillDisappear:(BOOL)animated
{    NSLog(@"%s", __FUNCTION__);

    
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%s", __FUNCTION__);
    
    NSLog(@"%@", @"a");
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.sortTypeToString = [NSMutableDictionary dictionary];
    [self.sortTypeToString setObject:@"Popular" forKey:[NSNumber numberWithInt:DRZSortTypePopular]];
    [self.sortTypeToString setObject:@"Recent" forKey:[NSNumber numberWithInt:DRZSortTypeRecent]];
    [self.sortTypeToString setObject:@"Debut" forKey:[NSNumber numberWithInt:DRZSortTypeDebuts]];
    
    self.sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sortButton setTitle:@"Popular" forState:UIControlStateNormal];
    [self.sortButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.sortButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sortButton sizeToFit];
    self.sortButton.center = CGPointMake(self.navigationController.navigationBar.bounds.size.width / 2, self.navigationController.navigationBar.bounds.size.height / 2);
    [self.sortButton addTarget:self action:@selector(onSortButton:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.titleView = self.sortButton;
    self.navigationController.navigationBar.opaque = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    [self.navigationController.navigationBar addSubview:self.cutesyUnderline];
    self.cutesyUnderline.frame = CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.bounds) - kDRZCutesyUnderlineHeight, CGRectGetWidth(self.view.bounds), kDRZCutesyUnderlineHeight);

    self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionViewLayout.minimumLineSpacing = itemSpacing;
    self.collectionViewLayout.minimumInteritemSpacing = itemSpacing;

    self.postCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) collectionViewLayout:self.collectionViewLayout];
    [self.view addSubview:self.postCollectionView];
    self.postCollectionView.dataSource = self;
    self.postCollectionView.delegate = self;
    self.postCollectionView.backgroundColor = [UIColor blackColor];
    
    [self.postCollectionView registerClass:[DRZPostCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.shotsArray = [NSArray array];
    self.serviceManager = [[DRZServiceManager alloc] initWithAccessToken:@"7b1f01c52b73ec41db6efdb8acbbd7a36c8346cf4f1d743026b4feec86ed4f05"];
    
    [self.serviceManager getShotsWithSortOrder:[self.sortTypeToString objectForKey:[NSNumber numberWithInteger:self.currentSortType]] completionBlock:^(NSArray *shots) {
        self.shotsArray = shots;
        [self.postCollectionView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)cutesyUnderline {
    if (!_cutesyUnderline) {
        _cutesyUnderline = [[UIView alloc] init];
        _cutesyUnderline.backgroundColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:1.0];
    }
    return _cutesyUnderline;
}

- (void)onSortButton:(id)sender {
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DRZPostCollectionViewCell *cell = [self.postCollectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ShotObject *currentShot = [self.shotsArray objectAtIndex:indexPath.row];
    NSDictionary *images = [currentShot images];
    NSString *normalImageURLString = [images objectForKey:@"normal"];

    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:normalImageURLString] placeholderImage:[UIImage imageNamed:@"mayer"]];

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shotsArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ShotObject *shot = [self.shotsArray objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PostDetailStory" bundle:[NSBundle mainBundle]];
    
    DRZPostDetailViewController *postDetailVC =  [storyboard instantiateViewControllerWithIdentifier:@"postDetailViewController"];
    postDetailVC.currentShot = shot;
    NSString *backButtonTitle = [self.sortTypeToString objectForKey:[NSNumber numberWithInteger:self.currentSortType]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:backButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController pushViewController:postDetailVC animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (CGRectGetWidth(self.view.bounds) - 2 * itemSpacing) / 3;
    CGFloat height = width;
    return CGSizeMake(width, height);
}

@end
