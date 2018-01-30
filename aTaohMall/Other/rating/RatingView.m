//
//  RatingView.m
//  NetworkDemo05
//
//

#import "RatingView.h"

@implementation RatingView
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 10)];
        _bgImageView.image = [UIImage imageNamed:@"StarsBackground"];
        _frontImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 10)];
        _frontImageView.image = [UIImage imageNamed:@"StarsForeground"];
        // 居左停靠 超出边界剪切
        _frontImageView.contentMode = UIViewContentModeLeft;
        _frontImageView.clipsToBounds = YES;
        
        [self addSubview:_bgImageView];
        [self addSubview:_frontImageView];
        
    }
    return self;
}

- (void)setRating:(CGFloat)rating
{
    _rating = rating;
    _frontImageView.frame = CGRectMake(0, 0, _rating/5*_bgImageView.frame.size.width, 10);
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
