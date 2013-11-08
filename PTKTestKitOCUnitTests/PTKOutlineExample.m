//
//  PTKOutlineExample.m
//  PTKTestKit
//
//  Created by Paul Pilone on 11/7/13.
//  Copyright (c) 2013 Paul Pilone. All rights reserved.
//

#import "PTKOutlineExample.h"

@interface PTKOutlineExample ()
@property (nonatomic, strong) NSMutableDictionary *mutableValues;
@end

@implementation PTKOutlineExample

/*
 
*/
+ (NSArray *)outlineExamplesFromResource:(NSString *)resourceName bundle:(NSBundle *)bundle error:(NSError *__autoreleasing *)error
{
    NSBundle *targetBundle = bundle == nil ? [NSBundle mainBundle] : bundle;
    NSString *resourcePath = [targetBundle pathForResource:resourceName ofType:@"json"];
    
    if (resourcePath == nil) {
        // TODO: Return error.
        return nil;
    }
    
    NSData *resourceData = [NSData dataWithContentsOfFile:resourcePath options:0 error:error];
    if (resourceData == nil) {
        return nil;
    }
    
    NSArray *exampleInfos = [NSJSONSerialization JSONObjectWithData:resourceData options:0 error:error];
    if (exampleInfos == nil) {
        return nil;
    }
    
    // Create and return a list of examples using the 'name' key provided in the resource.
    NSMutableArray *examples = [NSMutableArray arrayWithCapacity:[exampleInfos count]];
    for (NSDictionary *info in exampleInfos) {
        [examples addObject:[self outlineExampleNamed:info[@"name"] values:info]];
    }
    
    return examples;
}

/*
 
*/
+ (instancetype)outlineExampleNamed:(NSString *)name values:(NSDictionary *)params
{
    return [[self alloc] initWithName:name values:params];
}

/*
 
*/
- (id)initWithName:(NSString *)name values:(NSDictionary *)params
{
    self = [super init];
    if (self) {
        _name = name;
        _mutableValues = [params mutableCopy];
    }
    
    return self;
}

/*
 
*/

- (id)objectForKeyedSubscript:(id <NSCopying>)key
{
    return self.mutableValues[key];
}

/*
 
 */
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    [self.mutableValues setObject:obj forKey:key];
}

/*
 
*/
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", [super description], [self.mutableValues description]];
}

@end
