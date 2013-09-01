//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Shiyong Fang on 8/16/13.
//  Copyright (c) 2013 Shiyong Fang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView
@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;
@end
