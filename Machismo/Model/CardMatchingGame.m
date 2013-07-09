//
//  CardMatchingGame.m
//  Machismo
//
//  Created by Shiyong Fang on 6/26/13.
//  Copyright (c) 2013 Shiyong Fang. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) int scorePerFlip;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (NSMutableArray *)comparedCards {
    if (!_comparedCards) {
        _comparedCards = [[NSMutableArray alloc] init];
    }
    return _comparedCards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY -2
#define FLIP_COST -1

- (void)flipCardAtIndex:(NSUInteger)index {
    [self.comparedCards removeAllObjects];
    Card *card = [self cardAtIndex:index];
    [self.comparedCards addObject:card];
    self.scorePerFlip = 0;
    NSMutableArray *otherComparedCards = [[NSMutableArray alloc] init];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [self.comparedCards addObject:otherCard];
                    [otherComparedCards addObject:otherCard];
                    if ([self.comparedCards count]!=3 && self.cardMode==1) {
                        continue;
                    }
                    int matchScore = [card match:otherComparedCards];
                    if (matchScore) {
                        for (Card *comparedCard in self.comparedCards) {
                            comparedCard.unplayable = YES;
                        }
                        self.scorePerFlip = matchScore * MATCH_BONUS;
                        self.score += self.scorePerFlip;
                    } else {
                        for (Card *otherComparedCard in otherComparedCards) {
                            otherComparedCard.faceUp = NO;
                        }
                        self.scorePerFlip = MISMATCH_PENALTY;
                        self.score += self.scorePerFlip;
                    }
                    break;
                }
            }
            if (!self.scorePerFlip) {
                self.scorePerFlip = FLIP_COST;
            }
            self.score += FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

@end
