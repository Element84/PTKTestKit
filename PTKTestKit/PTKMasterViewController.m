//
//  PTKMasterViewController.m
//  PTKTestKit
//
//  Created by Paul Pilone on 11/6/13.
//  Copyright (c) 2013 Paul Pilone. All rights reserved.
//

#import "PTKMasterViewController.h"

#import "PTKDetailViewController.h"

@interface PTKMasterViewController ()
@property NSArray *objects;
@end

@implementation PTKMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *sampleDataPath = [[NSBundle mainBundle] pathForResource:@"sample-data" ofType:@"json"];
    self.objects = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:sampleDataPath] options:0 error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    if (indexPath.row == 0) {
        cell.textLabel.text = @"Test Static Row";
    }
    else {
        NSDictionary *object = self.objects[indexPath.row - 1];
        cell.textLabel.text = object[@"name"];
    }

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

        if ([self.tableView indexPathForSelectedRow].row == 0) {
            [[segue destinationViewController] setDetailItem:@{@"value" : @"Static Row"}];
        }
        else {
            NSDictionary *object = self.objects[indexPath.row - 1];
            [[segue destinationViewController] setDetailItem:object];
        }
    }
}

@end
