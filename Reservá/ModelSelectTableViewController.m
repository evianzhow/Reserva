//
//  ModelSelectTableViewController.m
//  Reservá
//
//  Created by Yifei Zhou on 9/9/16.
//  Copyright © 2016 Aladdin Inc. All rights reserved.
//

#import "ModelSelectTableViewController.h"
#import "Model.h"
@import SDWebImage;

@interface ModelSelectTableViewController ()

@property (nonatomic, strong) Model *sharedModel;

@end

@implementation ModelSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Models";
    
    self.sharedModel = [Model sharedModel];
    
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
    return self.sharedModel.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"reuseIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSDictionary *model = self.sharedModel.models[indexPath.row];

    // Configure the cell...
    UILabel *modelNameLabel = [cell viewWithTag:1];
    UILabel *modelNumberLabel = [cell viewWithTag:2];
    UIImageView *colorSwatchImageView = [cell viewWithTag:3];
    
    modelNameLabel.text = model.allValues.firstObject[@"name"];
    modelNumberLabel.textColor = [UIColor lightGrayColor];
    modelNumberLabel.text = model.allKeys.firstObject;
    
    [colorSwatchImageView sd_setImageWithURL:[NSURL URLWithString:model.allValues.firstObject[@"colorSwatch"]]];
    colorSwatchImageView.layer.cornerRadius = 4.0f;
    colorSwatchImageView.layer.shouldRasterize = YES;
    colorSwatchImageView.clipsToBounds = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *model = self.sharedModel.models[indexPath.row];
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
    
    NSDictionary *model = self.sharedModel.models[indexPath.row];
    
    UIViewController *viewController = [segue destinationViewController];
    if ([viewController isKindOfClass:NSClassFromString(@"ModelAvailabilityTableViewController")]) {
        [viewController setValue:model.allKeys.firstObject forKey:@"modelString"];
    }
}

@end
