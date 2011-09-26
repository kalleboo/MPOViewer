//
//  MyScrollView.m
//  MPOViewer
//
//  Created by Baron Karl on 11/09/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView
@synthesize appDelegate;

- (NSDragOperation) draggingEntered:sender
{
    return [appDelegate draggingEntered:sender];
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    return [appDelegate performDragOperation:sender];
}


@end
