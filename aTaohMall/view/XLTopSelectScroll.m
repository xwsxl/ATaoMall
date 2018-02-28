//
//  XLTopSelectScroll.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/25.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "XLTopSelectScroll.h"
@interface XLTopSelectScroll ()

@property (nonatomic,strong)NSArray *DataArr;
@property (nonatomic,strong)UIFont *XLFont;
@property (nonatomic,assign)CGFloat scrollWidth;
@property (nonatomic,assign)CGFloat scrollHeight;
@property (nonatomic,assign)CGFloat ButWidth;

@end


@implementation XLTopSelectScroll


-(instancetype)initWithWith:(CGRect)XLrect AndDataArr:(NSArray *)dataArr AndFont:(UIFont *)font
{

    if (dataArr) {
        _DataArr=dataArr;
    }
    if (font) {
        _XLFont=font;
    }

    _scrollWidth=XLrect.size.width;

    return [self initWithFrame:XLrect];
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
    self.showsVerticalScrollIndicator=NO;
    self.showsHorizontalScrollIndicator=NO;
    [self setBackgroundColor:[UIColor whiteColor]];

    CGFloat butWidth=[self getButWidthWithArray:self.DataArr];
    for (int i=0; i<self.DataArr.count; i++) {

        UILabel *TopLabel = [[UILabel alloc] initWithFrame:CGRectMake(butWidth*i, (45-20)/2, butWidth, 20)];
        TopLabel.text = self.DataArr[i];
        TopLabel.textColor = [UIColor colorWithRed:48/255.0 green:47/255.0 blue:47/255.0 alpha:1.0];
        TopLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        TopLabel.textAlignment = NSTextAlignmentCenter;
        TopLabel.tag = 100 + i;
        [self addSubview:TopLabel];

        UIButton *topButon = [UIButton buttonWithType:UIButtonTypeCustom];
        topButon.frame = CGRectMake(butWidth*i, 0, butWidth, 45);
        topButon.tag = 200+i;
        [topButon addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:topButon];
    }

    CGSize textSize = [self.DataArr[0] boundingRectWithSize:CGSizeMake(butWidth, 3) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFang-SC-Regular" size:14]} context:nil].size;

    UIView *_slider = [[UIView alloc] init];
    _slider.frame = CGRectMake((butWidth-textSize.width)/2, 45-3, textSize.width, 3);
    _slider.backgroundColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    _slider.tag = 10001;
    [self addSubview:_slider];

    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, butWidth*self.DataArr.count, 1)];

    line.image = [UIImage imageNamed:@"分割线-拷贝"];

    [self addSubview:line];
    self.bounces=NO;
    self.contentSize=CGSizeMake(butWidth*self.DataArr.count, 45);

}
//切换了顶部一个类型
-(void)topBtnClick:(UIButton *)sender
{
    [self selectedIndexType:sender.tag-200];
}

-(void)selectedIndexType:(NSInteger )index
{
    NSInteger selectIndex=index;
    //判断index的位置--主要是手势操作时用到
    if (index>self.DataArr.count-1) {
        selectIndex=self.DataArr.count-1;
        return;
    }else if(index<0)
    {
        selectIndex=0;
        return;
    }
    selectIndex=index;


    CGSize textSize = [self.DataArr[selectIndex] boundingRectWithSize:CGSizeMake(self.ButWidth, 3) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFang-SC-Regular" size:14]} context:nil].size;

    UIView *slider = [self viewWithTag:10001];
    [UIView animateWithDuration:0.25 animations:^{
        slider.frame = CGRectMake((_ButWidth-textSize.width)/2+_ButWidth*selectIndex, 45-3, textSize.width, 3);
    } completion:nil];


    //选中居中
    CGFloat scollWidth=0;
    scollWidth=(selectIndex-2)*_ButWidth;
    if (scollWidth<0) {
        scollWidth=0;
    }
    else if (scollWidth>(self.contentSize.width-_scrollWidth))
    {
        scollWidth=self.contentSize.width-_scrollWidth;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.contentOffset=CGPointMake(scollWidth, 0);

        for (int i=0; i<self.DataArr.count; i++) {
        UILabel *lab=[self viewWithTag:100+i];
            if (i==selectIndex) {

            lab.textColor=RGB(255, 93, 94);
            }else
            {
                lab.textColor=RGB(51, 51, 51);
            }
        }


    }];

    if (_XLdelegate&&[_XLdelegate respondsToSelector:@selector(DidSelectTopIndex:)]) {
        [_XLdelegate DidSelectTopIndex:selectIndex];
    }
}


//获取按钮宽度
-(CGFloat)getButWidthWithArray:(NSArray *)arr
{
    CGFloat butWidth=0;
    if (arr.count<5) {
        butWidth=_scrollWidth*1.0/arr.count;
    }else
    {
        butWidth=_scrollWidth*1.0/5;
    }
    _ButWidth=butWidth;
    return butWidth;

}

//懒加载数据源
-(NSArray *)DataArr
{
    if (!_DataArr) {
        _DataArr=[[NSArray alloc] init];
    }
    return _DataArr;
}
//懒加载字体型号
-(UIFont *)XLFont
{
    if (!_XLFont) {
        _XLFont=KNSFONTM(15);
    }
    return _XLFont;

}

-(CGFloat)ButWidth
{
    if (!_ButWidth) {
        _ButWidth=0;
    }
    return _ButWidth;
}

-(CGFloat)scrollWidth
{
    if (!_scrollWidth) {
        _scrollWidth=0;
    }
    return _scrollWidth;
}
@end
