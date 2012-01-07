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


- (void) increaseTimerCount
{
    if (countUp == YES) {
        timerCount += 1;
        
    } else {
        timerCount -= 1;
        if (timerCount == 0) {
            _timeLabel.textColor = [UIColor redColor];
            _speakDisplay.textColor = [UIColor redColor];
        }
    }
    
    if (!brain)
        brain = [[TimerBrain alloc] init];
    _timeLabel.text = [brain convertSecondsToDisplay:timerCount];
    
    if (inPrep == YES) {
        if (timerCount >= 180)
            _prepDisplay.textColor = [UIColor redColor];
        _prepDisplay.text = _timeLabel.text;
    } else {
        speechCount += 1;
        _speakDisplay.text = [brain convertSecondsToDisplay:speechCount];
    }
}

- (IBAction)startTimer:(id)sender
{
    if (timerGoing == NO) {
        timerStarted = YES;
        timerGoing = YES;
        [self updateButtons];
        //[stopButton setTitle:@"RTN TO ZERO" forState:UIControlStateNormal];
        [_startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [_startStopButton setBackgroundImage:[UIImage imageNamed:@"red.png"] forState: UIControlStateNormal];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(increaseTimerCount) userInfo:nil repeats:YES];
    } else if (timerGoing == YES) {
        [_startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        [_startStopButton setBackgroundImage:[UIImage imageNamed:@"startTest.png"] forState: UIControlStateNormal];
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
    _timeLabel.textColor = [UIColor whiteColor];
    _speakDisplay.textColor = [UIColor whiteColor];
    _prepDisplay.textColor = [UIColor whiteColor];
    _endPrepButton.titleLabel.alpha = 1;
    _endPrepButton.enabled = YES;
    [self updateButtons];

    
}


//this needs to enable the reset button
- (IBAction)endPrep:(id)sender
{
    if (inPrep == YES) {
        if (!brain)
            brain = [[TimerBrain alloc] init];
        inPrep = NO;
        [self updateButtons];
        countUp = NO;
        speechTimeInMin = 7;
        int speechTimeInSeconds = (speechTimeInMin*60);
        _prepDisplay.text = _timeLabel.text;
        timerCount = speechTimeInSeconds - timerCount;
        _timeLabel.text = [brain convertSecondsToDisplay:timerCount];
        _endPrepButton.titleLabel.alpha = .5;
        _endPrepButton.enabled = NO;
    }
    
}

- (void)addToCounters:(double) value
{
    if (timerGoing == YES){
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

- (IBAction)newQuote:(id)sender 
{
    NSString *quote;
    if (!quoteBrain)
        quoteBrain = [[QuoteBrain alloc] init];
    
    quote = [quoteBrain randomQuote];
             
    _quoteField.text = quote;
    
}





- (void)viewDidUnload {
    [self setPrepDisplay:nil];
    [self setSpeakDisplay:nil];
    [self setResetButton:nil];
    [self setStartStopButton:nil];
    [self setEndPrepButton:nil];
    [self setBackground:nil];
    [self setQuoteField:nil];
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"dark_leather.png"]];
    [[_startStopButton layer] setCornerRadius:8.0f];
    [[_startStopButton layer] setMasksToBounds:YES];
    [[_startStopButton layer] setBorderWidth:2.5f];
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

- (void) updateButtons
{
    if (timerStarted == YES || inPrep == NO) {
        _resetButton.titleLabel.alpha = 1;
        _resetButton.enabled = YES;
       
    } else
    {
            _resetButton.titleLabel.alpha = .5;
            _resetButton.enabled = NO;
            
            
            
    }
}
@end
