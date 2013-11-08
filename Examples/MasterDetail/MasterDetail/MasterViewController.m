//
//  MasterViewController.m
//  MasterDetail
//
//  Created by Paul Pilone on 11/8/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController ()
@property (nonatomic, strong) NSArray *objects;
@end

@implementation MasterViewController

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

    if (indexPath.row < [self.objects count]) {
        NSDictionary *object = self.objects[indexPath.row];
        cell.textLabel.text = object[@"name"];
    }
    else {
        cell.textLabel.text = @"Test Static Row";
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        if ([self.tableView indexPathForSelectedRow].row < [self.objects count]) {
            NSDictionary *object = self.objects[indexPath.row];
            [[segue destinationViewController] setDetailItem:object];
        }
        else {
            [[segue destinationViewController] setDetailItem:@{@"value" : @"Static Row"}];
        }
    }
}

@end
