//
//  XLNoDataView.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "XLNoDataView.h"

@interface XLNoDataView()

@property (nonatomic,strong)UILabel *messageLab;
@property (nonatomic,strong)UIImageView *noDataIV;

@end



@implementation XLNoDataView
NSString *message=@"暂无相关数据";
NSString *imageName=@"icon_Nodata";

-(instancetype)initWithFrame:(CGRect )frame AndMessage:(NSString *)msg ImageName:(NSString *)imgName
{
    if (msg) {
        message=msg;
    }
    if (imgName) {
        imageName=imgName;
    }

   return [self initWithFrame:frame];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

-(void)setUpSubviews
{
    self.noDataIV=[[UIImageView alloc] init];
    [_noDataIV setImage:KImage(imageName)];
    [self addSubview:self.noDataIV];
    self.messageLab=[[UILabel alloc] init];
    [_messageLab setFont:KNSFONT(14)];
    [_messageLab setTextColor:RGB(102, 102, 102)];
    [_messageLab setText:message];
    [_messageLab setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_messageLab];
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    NSInteger i;
    kScreen_Width>375?(i=3):(i=2);
    CGFloat fixelW = CGImageGetWidth([UIImage imageNamed:imageName].CGImage)/i;
    CGFloat fixelH = CGImageGetHeight([UIImage imageNamed:imageName].CGImage)/i;

    YLog(@"%f,%f",fixelW,fixelH);
    CGFloat x=kScreen_Height-self.bounds.size.height;
    [self.noDataIV setFrame:CGRectMake((kScreen_Width-fixelW)/2.0, (kScreen_Height-fixelH-15-Height(8))/2.0-x, fixelW, fixelH)];
    [self.messageLab setFrame:CGRectMake(0, (kScreen_Height-fixelH-15-Height(8))/2+fixelH+Height(8)-x, kScreen_Width, 15)];
}

@end
