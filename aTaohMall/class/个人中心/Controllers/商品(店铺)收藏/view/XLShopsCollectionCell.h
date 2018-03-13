//
//  XLShopsCollectionCell.h
//  aTaohMall
//
//  Created by Hawky on 2018/3/9.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantModel.h"
@interface XLShopsCollectionCell : UITableViewCell

@property (nonatomic,strong)UIImageView *shopIV;
@property (nonatomic,strong)UIImageView *moreIV;
@property (nonatomic,strong)UILabel *shopsNameLab;

@property (nonatomic,strong)MerchantModel *dataModel;

@end
