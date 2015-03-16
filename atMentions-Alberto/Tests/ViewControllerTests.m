//
//  KeyboardTests.m
//  atMentions-Alberto
//
//  Created by Alberto Lagos on 16-03-15.
//  Copyright (c) 2015 Alberto Lagos. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ViewController.h"
#import "ViewController+Tests.h"

@interface ViewControllerTests : XCTestCase
@property (strong, nonatomic) ViewController *controller;
@end

@implementation ViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [storyboard instantiateViewControllerWithIdentifier:@"initialController"];
    [self.controller performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];

}

- (void)testFilterMentions
{
    NSString *textWithMentions = @"this is a test for @insertingName";
    
    NSArray *mentions = [self.controller findMentions:textWithMentions];
    
    XCTAssertTrue(mentions.count > 0);
    XCTAssertTrue([mentions[0] isEqualToString:@"@insertingName"]);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
