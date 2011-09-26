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

    view1.image = test;
    view1.offset = 0;
    
    view2.image = test;
    view2.offset = 1;
    
    [view1 setNeedsDisplay:YES];
    [view2 setNeedsDisplay:YES];
}

@end
