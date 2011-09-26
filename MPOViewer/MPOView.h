//
//  MPOView.h
//  MPOViewer
//
//  Created by Baron Karl on 11/09/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MPOView : NSView
{
    NSImage* image;
    int offset;
    CGImageRef cached;
}

@property (nonatomic,assign) NSImage* image;
@property (nonatomic,assign) CGImageRef cached;
@property (nonatomic,assign) int offset;

@end
