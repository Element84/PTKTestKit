//
//  PTKDetailViewController.m
//  PTKTestKit
//
//  Created by Paul Pilone on 11/6/13.
//  Copyright (c) 2013 Paul Pilone. All rights reserved.
//

#import "PTKDetailViewController.h"

@interface PTKDetailViewController ()
- (void)configureView;
@end

@implementation PTKDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = self.detailItem[@"value"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
