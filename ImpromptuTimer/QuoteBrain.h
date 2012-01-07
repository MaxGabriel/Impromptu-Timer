//
//  QuoteBrain.h
//  ImpromptuTimer
//
//  Created by Maximilian Tagher on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuoteBrain : NSObject {
    int lastQuote;
    NSMutableArray *quoteList;
}


- (id)randomQuote;


@end
