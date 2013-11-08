//
//  PTKOutlineExample.h
//  PTKTestKit
//
//  Created by Paul Pilone on 11/7/13.
//  Copyright (c) 2013 Paul Pilone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTKOutlineExample : NSObject

+ (NSArray *)outlineExamplesFromResource:(NSString *)resourceName bundle:(NSBundle *)bundle error:(NSError *__autoreleasing *)error;

+ (instancetype)outlineExampleNamed:(NSString *)name values:(NSDictionary *)params;
- (id)initWithName:(NSString *)name values:(NSDictionary *)params;

- (id)objectForKeyedSubscript:(id <NSCopying>)key;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

@property (nonatomic, readonly) NSString *name;

@end
