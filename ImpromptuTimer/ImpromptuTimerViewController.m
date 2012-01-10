//
//  ImpromptuTimerViewController.m
//  ImpromptuTimer
//
//  Created by Maximilian Tagher on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ImpromptuTimerViewController.h"

@implementation ImpromptuTimerViewController

@synthesize timeLabel = _timeLabel;
@synthesize timer = _timer;
@synthesize prepDisplay = _prepDisplay;
@synthesize speakDisplay = _speakDisplay;
@synthesize resetButton = _resetButton;
@synthesize startStopButton = _startStopButton;
@synthesize endPrepButton = _endPrepButton;
@synthesize background = _background;
@synthesize quoteField = _quoteField;
@synthesize whiteLine = _whiteLine;
@synthesize totalTime = _totalTime;


//I think a better way to display the time when counting down is to do the math. 
//Benefit of this is that I can still show the total time. 

//maybe turn speak time red if it is under 4 minutes?

- (void) increaseTimerCount
{
    timerCount += 1;
    
    if (!brain)
        brain = [[TimerBrain alloc] init];
    
    speechTimeInMin = 7;
    
    int speechTimeInSeconds = (speechTimeInMin*60);
    
    if (countUp == YES) {
        mainDisplayCount = timerCount;
    } else {
        mainDisplayCount = speechTimeInSeconds - timerCount;
        
        if (mainDisplayCount == 0) {
            _timeLabel.textColor = [UIColor redColor];
            _speakDisplay.textColor = [UIColor redColor];
        }
    }
    
    if (inPrep == YES) {
        _prepDisplay.text = [brain convertSecondsToDisplay:timerCount];
        if (timerCount >= 180) 
            _prepDisplay.textColor = [UIColor redColor];
            
    } else {
        speechCount += 1;
        _speakDisplay.text = [brain convertSecondsToDisplay:speechCount];
    }
    
    _timeLabel.text = [brain convertSecondsToDisplay:mainDisplayCount];
    _totalTime.text = [brain convertSecondsToDisplay:timerCount];
    
    //Over 7 minutes
    if (timerCount >= 420)
        _totalTime.textColor = [UIColor redColor];
}

