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
    [test setCacheMode:NSImageCacheNever];

    NSRect r = NSRectFromCGRect(CGRectMake(0, 0, test.size.width, test.size.height));
//    view1.image = [[[test representations] objectAtIndex:0] CGImageForProposedRect:&r context:nil hints:nil];
//    view1.image = [[test representations] objectAtIndex:0];
    view1.image = test;
    view1.offset = 0;
    
//    view2.image = [[[test representations] objectAtIndex:1] CGImageForProposedRect:&r context:nil hints:nil];
//    view2.image = [[test representations] objectAtIndex:1];
    view2.image = test;
    view2.offset = 1;
    
    [view1 setNeedsDisplay:YES];
    [view2 setNeedsDisplay:YES];
}

@end
