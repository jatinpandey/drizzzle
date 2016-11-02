//
//  DRZPostDetailViewController.m
//  Drizzzle
//
//  Created by Jatin Pandey on 10/29/16.
//  Copyright © 2016 JKP. All rights reserved.
//

#import "DRZPostDetailViewController.h"

@interface DRZPostDetailViewController ()

@property (nonatomic) NSInteger shotID;
@property (nonatomic) UILabel *idLabel;

@end

@implementation DRZPostDetailViewController

- (instancetype)initWithShotID:(NSInteger)shotID {
    if (self = [super init]) {
        _shotID = shotID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.idLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.idLabel.text = [NSString stringWithFormat:@"%ld", self.shotID];
    self.idLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.idLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
