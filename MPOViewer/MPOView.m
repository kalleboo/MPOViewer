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

- (void)drawRect:(NSRect)dirtyRect
{
    CGFloat width = self.bounds.size.width;
    
    if (!cached && image) {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        NSRect r = NSRectFromCGRect(CGRectMake(0, 0, image.size.width, image.size.height));
        
        CGContextRef context2 = CGBitmapContextCreate(NULL, image.size.width, image.size.height, 8, image.size.width*4, colorSpace, kCGImageAlphaPremultipliedLast);
        
        CGContextDrawImage(context2, r, [[[image representations] objectAtIndex:offset] CGImageForProposedRect:&r context:nil hints:nil]);

        cached = CGBitmapContextCreateImage(context2);
        
        CGColorSpaceRelease(colorSpace);
    }
    
    CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    
    CGContextBeginPath(context);
    for (CGFloat y = offset; y<self.bounds.size.height; y+=2) {
        CGContextMoveToPoint(context, 0, y);
        CGContextAddLineToPoint(context, width,y);
        CGContextAddLineToPoint(context, width,y+1);
        CGContextAddLineToPoint(context, 0,y+1);
    }
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height), cached);
}

@end
