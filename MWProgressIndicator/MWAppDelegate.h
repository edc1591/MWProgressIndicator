//
//  MWAppDelegate.h
//  MWProgressIndicator
//
//  Created by Evan Coleman on 5/20/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MWProgressIndicator.h"

@interface MWAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) IBOutlet MWProgressIndicator *progressIndicator;

- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;

@end
