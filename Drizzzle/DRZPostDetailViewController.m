//
//  DRZPostDetailViewController.m
//  Drizzzle
//
//  Created by Jatin Pandey on 10/29/16.
//  Copyright © 2016 JKP. All rights reserved.
//

#import "DRZPostDetailViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface DRZPostDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *shotImageView;
@property (weak, nonatomic) IBOutlet UILabel *shotDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;

@end

@implementation DRZPostDetailViewController

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

- (instancetype)initWithShot:(ShotObject *)shot {
    if (self = [super init]) {
        _currentShot = shot;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%s", __FUNCTION__);

    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    NSDictionary *imageDict = [self.currentShot images];
    NSString *normalURL = [imageDict objectForKey:@"normal"];
    NSURL *imageURL = [NSURL URLWithString:normalURL];

    [self.shotImageView sd_setImageWithURL:imageURL];
    NSString * htmlString = [self.currentShot shotDescription];
    NSAttributedString * htmlAttributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    self.shotDescriptionLabel.attributedText = htmlAttributedString;
    self.shotDescriptionLabel.font = [UIFont systemFontOfSize:16];

    self.commentsTableView.delegate = self;
    self.commentsTableView.dataSource = self;
    
    self.commentsTableView.estimatedRowHeight = 80.0f;
    self.commentsTableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.commentsTableView dequeueReusableCellWithIdentifier:@"commentCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commentCell"];
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
