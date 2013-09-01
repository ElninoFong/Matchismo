//
//  PlayingCardCollectionView.h
//  Machismo
//
//  Created by Shiyong Fang on 8/31/13.
//  Copyright (c) 2013 Shiyong Fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
