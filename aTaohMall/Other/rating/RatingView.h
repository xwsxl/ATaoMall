//
//  RatingView.h
//  NetworkDemo05
//
//

#import <UIKit/UIKit.h>

@interface RatingView : UIView

// 0 - 5
@property (nonatomic,assign) CGFloat rating;
@property (nonatomic,strong) UIImageView * bgImageView;
@property (nonatomic,strong) UIImageView * frontImageView;


@end
