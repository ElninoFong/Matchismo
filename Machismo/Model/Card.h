//
//  Card.h
//  Machismo
//
//  Created by Shiyong Fang on 6/25/13.
//  Copyright (c) 2013 Shiyong Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
