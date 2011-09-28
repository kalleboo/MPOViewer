//
//  MPOViewerAppDelegate.m
//  MPOViewer
//
//  Created by Baron Karl on 11/09/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MPOViewerAppDelegate.h"

@implementation MPOViewerAppDelegate

@synthesize imageWindow;
@synthesize listWindow;
@synthesize view1;
@synthesize view2;
@synthesize fileList;
@synthesize fileListTable;
@synthesize fileListScrollView;
@synthesize fullscreenPopup;
@synthesize effectStyleSelect;
@synthesize effectSlider;
@synthesize screensMenu;
@synthesize sliderAmt;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString* imageName = [[NSBundle mainBundle]
                           pathForResource:@"test" ofType:@"mpo"];
    NSImage* test = [[[NSImage alloc] initWithContentsOfFile:imageName] autorelease];

    [self loadImage:test withTitle:@"MPOViewer"];
    
    self.fileList = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rowSelected:) name:NSTableViewSelectionDidChangeNotification object:fileListTable];
    
	[fileListScrollView registerForDraggedTypes:[NSArray arrayWithObjects: NSFilenamesPboardType, nil]];
    
    [imageWindow makeKeyAndOrderFront:nil];
    [listWindow makeKeyAndOrderFront:nil];
    
    self.screensMenu = fullscreenPopup.menu;
    [screensMenu removeAllItems];
    int i = 1;
    for (NSScreen* screen in [NSScreen screens]) {
        NSRect frame = [screen frame];
        NSMenuItem* item = [[NSMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"%d: %1.0f x %1.0f",i++,frame.size.width,frame.size.height] action:@selector(changedFullscreenPopup:) keyEquivalent:@""];
        [screensMenu addItem:item];
        item.tag = i-1;
        [item release];
    }
    fullscreenPopup.menu = screensMenu;
    [screensMenu release];
}

-(void)loadImage:(NSImage*)img withTitle:(NSString*)title{
    imageWindow.title = title;
    
    view1.image = img;
    view1.offset = 0;
    [view1 clearCache];
    
    view2.image = img;
    view2.offset = 1;
    [view2 clearCache];
    
    [view1 setNeedsDisplay:YES];
    [view2 setNeedsDisplay:YES];
}


#pragma mark tableView

- (int)numberOfRowsInTableView:(NSTableView *)tableView {
	return [fileList count];
}
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row {
	if (row != -1) {
//        NSLog("%@",[[fileList objectAtIndex:row] lastPathComponent]);
		return [[fileList objectAtIndex:row] lastPathComponent];
	}
    
	return nil;
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex {
	return YES;
}

- (void)rowSelected:(NSNotification *)aNotification
{
    NSInteger row = [fileListTable selectedRow];
	if (row >= 0) {
        NSString* filename = [fileList objectAtIndex:row];
		[self loadImage:[[[NSImage alloc] initWithContentsOfFile:filename] autorelease] withTitle:[filename lastPathComponent]];
    }
}

#pragma mark toolbar

-(IBAction)changedFullscreenPopup:(id)sender {
    NSMenuItem* menu = (NSMenuItem*)sender;
    [imageWindow setStyleMask:NSBorderlessWindowMask];
    [imageWindow setFrame:((NSScreen*)[[NSScreen screens] objectAtIndex:menu.tag-1]).frame display:YES animate:YES];
}

-(IBAction)changedStyleSelect:(id)sender {
    NSLog(@"changedStyleSelect");
    NSBeep();
}

-(IBAction)changedEffectSlider:(id)sender {
    view1.frame = NSMakeRect(-[sliderAmt floatValue], 0, view1.frame.size.width, view1.frame.size.height);
    view2.frame = NSMakeRect([sliderAmt floatValue], 0, view1.frame.size.width, view1.frame.size.height);
}


#pragma mark dragndrop

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
    NSLog(@"dropped");
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
            for (NSString* path in [paste propertyListForType:@"NSFilenamesPboardType"]) {
                [fileList addObject:path];
                [fileListTable reloadData];
            }
        }
    }
    
    return YES;
}


@end
