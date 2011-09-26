//
//  MyScrollView.h
//  MPOViewer
//
//  Created by Baron Karl on 11/09/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>
@class MPOViewerAppDelegate;

@interface MyScrollView : NSScrollView
{
    MPOViewerAppDelegate* appDelegate;
}

@property (nonatomic, assign) IBOutlet MPOViewerAppDelegate* appDelegate;
@end
