//
//  CardGameViewController.h
//  Machismo
//
//  Created by Shiyong Fang on 6/25/13.
//  Copyright (c) 2013 Shiyong Fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

- (Deck *)createDeck;    // abstract
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card; // abstract

@property (nonatomic) NSUInteger startingCardCount;   // abstract


@end
