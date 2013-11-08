//
//  DetailViewController.h
//  MasterDetail
//
//  Created by Paul Pilone on 11/8/13.
//  Copyright (c) 2013 Element 84, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
