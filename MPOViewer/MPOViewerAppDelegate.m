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

    [self loadImage:test];
}

-(void)loadImage:(NSImage*)img {
    view1.image = img;
    view1.offset = 0;
    [view1 clearCache];
    
    view2.image = img;
    view2.offset = 1;
    [view2 clearCache];
    
    [view1 setNeedsDisplay:YES];
    [view2 setNeedsDisplay:YES];
}

@end