//This Button switches between Start/Stop functionality, to mimic the familiar functionality of the native stopwatch
- (IBAction)startTimer:(id)sender
{
    if (timerGoing == NO) {
        
        timerStarted = YES;
        timerGoing = YES;
        [self updateButtons];

        //Switch to Stop Button Display
        [_startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [_startStopButton setBackgroundImage:[UIImage imageNamed:@"red.png"] forState: UIControlStateNormal];
        
        //Start timer
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(increaseTimerCount) userInfo:nil repeats:YES];
    } 
    
    else if (timerGoing == YES) {
        
        //Switch to Start Button Display
        [_startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        [_startStopButton setBackgroundImage:[UIImage imageNamed:@"startTest.png"] forState: UIControlStateNormal];
        
        //Stop Timer
        timerGoing = NO;
        [_timer invalidate];
        NSLog(@"stopping timer");
    }
}

- (void)stopTimer 
{
    if (timerGoing == YES) {
        [_startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        [_startStopButton setBackgroundImage:[UIImage imageNamed:@"startTest.png"] forState: UIControlStateNormal];
        timerGoing = NO;
        [_timer invalidate];
        NSLog(@"stopping timer");
    }
    
}


//handle main display count?
- (IBAction)resetTimer 
{
    inPrep = YES;
    countUp = YES;
    timerStarted = NO;
    if (timerGoing == YES)
    {
        [self stopTimer];
    }
    timerCount = 0;
    speechCount = 0;
    
    _prepDisplay.text = @"00:00";
    _timeLabel.text = @"00:00";
    _speakDisplay.text = @"00:00";
    _totalTime.text = @"00:00";
    _timeLabel.textColor = [UIColor whiteColor];
    _speakDisplay.textColor = [UIColor whiteColor];
    _prepDisplay.textColor = [UIColor whiteColor];
    _endPrepButton.titleLabel.alpha = 1;
    _endPrepButton.enabled = YES;
    [self updateButtons];

    
}


//This button ends "Prep Time" (counting up, by convention) and immediately enters "Speaking Time" (counting down, by convention). 
- (IBAction)endPrep:(id)sender
{
    if (inPrep == YES) {
        if (!brain)
            brain = [[TimerBrain alloc] init];
        inPrep = NO;
        [self updateButtons];
        countUp = NO;
        
        //Because we shift from counting down to counting up, we need to calculate the new value for display
        // 2 minutes of prep used -> 5 minutes of speaking time left
        
        speechTimeInMin = 7; 
        int speechTimeInSeconds = (speechTimeInMin*60);
//        _prepDisplay.text = _timeLabel.text;        // Pretty sure this is unncessary
        mainDisplayCount = speechTimeInSeconds - timerCount;
        _timeLabel.text = [brain convertSecondsToDisplay: mainDisplayCount];
        
        //Disable "End Prep" Button
        _endPrepButton.titleLabel.alpha = .5;
        _endPrepButton.enabled = NO;
        
        
        //As of now, total time is always 7 minutes, but upcoming rule changes may change total time depending on the round. If this was the case, I would need to add settings features to modify total time. For now this is unncessary. 
    }
    
}

- (void)addToCounters:(double) value
{
    
    // Is the 'int toAdd' really necessary? Pretty sure I don't need it. 
    
    // This relates to the updating after home button
    
    if (timerGoing == YES) {
        int toAdd = value;
        timerCount += toAdd;
        if (inPrep == YES)
        {
            NSLog(@"should add this to prep");
        }    
        else {
            speechCount += toAdd;
        }
    }
}

//Generates a new quotation 
- (IBAction)newQuote:(id)sender 
{
    if (!quoteBrain)
        quoteBrain = [[QuoteBrain alloc] init];
             
    _quoteField.text = [quoteBrain randomQuote];
}


- (void)viewDidUnload {
    [self setPrepDisplay:nil];
    [self setSpeakDisplay:nil];
    [self setResetButton:nil];
    [self setStartStopButton:nil];
    [self setEndPrepButton:nil];
    [self setBackground:nil];
    [self setQuoteField:nil];
    [self setWhiteLine:nil];
    [self setTotalTime:nil];
    [super viewDidUnload];
}

//Apply UI and prepare for use
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"dark_leather.png"]];
    
    [[_startStopButton layer] setCornerRadius:8.0f];
    [[_startStopButton layer] setMasksToBounds:YES];
    [[_startStopButton layer] setBorderWidth:2.5f];
    
    [[_whiteLine layer] setCornerRadius:1.0];
    [[_whiteLine layer] setMasksToBounds:YES];
    
    
    [self newQuote:(@"fix later")];
    countUp = YES;
    inPrep = YES;
    [self updateButtons];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //MyApplicationDelegate *appDelegate = (MyApplicationDelegate *)[[UIApplication sharedApplication] delegate]
    //ImpromptuTimerAppDelegate *appDelegate = (ImpromptuTimerAppDelegate *) [[UIApplication sharedApplication] delegate];
    //int addToTimer = appDelegate.timeSinceExit;
    NSLog(@"View Controller");
    //NSLog(@"%i",addToTimer);
    [super viewWillAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
	
    NSLog(@"test");
    [super viewWillDisappear:animated];
}


//rename to 'update Reset Button' 
- (void) updateButtons
{
    if (timerStarted == YES || inPrep == NO) {
        _resetButton.titleLabel.alpha = 1;
        _resetButton.enabled = YES;
       
    } else {
            _resetButton.titleLabel.alpha = .5;
            _resetButton.enabled = NO;
    }
}
@end
