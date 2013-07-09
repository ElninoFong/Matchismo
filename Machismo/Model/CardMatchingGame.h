//
//  CardMatchingGame.h
//  Machismo
//
//  Created by Shiyong Fang on 6/26/13.
//  Copyright (c) 2013 Shiyong Fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;

@property (nonatomic, readonly) int scorePerFlip;

@property (strong, nonatomic) NSMutableArray *comparedCards;

@property (nonatomic) int cardMode;
@end
