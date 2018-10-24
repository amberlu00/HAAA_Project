//
//  MainInterviewViewController.m
//  HAAA_Project
//
//  Created by Amber Lu on 10/23/18.
//  Copyright © 2018 Amber Lu. All rights reserved.
//

#import "MainInterviewViewController.h"

@interface MainInterviewViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property UICollectionViewFlowLayout *mainInterviewFlowLayout;
@property (strong, nonatomic) UICollectionView *mainInterviewCollectionView;
@property (strong, nonatomic) NSArray *sortByArray;
@property InterviewPersonCollectionViewController *refinedSearchController;

@property UITableView *searchResultsTableView;

@property NSArray *searchableNamesArray;
@property NSMutableArray *filteredSearchArray;
@property (weak, nonatomic) IBOutlet UISearchBar *mainInterviewSearchBar;
@property (strong, nonatomic) UISearchController *mainSearchController;
@end

@implementation MainInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize the frame
    self.view.tintColor = [UIColor colorWithRed:0.0 green:36.0/255.0 blue:106.0/255.0 alpha:1];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.mainInterviewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.mainInterviewCollectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(5, 150, screenBounds.size.width - 20, screenBounds.size.height - 150) collectionViewLayout:self.mainInterviewFlowLayout];
    self.searchResultsTableView = [[UITableView alloc] initWithFrame: CGRectMake(5, 150, screenBounds.size.width, screenBounds.size.height - 150)];
    
    //Collection View initialization
    [self.mainInterviewCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MainCollectionsCell"];
    [self.mainInterviewCollectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mainInterviewCollectionView];
    [self.mainInterviewCollectionView setDelegate:self];
    [self.mainInterviewCollectionView setDataSource:self];
    
    //Initialize navigation bar
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Trajan Pro" size:20], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.0 green:36.0/255.0 blue:106.0/255.0 alpha:1]];
    
    //Initialize the search table and bar
    self.searchResultsTableView.delegate = self;
    self.searchResultsTableView.dataSource = self;
    
    //Initialize some important variables
    self.sortByArray = @[@"View All", @"Recommended for You", @"Sort by Date", @"Sort by Name", @"Sort by Community", @"Sort by Topics"];
    //Search array
    NSString *filesString = [[NSBundle mainBundle] pathForResource:@"filesToAccess" ofType:@"json"];
    NSError *error = nil;
    NSString *jsonString = [NSString stringWithContentsOfFile:filesString encoding:NSUTF8StringEncoding error:&error];
    NSData *filesDataJSON = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData: filesDataJSON options:kNilOptions error:&error];
    self.searchableNamesArray = [parsedData allKeys];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Search results
- (void)viewWillAppear:(BOOL)animated {
    [self.view addSubview:self.searchResultsTableView];
    [super viewWillAppear:animated];
    if (!self.mainSearchController.searchBar.superview) {
        self.searchResultsTableView.tableHeaderView = self.mainSearchController.searchBar;
    }
}


#pragma mark - Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filteredSearchArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *newCellIdentifier = @"mainInterviewCell";
    UITableViewCell *individualCell = [self.searchResultsTableView dequeueReusableCellWithIdentifier:newCellIdentifier];
    individualCell.textLabel.text = [self.filteredSearchArray objectAtIndex:indexPath.row];
    if (individualCell == nil) {
        individualCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:newCellIdentifier];
    }
    return individualCell;
}

#pragma mark - Collections
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
    titleofCellLabel.textAlignment = NSTextAlignmentCenter;
    titleofCellLabel.numberOfLines = 0;
    titleofCellLabel.font = [UIFont fontWithName:@"Trajan Pro" size:15];
    [cell.contentView addSubview:titleofCellLabel];
    [cell setBackgroundColor:[UIColor colorWithRed:0.0 green:36.0/255.0 blue:106.0/255.0 alpha:1]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    return CGSizeMake(screenBounds.size.width/2 - 20, screenBounds.size.width/2 - 20);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}
@end
