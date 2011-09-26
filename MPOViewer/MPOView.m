//
//  MPOView.m
//  MPOViewer
//
//  Created by Baron Karl on 11/09/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MPOView.h"
#import "MPOViewerAppDelegate.h"

@implementation MPOView
@synthesize image;
@synthesize offset;
@synthesize cached;

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
        CGContextRelease(context2);
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
    
    CGFloat scale1 = image.size.width/self.bounds.size.width;
    CGFloat scale2 = image.size.height/self.bounds.size.height;
    CGFloat scale = scale1>scale2?scale1:scale2;
    CGRect bounds = CGRectZero;
    
    bounds.size.width = image.size.width/scale;
    bounds.size.height = image.size.height/scale;
    
    bounds.origin.x = self.bounds.size.width/2-(bounds.size.width/2);
    bounds.origin.y = self.bounds.size.height/2-(bounds.size.height/2);
    
    CGContextDrawImage(context, bounds, cached);
}

-(void)clearCache {
    if (!cached)
        return;
    
    CGImageRelease(cached);
    cached = nil;
}

#pragma mark drop

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType,nil]];
    }
    
    return self;
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) == NSDragOperationGeneric) {
        return NSDragOperationCopy;
    } else {
        return NSDragOperationNone;
    }
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    MPOViewerAppDelegate* appDelegate = (MPOViewerAppDelegate*)[[NSApplication sharedApplication] delegate]; 
    NSPasteboard *paste = [sender draggingPasteboard];
	//gets the dragging-specific pasteboard from the sender
    NSArray *types = [NSArray arrayWithObjects:NSFilenamesPboardType, nil];
	//a list of types that we can accept
    NSString *desiredType = [paste availableTypeFromArray:types];
    NSData *carriedData = [paste dataForType:desiredType];
	
    if (nil == carriedData) {
        return NO;
    } else {
        if ([desiredType isEqualToString:NSFilenamesPboardType]) {
            NSArray *fileArray = [paste propertyListForType:@"NSFilenamesPboardType"];
            NSString *path = [fileArray objectAtIndex:0];
            NSImage *newImage = [[NSImage alloc] initWithContentsOfFile:path];
			
            if (nil == newImage) {
				NSBeep();
                return NO;
            } else {
                [appDelegate loadImage:newImage withTitle:[path lastPathComponent]];
				[newImage release];
            }
        }
    }
    
    return YES;
}

@end
