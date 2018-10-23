//
//  MainInterviewViewController.m
//  HAAA_Project
//
//  Created by Amber Lu on 10/23/18.
//  Copyright © 2018 Amber Lu. All rights reserved.
//

#import "MainInterviewViewController.h"

@interface MainInterviewViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource>

@property UICollectionViewFlowLayout *mainInterviewFlowLayout;
@property (strong, nonatomic) UICollectionView *mainInterviewCollectionView;
@property (strong, nonatomic) NSArray *sortByArray;


@end

@implementation MainInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize the frame
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.mainInterviewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.mainInterviewCollectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(5, 100, screenBounds.size.width - 20, screenBounds.size.height - 100) collectionViewLayout:self.mainInterviewFlowLayout];
    [self.mainInterviewCollectionView setDelegate:self];
    [self.mainInterviewCollectionView setDataSource:self];
    [self.mainInterviewCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MainCollectionsCell"];
    [self.mainInterviewCollectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mainInterviewCollectionView];
    
    //Initialize some important variables
    self.sortByArray = @[@"View All", @"Recommended for You", @"Sort by Date", @"Sort by Name", @"Sort by Community", @"Sort by Topics"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCollectionsCell" forIndexPath:indexPath];
    UILabel *titleofCellLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.bounds.origin.x + 5, cell.bounds.origin.y + 5, cell.bounds.size.width - 5, cell.bounds.size.height - 5)];
    titleofCellLabel.text = [self.sortByArray objectAtIndex:indexPath.row];
    titleofCellLabel.textColor = [UIColor whiteColor];
    titleofCellLabel.font = [UIFont fontWithName:@"Trajan Pro" size:15];
    titleofCellLabel.textAlignment = NSTextAlignmentCenter;
    titleofCellLabel.numberOfLines = 0;
    [cell.contentView addSubview:titleofCellLabel];
    [cell setBackgroundColor:[UIColor colorWithRed:0.0 green:36.0/255.0 blue:106.0/255.0 alpha:1]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    return CGSizeMake(screenBounds.size.width/2 - 20, screenBounds.size.width/2 - 20);
}
@end
