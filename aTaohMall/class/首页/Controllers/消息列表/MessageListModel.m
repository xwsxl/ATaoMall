//
//  MessageListModel.m
//  aTaohMall
//
//  Created by DingDing on 2017/9/30.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "MessageListModel.h"

@implementation MessageListModel
/**
 Description 消息cell展开闭合时切换cell高度
 
 @param isOpen 是否展开
 */
- (void)setIsOpen:(BOOL)isOpen {
    
    _isOpen = isOpen;
    _height = _isOpen ? _open_height : _close_height;
}

/**
 Description 计算messageCell在使用此模型时对应的高度
 
 @return cell高度
 */
- (CGFloat)height {
    
    if (!_height) {
        
        
        UIFont *contentFont = KNSFONT(12);
        
        //cell中一行标题两行内容与上下边距的高度
        CGFloat text_height = contentFont.lineHeight*3;
        //消息内容限制size
        CGSize content_size = CGSizeMake(kScreen_Width-50, MAXFLOAT);
        //计算消息内容的长度
        CGFloat content_height = [_content sizeWithFont:contentFont maxSize:content_size].height;
        
        //如果消息内容超过两行 展开高度等于全部高度 初始高度&闭合高度等于文本默认高度
        if (content_height > 3 * contentFont.lineHeight) {
            
            _height = _close_height =60+text_height + 20;
            _open_height = content_height + 60 +20;
    
            //消息内容少于两行 全部高度与头像高度比较 取大
        } else {
            
            CGFloat height = content_height+60+20;
            _height = _open_height = _close_height = height;
            
        }
    }
    return _height;
}




@end
