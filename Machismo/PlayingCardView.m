 //
//  PlayingCardView.m
//  SuperCard
//
//  Created by Shiyong Fang on 8/16/13.
//  Copyright (c) 2013 Shiyong Fang. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.9
- (CGFloat)faceCardScaleFactor {
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit {
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
    _faceUp = faceUp;
    [self setNeedsDisplay]; 
}

- (void)setup {
    
}

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

#define CORNER_RADIUS 12.0
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    UIImage *faceImage = [UIImage imageNamed:@"cardfront.png"];
    CGRect imageRect = CGRectInset(self.bounds,
                                   self.bounds.size.width * (1.0 - [self faceCardScaleFactor]),
                                   self.bounds.size.height * (1.0 - [self faceCardScaleFactor]));
    [faceImage drawInRect:imageRect];
    
    [self drawCorners];
}

- (NSString *)rankAsString {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

#define FONT_SCALE 0.20
#define OFFSET_X 2.0
#define OFFSET_Y 2.0
- (void)drawCorners {
    if (self.faceUp) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        UIFont *cornerFont = [UIFont systemFontOfSize:self.bounds.size.width * FONT_SCALE];
        
        NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: cornerFont}];
        
        CGRect textBounds;
        textBounds.origin = CGPointMake(OFFSET_X, OFFSET_Y);
        textBounds.size = [cornerText size];
        
        [cornerText drawInRect:textBounds];
        
        [self pushContextAndRotateUpsideDown];
        [cornerText drawInRect:textBounds];
        [self popContext];
    } else {
        [[UIImage imageNamed:@"cardback.jpg"] drawInRect:self.bounds];
    }
}

- (void)pushContextAndRotateUpsideDown {
    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIGraphicsPushContext(context);
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)popContext {
//    UIGraphicsPopContext();
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded) {
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1;
    }
}

@end
