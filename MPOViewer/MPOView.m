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


static CGColorRef CGColorCreateFromNSColor (CGColorSpaceRef colorSpace, NSColor *color)
{
    NSColor *deviceColor = [color colorUsingColorSpaceName:NSDeviceRGBColorSpace];
    
    CGFloat components[4];
    [deviceColor getRed: &components[0] green: &components[1] blue:
     &components[2] alpha: &components[3]];
    
    return CGColorCreate (colorSpace, components);
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGFloat width = self.bounds.size.width;
    
    CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    /*
    CGColorRef cgColor = CGColorCreateFromNSColor(colorSpace, [NSColor clearColor]);
    
    CGContextSetFillColorWithColor(context, cgColor);
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextFillRect(context, self.bounds);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
     */
    
    if (!cached && image) {
        NSLog(@"caching...");
        NSLog(@"%f x %f",image.size.width,image.size.height);
        NSRect r = NSRectFromCGRect(CGRectMake(0, 0, image.size.width, image.size.height));
        CGContextRef context2 = CGBitmapContextCreate(NULL, image.size.width, image.size.height, 8, image.size.width*4, colorSpace, kCGImageAlphaPremultipliedLast);
        CGContextDrawImage(context2, r, [[[image representations] objectAtIndex:offset] CGImageForProposedRect:&r context:nil hints:nil]);
        cached = CGBitmapContextCreateImage(context2);
    }
    
    
//    NSRect r = self.bounds;
    
    NSLog(@"%@",image);
//    [image drawRepresentation:[image.representations objectAtIndex:offset] inRect:self.bounds];
 //       CGContextDrawImage(context2, self.bounds, [image CGImageForProposedRect:&r context:NULL hints:nil]);

//    [image drawInRect:[self bounds]];
    NSLog(@"drew %d %f",offset,self.bounds.size.height);

    CGContextBeginPath(context);
    for (CGFloat y = offset; y<self.bounds.size.height; y+=2) {
        CGContextMoveToPoint(context, 0, y);
        CGContextAddLineToPoint(context, width,y);
        CGContextAddLineToPoint(context, width,y+1);
        CGContextAddLineToPoint(context, 0,y+1);
    }
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height), cached);
    
    CGColorSpaceRelease(colorSpace);
    /*
    CGColorRelease (cgColor);
     */
}

@end
