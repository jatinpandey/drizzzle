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

@interface DRZHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

typedef NS_ENUM(NSInteger, DRZSortType) {
    DRZSortTypePopular = 0,
    DRZSortTypeRecent,
    DRZSortTypeDebuts,
    DRZSortTypeCount
};

@property (nonatomic) UIView *customNavigationBar;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
    self.sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]), self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.sv];
    self.sv.contentSize = CGSizeMake(self.view.bounds.size.width, 2000);
    self.sv.backgroundColor = [UIColor blackColor];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, 200, 100)];
    [self.sv addSubview:self.label];
    self.label.text = @"fdfsfdgfsgdfg";
    self.label.textColor = [UIColor redColor];
     */
    
    self.sortTypeToString = [NSMutableDictionary dictionary];
    [self.sortTypeToString setObject:@"Popular" forKey:[NSNumber numberWithInt:DRZSortTypePopular]];
    [self.sortTypeToString setObject:@"Recent" forKey:[NSNumber numberWithInt:DRZSortTypeRecent]];
    [self.sortTypeToString setObject:@"Debut" forKey:[NSNumber numberWithInt:DRZSortTypeDebuts]];
    
    [self.view addSubview:self.customNavigationBar];
    self.customNavigationBar.frame = CGRectMake(0, CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]), CGRectGetWidth(self.view.bounds), 44);
    
    [self.customNavigationBar addSubview:self.cutesyUnderline];
    self.cutesyUnderline.frame = CGRectMake(0, CGRectGetHeight(self.customNavigationBar.frame) - 4, CGRectGetWidth(self.customNavigationBar.bounds), 4);
    
    self.sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sortButton setTitle:@"Popular" forState:UIControlStateNormal];
    [self.sortButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.sortButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sortButton sizeToFit];
    [self.customNavigationBar addSubview:self.sortButton];
    self.sortButton.center = CGPointMake(self.customNavigationBar.bounds.size.width / 2, self.customNavigationBar.bounds.size.height / 2);
    
    [self.sortButton addTarget:self action:@selector(onSortButton:) forControlEvents:UIControlEventTouchUpInside];

    self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionViewLayout.minimumLineSpacing = itemSpacing;
    self.collectionViewLayout.minimumInteritemSpacing = itemSpacing;

    self.postCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY([[UIApplication sharedApplication] statusBarFrame]), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY([[UIApplication sharedApplication] statusBarFrame])) collectionViewLayout:self.collectionViewLayout];
    [self.view addSubview:self.postCollectionView];
    self.postCollectionView.dataSource = self;
    self.postCollectionView.delegate = self;
    self.postCollectionView.backgroundColor = [UIColor blackColor];
    
    [self.postCollectionView registerClass:[DRZPostCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.view bringSubviewToFront:self.customNavigationBar];
    
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

- (UIView *)customNavigationBar {
    if (!_customNavigationBar) {
        _customNavigationBar = [[UIView alloc] init];
        _customNavigationBar.backgroundColor = [UIColor whiteColor];
        _customNavigationBar.alpha = 0.98;
    }
    return _customNavigationBar;
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
    cell.backgroundColor = [UIColor whiteColor];
    ShotObject *currentShot = [self.shotsArray objectAtIndex:indexPath.row];
    NSDictionary *images = [currentShot images];
    NSString *normalImageURLString = [images objectForKey:@"normal"];

    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:normalImageURLString]];

/*
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:normalImageURLString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *shotImage = [UIImage imageWithData:data];
        if (shotImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                DRZPostCollectionViewCell *cell = [self collectionView:self.postCollectionView cellForItemAtIndexPath:indexPath];
                if (cell) {
                    cell.image = shotImage;
                    [cell layoutIfNeeded];
                }
            });
        }
    }];
    [dataTask resume];
*/
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
    DRZPostDetailViewController *postDetailVC = [[DRZPostDetailViewController alloc] initWithShotID:shot.id];
    [self presentViewController:postDetailVC animated:YES completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (CGRectGetWidth(self.view.bounds) - 2 * itemSpacing) / 3;
    CGFloat height = width;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(CGRectGetHeight(self.customNavigationBar.bounds), 0, 0, 0);
}

@end
