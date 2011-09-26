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
}

@property (nonatomic,retain) NSImage* image;
@property (nonatomic,assign) int offset;

- (id)initWithFrame:(NSRect)frame image:(NSImage*)image offset:(int)offset;
@end
