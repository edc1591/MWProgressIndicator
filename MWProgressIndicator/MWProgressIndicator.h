//
//  MWProgressIndicator.h
//  MWProgressIndicator
//
//  Created by Evan Coleman on 5/20/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MWProgressIndicator : NSView

// The color of the progress indicator
// Default value is [NSColor blackColor]
@property (nonatomic, strong) NSColor *color;

// The color of the animation tick
// Default value is [NSColor lightGrayColor]
@property (nonatomic, strong) NSColor *tickColor;

// A readonly property indicating if the progress indicator is animating or not
@property (nonatomic, assign, readonly) BOOL isAnimating;

// Should the progress indicator animate of a separate thread
// Default value is YES
@property (nonatomic, assign) BOOL usesThreadedAnimation;

// Start animating
- (void)startAnimating;

// Stop animating
- (void)stopAnimating;

@end
