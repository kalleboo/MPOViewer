//
//  MPOViewerAppDelegate.h
//  MPOViewer
//
//  Created by Baron Karl on 11/09/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MPOView.h"
#import "MyScrollView.h"

@interface MPOViewerAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *imageWindow;
    NSWindow *listWindow;
    MPOView* view1;
    MPOView* view2;
    NSMutableArray* fileList;
    NSTableView* fileListTable;
    MyScrollView* fileListScrollView;
    NSPopUpButton* fullscreenPopup;
    NSSegmentedControl* effectStyleSelect;
    NSSlider* effectSlider;
    NSMenu* screensMenu;
}

@property (assign) IBOutlet NSWindow *imageWindow;
@property (assign) IBOutlet NSWindow *listWindow;
@property (nonatomic,retain) IBOutlet MPOView* view1;
@property (nonatomic,retain) IBOutlet MPOView* view2;
@property (nonatomic,retain) NSMutableArray* fileList;
@property (nonatomic,retain) IBOutlet NSTableView* fileListTable;
@property (nonatomic,retain) IBOutlet MyScrollView* fileListScrollView;;
@property (nonatomic,retain) IBOutlet NSPopUpButton* fullscreenPopup;
@property (nonatomic,retain) IBOutlet NSSegmentedControl* effectStyleSelect;
@property (nonatomic,retain) IBOutlet NSSlider* effectSlider;
@property (nonatomic,retain) IBOutlet NSMenu* screensMenu;

-(void)loadImage:(NSImage*)img withTitle:(NSString*)title;

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender;
- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender;
- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender;

-(IBAction)changedFullscreenPopup:(id)sender;
-(IBAction)changedStyleSelect:(id)sender;
-(IBAction)changedEffectSlider:(id)sender;

@end
