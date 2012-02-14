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
    int timerCount;     //Master count incremented by starting timer; always counts up.
    
    int mainDisplayCount; //Largest timer Display
    int speechCount;    //Time spent speaking (middle value in top right corner)
    
    
    BOOL timerStarted; 
    BOOL timerGoing;
    TimerBrain *brain;
    QuoteBrain *quoteBrain;
    BOOL countUp;
    BOOL inPrep;
}

@property (weak, nonatomic) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *prepDisplay;
@property (weak, nonatomic) IBOutlet UILabel *speakDisplay;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (weak, nonatomic) IBOutlet UIButton *endPrepButton;

@property (weak, nonatomic) IBOutlet UIView *background;
@property (weak, nonatomic) IBOutlet UITextView *quoteField;
@property (weak, nonatomic) IBOutlet UIImageView *whiteLine;



- (void)increaseTimerCount;

- (void)toggleResetButton; //Modify reset button

- (void)stopTimer;

- (IBAction)startTimer:(id)sender;

- (IBAction)endPrep:(id)sender;

- (IBAction)newQuote:(id)sender;


@end
