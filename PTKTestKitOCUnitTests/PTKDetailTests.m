//
//  PTKDetailTests.m
//  PTKTestKit
//
//  Created by Paul Pilone on 11/7/13.
//  Copyright (c) 2013 Paul Pilone. All rights reserved.
//

#import "PTKDetailTests.h"

#import <KIF/KIF.h>

@implementation PTKDetailTests

+ (NSArray *)examplesForOutlineTestWithSelector:(SEL)selector
{
    return [PTKOutlineExample outlineExamplesFromResource:@"sample-data" bundle:nil error:nil];
}

/*
 
*/
- (void)tearDownTestWithSelector:(SEL)testMethod
{
    if (testMethod == @selector(outlineTestForViewingDetail)) {
        NSLog(@"Tearing down outlineTestForViewingDetail");
    }
    else if (testMethod == @selector(testStaticRow)) {
        NSLog(@"Tearing down testStaticRow");
    }
    
    [tester tapViewWithAccessibilityLabel:@"Master" traits:UIAccessibilityTraitButton];
}

- (void)outlineTestForViewingDetail
{
    NSLog(@"INFORMATION: Example: %@", self.example[@"name"]);
    [tester tapViewWithAccessibilityLabel:self.example[@"name"] traits:UIAccessibilityTraitStaticText];
    [tester waitForViewWithAccessibilityLabel:self.example[@"value"] traits:UIAccessibilityTraitStaticText];
}

- (void)testStaticRow
{
    [tester tapViewWithAccessibilityLabel:@"Test Static Row" traits:UIAccessibilityTraitStaticText];
    [tester waitForViewWithAccessibilityLabel:@"Static Row" traits:UIAccessibilityTraitStaticText];
}

@end
