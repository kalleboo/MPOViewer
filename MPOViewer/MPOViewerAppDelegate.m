//
//  MPOViewerAppDelegate.m
//  MPOViewer
//
//  Created by Baron Karl on 11/09/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MPOViewerAppDelegate.h"

@implementation MPOViewerAppDelegate

@synthesize window;
@synthesize view1;
@synthesize view2;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    NSString* imageName = [[NSBundle mainBundle]
                           pathForResource:@"test" ofType:@"mpo"];
    NSImage* test = [[NSImage alloc] initWithContentsOfFile:imageName];

//    self.view1 = [[MPOView alloc] initWithFrame:NSMakeRect(0, 0, 100, 100) image:test offset:0];
//    self.view2 = [[MPOView alloc] initWithFrame:NSMakeRect(0, 0, 100, 100) image:test offset:1];
    
    view1.image = test;
    view1.offset = 0;
    view2.image = test;
    view2.offset = 1;
    
    [view1 setNeedsDisplay:YES];
    [view2 setNeedsDisplay:YES];
}

@end
