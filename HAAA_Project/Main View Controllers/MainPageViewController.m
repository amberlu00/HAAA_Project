//
//  MainPageViewController.m
//  HAAA_Project
//
//  Created by Amber Lu on 10/22/18.
//  Copyright © 2018 Amber Lu. All rights reserved.
//

#import "MainPageViewController.h"

@interface MainPageViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *mainNewTableView;

@property (strong, nonatomic) AVPlayerViewController *mainPageVideoController;

@property(strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *textLabel;

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Optional code to test for the correct fonts :)
    /*
    for (NSString *familyName in [UIFont familyNames]){
        NSLog(@"Family name: %@", familyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"--Font name: %@", fontName);
        }
    }
    */
    
    //Initializing the frame
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.mainPageVideoController = [[AVPlayerViewController alloc] init];
    self.mainPageVideoController.view.frame = CGRectMake(0, 60, CGRectGetWidth(screenBounds), 230);
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth(screenBounds), 50)];
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 355, CGRectGetWidth(screenBounds), 70)];
    self.mainNewTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 440, CGRectGetWidth(screenBounds), CGRectGetHeight(screenBounds) - 440)];
    
    //Setting up the video for the main page
    NSString *mainPageVideoPath = [[NSBundle mainBundle] pathForResource:@"MainPageVideo" ofType:@"mp4"];
    NSURL *mainPageVideoURL = [NSURL fileURLWithPath:mainPageVideoPath];
    [self addChildViewController:self.mainPageVideoController];
    [self.view addSubview:self.mainPageVideoController.view];
    AVPlayer *mainPageVideoPlayer = [[AVPlayer alloc] initWithURL:mainPageVideoURL];
    [self.mainPageVideoController setPlayer:mainPageVideoPlayer];
    [mainPageVideoPlayer pause];
    
    //Setting up label on the main page
    NSString *mainPageHeading = @"Welcome to \n the Houston Asian-American Archives";
    NSString *mainPageText = @"The Houston Asian-American Archives is an award-winning digital record of Houston Asian-Americans with the aim of preserving their unique cultural legacy.";
    self.titleLabel.text = mainPageHeading;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.numberOfLines = 0;
    //self.titleLabel.textColor = [UIColor whiteColor];
    //self.titleLabel.backgroundColor = [UIColor colorWithRed:0.0 green:36.0/255.0 blue:106.0/255.0 alpha:1];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.text = mainPageText;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    //self.textLabel.textColor = [UIColor whiteColor];
    //self.textLabel.backgroundColor = [UIColor colorWithRed:0.0 green:36.0/255.0 blue:106.0/255.0 alpha:1];
    self.textLabel.numberOfLines = 0;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:self.textLabel];
    [self.view addSubview:self.titleLabel];
    
    //Setting up the "new interviews" table in the main page
    self.mainNewTableView.dataSource = self;
    self.mainNewTableView.delegate = self;
    [self.view addSubview:self.mainNewTableView];
    self.mainNewTableView.clipsToBounds = YES;
    
    //Setting up the header bar text
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Trajan Pro" size:20], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.0 green:36.0/255.0 blue:106.0/255.0 alpha:1]];

}


#pragma mark - Table Functions
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return 5;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"You recently viewed: ";
    }
    return @"Our latest interviews: ";
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *newCellIdentifier = @"mainNewPageCell";
    UITableViewCell *individualCell = [self.mainNewTableView dequeueReusableCellWithIdentifier:newCellIdentifier];
    individualCell.textLabel.text = @"Temporary";
    if (individualCell == nil) {
        individualCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:newCellIdentifier];
    }
    return individualCell;
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
