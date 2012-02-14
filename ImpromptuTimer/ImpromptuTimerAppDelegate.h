//
//  ImpromptuTimerAppDelegate.h
//  ImpromptuTimer
//
//  Created by Maximilian Tagher on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

extern NSString *kApplicationStateDidChange;

@interface ImpromptuTimerAppDelegate : UIResponder <UIApplicationDelegate>
{
    double exitTime;
    double timeSinceExit;    
}

@property double exitTime;
@property double timeSinceExit;
@property (strong, nonatomic) UIWindow *window;

@end
