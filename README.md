# PTKTestKit

Various classes built to make iOS testing faster, easier, and more effective. 

## Overview

PTKTestKit is a collection of classes intended to be used for unit and integration testing of iOS and OS X applications. All classes are built on top of SenTestingKit and fit nicely
into your current testing workflow. The goal is to make testing setup and execution in iOS and OS X as simple as possible in order to encourage and promote a culture of testing. Despite
the name, PTKTestKit is not a replacement for SenTestingKit or XCTestKit. It's designed to be used alongside these frameworks and is a fantastic addition to popular testing
frameworks such as [KIF](https://github.com/kif-framework/KIF).

PTKTestKit is built on `PTKTestCase`, which supports running a test method multiple times with different parameters for each run. In addition to standard SenTestCase test methods, test methods
prefixed with `outlineTest` will be executed for each example vended by your subclass. Each outline test is uniquely named, which allows each outline test run show up in Xcode 5's test navigator.

## Installation

The preferred way to install PTKTestKit will, eventually, be via the [CocoaPods](http://cocoapods.org) package manager. At the current commit the only way to install PTKTestKit is to 
clone the repository and copy source files into as needed into your project. When copying files into your project or workspace, make sure to add them to your test targets.

## Example

Once PTKTestKit is added to your project, it's time to start writing tests. The main class in PTKTestKit is the test case: `PTKTestCase` (subclass of `SenTestCase`). This class is similar to
SenTestCase with one big advantage: it allows you to define examples (parameters) for a specific test method. Test methods that support parameters must be prefixed with `outlineTest` and return `void`,
similar to how `SenTestCase` requires test methods to be prefixed with `test`. Examples are vended to an test outline by a subclass of PTKTestCase, and are distinguished by selector.

The first step is to create a new test case with outline tests. In our case we'll create a test case that verifies a simple master-detail based app. Note that this example uses [KIF](https://github.com/kif-framework/KIF), but
you can use PTKTestCase in any situation.

<em>PTKDetailTests.h</em>

``` objective-c
#import "PTKTestCase.h"

@interface PTKDetailTests : PTKTestCase
@end
```

<em>PTKDetailTests.m</em>

``` objective-c
#import "PTKDetailTests.h"

#import <KIF/KIF.h>

@implementation PTKDetailTests

+ (NSArray *)examplesForOutlineTestWithSelector:(SEL)selector
{
    return [PTKOutlineExample outlineExamplesFromResource:@"sample-data" bundle:nil error:nil];
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
```

The important methods to look at here are `+ (NSArray *)examplesForOutlineTestWithSelector:(SEL)selector` and `- (void)outlineTestForViewingDetail`. The test method
`- (void)testStaticRow` is an example of a standard SenTestCase test method, and shows how you can include both outline tests and tests in the same test case.

In `+ (NSArray *)examplesForOutlineTestWithSelector:(SEL)selector`, a selector is passed that represents an outline test method. Examples are created from a JSON file and returned as an array.
When this test case is executed, you'll notice in the test navigator that `outlineTestForViewingDetail` is run multiple times with a unique name for each run. Each run uses a single example.

`PTKOutlineExample` is the class used to provide values to each outline example. There are two convenience methods for 
initializing an example: `+ (NSArray *)outlineExamplesFromResource:(NSString *)resourceName bundle:(NSBundle *)bundle error:(NSError *__autoreleasing *)error`
and `+ (instancetype)outlineExampleNamed:(NSString *)name values:(NSDictionary *)params`. As you can tell, examples can be created from a JSON file or from an instance of
NSDictionary. This allows you to write example values inline or organze examples into sample data files.

It's important to note that examples require a 'name' value in order to uniquely identify an outline test. If exmaples are created from resource files, there <em>must</em> be a 'name' key/value. The resource
file used in the previous example looks like this:

``` json
[
 {
    "name" : "Test Foo",
    "value" : "Foo"
 },
 {
    "name" : "Test Bar",
    "value" : "Bar"
 }
]
```

## Limitations

Since outline test names are dynamically generated, there is no suppport for running an individual outline test and example via Xcode 5's test navigator.

## TODO

- [ ] Clean up repository (examples mixed in with source code)
- [ ] Create Podspec
- [ ] Provide better inline documentation
- [ ] Dynamically extend XCTestKit
- [ ] Add support for enabling/disabling examples in PTKTestCase
- [ ] Add copyright headers
- [ ] Better exception handling/reporting

## License

PTKTestKit is licensed under the terms of the [Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html). Please see the [LICENSE](LICENSE) file for full details.

## Credits

PTKTestKit is brought to you by [Paul Pilone](http://twitter.com/paulpilone). Support is provided by [Element 84](http://www.element84.com).

This solution was largely based on Brian Coyner's [OCUnit Parameterized Test Case](http://briancoyner.github.io/blog/2011/09/12/ocunit-parameterized-test-case/) example.
