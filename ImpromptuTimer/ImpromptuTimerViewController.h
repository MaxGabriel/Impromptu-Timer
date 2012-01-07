//
//  ImpromptuTimerViewController.h
//  ImpromptuTimer
//
//  Created by Maximilian Tagher on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerBrain.h"
#import "ImpromptuTimerAppDelegate.h"
#import "QuoteBrain.h"

@interface ImpromptuTimerViewController : UIViewController
{
    int timerCount;
    int speechCount;
    int speechTimeInMin;
    BOOL timerStarted;
    BOOL timerGoing;
    TimerBrain *brain;
    QuoteBrain *quoteBrain;
    BOOL countUp;
    BOOL inPrep;
}

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *prepDisplay;
@property (weak, nonatomic) IBOutlet UILabel *speakDisplay;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (weak, nonatomic) IBOutlet UIButton *endPrepButton;
@property (weak, nonatomic) IBOutlet UIView *background;
@property (weak, nonatomic) IBOutlet UITextView *quoteField;


- (void) increaseTimerCount;

- (void) updateButtons;

- (void)stopTimer;

- (void)addToCounters:(double)value;

- (IBAction)startTimer:(id)sender;

- (IBAction)endPrep:(id)sender;

- (IBAction)newQuote:(id)sender;


@end
