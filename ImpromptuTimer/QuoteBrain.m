//
//  QuoteBrain.m
//  ImpromptuTimer
//
//  Created by Maximilian Tagher on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QuoteBrain.h"

@implementation QuoteBrain

- (id)randomQuote
{
    NSUInteger length = [quoteList count];
    int random;
    do {
        random = arc4random() % length;
    } while (random == lastQuote);
    lastQuote = random;
    return [quoteList objectAtIndex:random];
}


- (id)init
{
    self = [super init];
    if (self) {
        quoteList = [NSMutableArray arrayWithObjects:
                     @"Death leaves a heartache no one can heal, love leaves a memory no one can steal.  ~From a headstone in Ireland",
                     @"Philosophy triumphs easily over past evils and future evils; but present evils triumph over it. ~La Rochefoucauld, Maxims, 1678",
                     @"Correct English is the slang of prigs who write history and essays.  ~George Eliot, Middlemarch, 1872",
                     @"It is almost impossible to remember how tragic a place this world is when one is playing golf.  ~Robert Lynd",
                     @"It takes 8,460 bolts to assemble an automobile, and one nut to scatter it all over the road.  ~Author unknown, as seen on a bumper sticker",
                     @"Draft beer, not people.  ~Author Unknown",
                     @"The hunger for love is much more difficult to remove than the hunger for bread.  ~Mother Teresa",
                     @"Infatuation is when you think he's as sexy as Robert Redford, as smart as Henry Kissinger, as noble as Ralph Nader, as funny as Woody Allen, and as athletic as Jimmy Conners.  Love is when you realize that he's as sexy as Woody Allen, as smart as Jimmy Connors, as funny as Ralph Nader, as athletic as Henry Kissinger and nothing like Robert Redford - but you'll take him anyway.  ~Judith Viorst, Redbook, 1975",
                     @"Isn't it a violation of the Georgia sodomy law for the Supreme Court to have its head up its ass?  ~Letter to Playboy magazine, February 1987",
                     @"No government has the right to tell its citizens when or whom to love.  The only queer people are those who don't love anybody.  ~Rita Mae Brown, speech, 28 August 1982",
                     @"I believe in equality for everyone, except reporters and photographers.  ~Gandhi",
                     @"I hold it to be the inalienable right of anybody to go to hell in his own way.  ~Robert Frost",
                     @"The Framers of the Bill of Rights did not purport to \"create\" rights.  Rather, they designed the Bill of Rights to prohibit our Government from infringing rights and liberties presumed to be preexisting.  ~Justice William J. Brennan, 1982",
                     @"From beasts we scorn as soulless,\nIn forest, field and den,\nThe cry goes up to witness,\nThe soullessness of men.\n~M. Frida Hartley",
                     @"Flip a coin; you'll know what side you're hoping for. ~Arnold Rothstein (on choice)",
                     nil];
        
    }
    return self;
}




@end
