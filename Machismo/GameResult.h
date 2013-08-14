//
//  GameResult.h
//  Machismo
//
//  Created by Shiyong Fang on 8/13/13.
//  Copyright (c) 2013 Shiyong Fang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *)allGameResults; // of GameResult

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

@end
