//
//  ModelSelectTableViewController.m
//  Reservá
//
//  Created by Yifei Zhou on 9/9/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#import "ModelSelectTableViewController.h"

@interface ModelSelectTableViewController ()

@property (nonatomic, readonly) NSArray *models;

@end

@implementation ModelSelectTableViewController

- (NSArray *)models
{
    return @[
             @{@"iPhone 7 32GB 黑色": @"MNGQ2CH/A"},
             @{@"iPhone 7 32GB 银色": @"MNGR2CH/A"},
             @{@"iPhone 7 32GB 金色": @"MNGT2CH/A"},
             @{@"iPhone 7 32GB 玫瑰金色": @"MNGW2CH/A"},
             @{@"iPhone 7 128GB 黑色": @"MNGX2CH/A"},
             @{@"iPhone 7 128GB 银色": @"MNGY2CH/A"},
             @{@"iPhone 7 128GB 金色": @"MNH02CH/A"},
             @{@"iPhone 7 128GB 玫瑰金色": @"MNH12CH/A"},
             @{@"iPhone 7 128GB 亮黑色": @"MNH22CH/A"},
             @{@"iPhone 7 256GB 黑色": @"MNH32CH/A"},
             @{@"iPhone 7 256GB 银色": @"MNH42CH/A"},
             @{@"iPhone 7 256GB 金色": @"MNH52CH/A"},
             @{@"iPhone 7 256GB 玫瑰金色": @"MNH62CH/A"},
             @{@"iPhone 7 256GB 亮黑色": @"MNH72CH/A"},
             @{@"iPhone 7 Plus 128GB 黑色": @"MNFP2CH/A"},
             @{@"iPhone 7 Plus 128GB 银色": @"MNFQ2CH/A"},
             @{@"iPhone 7 Plus 128GB 金色": @"MNFR2CH/A"},
             @{@"iPhone 7 Plus 128GB 玫瑰金色": @"MNFT2CH/A"},
             @{@"iPhone 7 Plus 128GB 亮黑色": @"MNFU2CH/A"},
             @{@"iPhone 7 Plus 256GB 黑色": @"MNFV2CH/A"},
             @{@"iPhone 7 Plus 256GB 银色": @"MNFW2CH/A"},
             @{@"iPhone 7 Plus 256GB 金色": @"MNFX2CH/A"},
             @{@"iPhone 7 Plus 256GB 玫瑰金色": @"MNFY2CH/A"},
             @{@"iPhone 7 Plus 256GB 亮黑色": @"MNG02CH/A"},
             @{@"iPhone 7 Plus 32GB 黑色": @"MNRJ2CH/A"},
             @{@"iPhone 7 Plus 32GB 银色": @"MNRK2CH/A"},
             @{@"iPhone 7 Plus 32GB 金色": @"MNRL2CH/A"},
             @{@"iPhone 7 Plus 32GB 玫瑰金色": @"MNRM2CH/A"},
             ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Stores";
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"reuseIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    // Configure the cell...
    NSDictionary *model = self.models[indexPath.row];
    cell.textLabel.text = model.allKeys.firstObject;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = model.allValues.firstObject;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *model = self.models[indexPath.row];
    NSString *modelString = model.allValues.firstObject;
    
    if (!modelString) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    
    if (!indexPath) return;
    
    NSDictionary *model = self.models[indexPath.row];
    
    UIViewController *viewController = [segue destinationViewController];
    if ([viewController isKindOfClass:NSClassFromString(@"AvailabilityTableViewController")]) {
        [viewController setValue:model.allValues.firstObject forKey:@"modelString"];
    }
}

@end
