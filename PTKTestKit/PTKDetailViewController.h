//
//  PTKDetailViewController.h
//  PTKTestKit
//
//  Created by Paul Pilone on 11/6/13.
//  Copyright (c) 2013 Paul Pilone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTKDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
