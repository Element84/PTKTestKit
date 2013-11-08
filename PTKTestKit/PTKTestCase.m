//
//  PTKTestCase.m
//  PTKTestKit
//
//  Created by Paul Pilone on 11/7/13.
//  Copyright (c) 2013 Paul Pilone. All rights reserved.
//

#import "PTKTestCase.h"

#import <objc/runtime.h>

@implementation PTKTestCase

/*
 
*/
+ (id)defaultTestSuite
{
    // Initialize the test suite. This suite will contain multiple test cases for each
    // invocation (or example) of either a test or outline test.
    SenTestSuite *suite = [[SenTestSuite alloc] initWithName:NSStringFromClass([self class])];
    
    NSArray *testInvocations = [self testInvocations];
    for (NSInvocation *invocation in testInvocations) {
        if ([NSStringFromSelector(invocation.selector) hasPrefix:@"outlineTest"]) {
            // Build examples and create test cases for each example using this invocation.
            NSArray *examples = [self examplesForOutlineTestWithSelector:invocation.selector];
            if (examples && [examples count]) {
                SenTestSuite *outlineSuite = [[SenTestSuite alloc] initWithName:NSStringFromSelector(invocation.selector)];
                
                for (PTKOutlineExample *example in examples) {
                    [outlineSuite addTest:[self testCaseWithSelector:invocation.selector outlineExample:example]];
                }
                
                [suite addTest:outlineSuite];
            }
        }
        else {
            // Just a plain ole test invocation.
            [suite addTest:[self testCaseWithSelector:invocation.selector]];
        }
    }
    
    return suite;
}

+ (NSArray *)examplesForOutlineTestWithSelector:(SEL)selector
{
    return @[];
}

/*
 
*/
+ (PTKTestCase *)testCaseWithSelector:(SEL)selector outlineExample:(PTKOutlineExample *)example
{
    PTKTestCase *testCase = [self testCaseWithSelector:selector];
    testCase.example = example;
    
    return testCase;
}

/*
 
*/
+ (NSArray *)testInvocations
{
    NSMutableArray *mutableTestInvocations = [[super testInvocations] mutableCopy];
    
    unsigned int methodCount;
    Method* methods = class_copyMethodList([self class], &methodCount);
    for (int i = 0; i < methodCount; i++)
    {
        SEL selector = method_getName(methods[i]);
        NSString* name = NSStringFromSelector(selector);
        if ([name hasPrefix:@"outlineTest"]) {
            NSMethodSignature *methodSignature = [self instanceMethodSignatureForSelector:selector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
            invocation.selector = selector;
            
            [mutableTestInvocations addObject:invocation];
        }
    }

    return mutableTestInvocations;
}

/*
 
*/
- (NSString *)description
{
    NSInvocation *invocation = [self invocation];
    NSString *testName = NSStringFromSelector(invocation.selector);
    if ([testName hasPrefix:@"outlineTest"]) {
        // Join together any words in the example name (CamelCasing for better readability).
        NSString *name = self.example.name;
        NSArray *words = [name componentsSeparatedByString:@" "];
        name = @"";
        for (NSString *word in words) {
            if ([word length] < 1)
            {
                continue;
            }
            name = [name stringByAppendingString:[[word substringToIndex:1] uppercaseString]];
            name = [name stringByAppendingString:[word substringFromIndex:1]];
        }
        
        return [NSString stringWithFormat:@"-[%@ %@%@]", NSStringFromClass([self class]), NSStringFromSelector(invocation.selector), name];
    }
    else {
        return [super description];
    }
}
@end
