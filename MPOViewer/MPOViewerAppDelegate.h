//
//  MPOViewerAppDelegate.h
//  MPOViewer
//
//  Created by Baron Karl on 11/09/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MPOView.h"

@interface MPOViewerAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    MPOView* view1;
    MPOView* view2;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic,retain) IBOutlet MPOView* view1;
@property (nonatomic,retain) IBOutlet MPOView* view2;

-(void)loadImage:(NSImage*)img;

@end
