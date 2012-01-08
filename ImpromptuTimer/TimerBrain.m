//
//  TimerBrain.m
//  ImpromptuTimer
//
//  Created by Maximilian Tagher on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TimerBrain.h"

@implementation TimerBrain



- (id)init
{
    self = [super init];
    return self;
}

//Converts total seconds to a minutes:seconds format
//  70 seconds => 01:10
//Returns 60:00 for time over an hour long
- (NSString *)convertSecondsToDisplay:(int) seconds
{
        
    seconds = abs(seconds);
    int one=0, two=0, three=0, four=0;
    //One through Four corresponds to its position on the display, One being seconds, Two being tens of seconds, etc. 
    // Four Three : Two One
    
    
    if (seconds >= 3600)   
        return @"60:00";  
    else if (seconds >= 600) {  // 10 minutes
        four = seconds / 600;
        seconds %= 600;
        three = seconds / 60;
        seconds %= 60;
        one = seconds % 10;
        seconds /= 10;
        two = seconds % 10;
        seconds /= 10;
    }
    else if (seconds >=60) {    // 1 minute
        three = seconds / 60;
        seconds %= 60;
        one = seconds % 10;
        seconds /= 10;
        two = seconds % 10;
        seconds /= 10;
    } else {
        one = seconds % 10;     // < 1 minute
        seconds /= 10;
        two = seconds % 10;
        seconds /= 10;
    }
    return [NSString stringWithFormat:@"%i%i:%i%i", four, three, two, one];
    
}




@end
