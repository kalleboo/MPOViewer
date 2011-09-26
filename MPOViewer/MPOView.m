//
//  MPOView.m
//  MPOViewer
//
//  Created by Baron Karl on 11/09/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MPOView.h"

@implementation MPOView
@synthesize image;
@synthesize offset;

- (id)initWithFrame:(NSRect)frame image:(NSImage*)inImg offset:(int)offs
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = inImg;
        offset = offs;
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGFloat width = self.bounds.size.width;
    
    CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    CGContextBeginPath(context);
    for (CGFloat y = offset; y<self.bounds.size.height; y+=2) {
        CGContextMoveToPoint(context, 0, y);
        CGContextAddLineToPoint(context, width,y);
        CGContextAddLineToPoint(context, width,y+1);
        CGContextAddLineToPoint(context, 0,y+1);
    }
    CGContextClip(context);

    [[image.representations objectAtIndex:offset] drawInRect:[self bounds]];
    NSLog(@"drew %d",offset);
}

@end
