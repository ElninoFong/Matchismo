//
//  CardGameViewController.m
//  Machismo
//
//  Created by Shiyong Fang on 6/25/13.
//  Copyright (c) 2013 Shiyong Fang. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoresLabel;
@property (weak, nonatomic) IBOutlet UILabel *recordPerFlip;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSwitcher;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (IBAction)dealGame:(id)sender {
    self.modeSwitcher.enabled = YES;
    self.flipCount = 0;
    self.recordPerFlip.text = @"Enjoy!";
    self.game = nil;
    [self updateUI];
}

//- (void)viewDidLoad {
////    [self.modeSwitcher setFrame:CGRectMake(10, 10, 100, 30)];
//    self.modeSwitcher.tintColor = [UIColor whiteColor];
//}


- (IBAction)switchMode:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        // 2 cards mode
//        self.view.backgroundColor = [UIColor redColor];
        self.game.cardMode = 0;
    }
    else{
        // 3 cards mode
//        self.view.backgroundColor = [UIColor blueColor];
        self.game.cardMode = 1;
    }
}

- (void)updateUI {
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        if (card.isFaceUp) {
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else {
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        }
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = cardButton.enabled ? 1.0 : 0.3;
    }
    self.scoresLabel.text = [NSString stringWithFormat:@"Scores: %d", self.game.score];
//    NSLog(@"Scores update to %d", self.game.score);
    
    if (self.game.scorePerFlip > 0) {
        Card *card1 = self.game.comparedCards[0];
        Card *card2 = self.game.comparedCards[1];
        self.recordPerFlip.text = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card1.contents, card2.contents, self.game.scorePerFlip];
    } else if (self.game.scorePerFlip == -1) {
        Card *card = [self.game.comparedCards lastObject];
        self.recordPerFlip.text = [NSString stringWithFormat:@"Fliped up %@, %d ponit", card.contents, self.game.scorePerFlip];
    } else if (self.game.scorePerFlip < -1) {
        Card *card1 = self.game.comparedCards[0];
        Card *card2 = self.game.comparedCards[1];
        self.recordPerFlip.text = [NSString stringWithFormat:@"%@ & %@ don't match! %d points", card1.contents, card2.contents, self.game.scorePerFlip];
    }
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
//    NSLog(@"Flips update to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender {
    self.modeSwitcher.enabled = NO;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

@end
