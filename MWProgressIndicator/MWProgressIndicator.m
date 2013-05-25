//
//  MWProgressIndicator.m
//  MWProgressIndicator
//
//  Created by Evan Coleman on 5/20/13.
//  Copyright (c) 2013 Evan Coleman. All rights reserved.
//

#import "MWProgressIndicator.h"

@interface MWProgressIndicator ()

@property (nonatomic, assign) NSInteger currentRay;
@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic, strong) dispatch_source_t animationQueue;
@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, assign) CGFloat rayLength;
@property (nonatomic, assign) CGFloat rayMargin;
@property (nonatomic, assign) CGFloat rayAngle;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) NSTimeInterval speed;

- (void)timerFired;

@end

@implementation MWProgressIndicator

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        self.color = [NSColor blackColor];
        self.tickColor = [NSColor lightGrayColor];
        self.isAnimating = NO;
        self.usesThreadedAnimation = YES;
        
        self.rayLength = 8.0f;
        self.rayMargin = 5.0f;
        self.rayAngle = M_PI / 4;
        self.lineWidth = 2.0f;
        self.speed = 0.08;
    }
    
    return self;
}

- (void)startAnimating {
    if(self.isAnimating == NO) {
        self.isAnimating = YES;
        self.currentRay = 0;
        if(self.usesThreadedAnimation) {
            _animationQueue = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
            dispatch_source_set_timer(_animationQueue, DISPATCH_TIME_NOW, self.speed * NSEC_PER_SEC, 0.25 * NSEC_PER_SEC);
            dispatch_source_set_event_handler(_animationQueue, ^{
                [self timerFired];
            });
            dispatch_resume(_animationQueue);
        } else {
            self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:self.speed target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        }
    }
}

- (void)stopAnimating {
    if(self.isAnimating == YES) {
        self.isAnimating = NO;
        if(self.usesThreadedAnimation) {
            dispatch_source_cancel(_animationQueue);
            self.animationQueue = nil;
        } else {
            [self.animationTimer invalidate];
            self.animationTimer = nil;
        }
        [self setNeedsDisplay:YES];
    }
}

#pragma mark - Private Methods

- (void)timerFired {
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
    
    //Draw border for testing
    //[[NSColor whiteColor] set];
    //[[NSBezierPath bezierPathWithRect:dirtyRect] fill];
    
    [self.color setStroke];
    
    //Draw circle
    CGFloat circleDiameter = dirtyRect.size.width * 0.3f;
    CGFloat circleX = (dirtyRect.size.width - circleDiameter) / 2;
    CGFloat circleY = (dirtyRect.size.height - circleDiameter) / 2;
    NSRect circleRect = NSMakeRect(circleX, circleY, circleDiameter, circleDiameter);
    NSBezierPath *circlePath = [NSBezierPath bezierPathWithOvalInRect:circleRect];
    circlePath.lineWidth = self.lineWidth;
    [circlePath stroke];
    
    NSPoint circleCenter = NSMakePoint(circleX + (circleDiameter / 2), circleY + (circleDiameter / 2));
    
    //NSLog(@"Center: %@", NSStringFromPoint(circleCenter));
    //NSLog(@"Diameter: %f", circleDiameter);
    
    //Draw rays
    NSUInteger rays = (2 * M_PI) / self.rayAngle;
    
    for(int i=0;i<rays;i++) {
        if(self.isAnimating && i == self.currentRay) {
            [self.tickColor setStroke];
        } else {
            [self.color setStroke];
        }
        NSBezierPath *raysPath = [NSBezierPath bezierPath];
        raysPath.lineWidth = self.lineWidth;
        [raysPath moveToPoint:circleCenter];
        CGFloat startX = (((circleDiameter / 2) + self.rayMargin) * cos(self.rayAngle * i));
        CGFloat startY = (((circleDiameter / 2) + self.rayMargin) * sin(self.rayAngle * i));
        
        CGFloat endX = (self.rayLength * cos(self.rayAngle * i));
        CGFloat endY = (self.rayLength * sin(self.rayAngle * i));
        //NSLog(@"Start: %f, End: %f",startDistance, endDistance);
        NSPoint startPoint = NSMakePoint(startX, startY);
        NSPoint endPoint = NSMakePoint(endX, endY);
        //NSLog(@"Start: %@, End: %@",NSStringFromPoint(startPoint), NSStringFromPoint(endPoint));
        [raysPath relativeMoveToPoint:startPoint];
        [raysPath relativeLineToPoint:endPoint];
        [raysPath stroke];
    }
    self.currentRay--;
    if(self.currentRay < 0) {
        self.currentRay = rays - 1;
    }
}

@end
