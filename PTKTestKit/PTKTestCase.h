//
//  PTKTestCase.h
//  PTKTestKit
//
//  Created by Paul Pilone on 11/7/13.
//  Copyright (c) 2013 Paul Pilone. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "PTKOutlineExample.h"

@interface PTKTestCase : SenTestCase

@property (nonatomic, strong) PTKOutlineExample *example;

+ (NSArray *)examplesForOutlineTestWithSelector:(SEL)selector;
+ (PTKTestCase *)testCaseWithSelector:(SEL)selector outlineExample:(PTKOutlineExample *)example;

@end
