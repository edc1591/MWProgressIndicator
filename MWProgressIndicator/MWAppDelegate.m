//
//  MWAppDelegate.m
//  MWProgressIndicator
//
//  Created by Evan Coleman on 5/20/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "MWAppDelegate.h"

@implementation MWAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)start:(id)sender {
    [self.progressIndicator startAnimating];
}

- (IBAction)stop:(id)sender {
    [self.progressIndicator stopAnimating];
}

@end
