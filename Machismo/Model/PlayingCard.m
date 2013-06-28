//
//  PlayingCard.m
//  Machismo
//
//  Created by Shiyong Fang on 6/25/13.
//  Copyright (c) 2013 Shiyong Fang. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)rankStrings {
    static NSArray *rankStrigns = nil;
    if (!rankStrigns) {
        rankStrigns = @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    }
    return rankStrigns;
}

+ (NSArray *)validSuits {
    static NSArray *validSuits = nil;
    if (!validSuits) {
        validSuits = @[@"♠", @"♣", @"♥", @"♦"];
    }
    return validSuits;
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit] ) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank {
    return [self rankStrings].count - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    for (PlayingCard *card in otherCards) {
        if (card.rank == self.rank) {
            score = 4;
        } else if ([card.suit isEqualToString:self.suit]) {
            score = 1;
        }
    }
    return score;
}


@end
