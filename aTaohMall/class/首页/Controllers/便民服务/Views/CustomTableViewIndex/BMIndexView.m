//
//  BMIndexView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/3.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "BMIndexView.h"

@interface BMIndexView ()

@property (nonatomic, assign) CGSize textLayerSize;
@property (nonatomic, copy) NSArray *indexList;

@end
@implementation BMIndexView


- (void)layoutSubviews{
    [super layoutSubviews];
//    _indexList = [self getTableViewIndexList];
    _indexList = self.GameArrM;
    _textLayerSize = CGSizeMake(self.bounds.size.width, self.frame.size.height/_indexList.count);
    [_indexList enumerateObjectsUsingBlock:^(NSString *indexStr, NSUInteger idx, BOOL * _Nonnull stop) {
        CATextLayer *layer = [self textLayerWithText:indexStr Frame:CGRectMake(0, idx*_textLayerSize.height, _textLayerSize.width, _textLayerSize.height)];
        [self.layer addSublayer:layer];
        
    }];
}

- (CATextLayer*)textLayerWithText:(NSString*)title Frame:(CGRect)frame{
    CATextLayer *layer = [CATextLayer layer];
    layer.frame = frame;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.string = title;
    layer.foregroundColor = self.textColor.CGColor;
    CFStringRef fontName = (__bridge CFStringRef)_textFont.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    layer.font = fontRef;
    layer.fontSize = _textFont.pointSize;
    CGFontRelease(fontRef);
    layer.contentsScale = [UIScreen mainScreen].scale;
    return layer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self sendTouchEventToDelegate:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [self sendTouchEventToDelegate:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_cusIndexViewDelegate tableViewIndexTouchEnd];
    
}
- (void)sendTouchEventToDelegate:(UIEvent*)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    NSInteger index = (NSInteger)(touchPoint.y/_textLayerSize.height);
    
    if (index < 0 || index > _indexList.count-1) {
        return;
    }
    [_cusIndexViewDelegate selectedIndex:index sectionTitle:_indexList[index]];
}

-(NSArray *)getTableViewIndexList {
    
    return @[@"热",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M"];
    //    return @[@"热",@"A",@"B"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
