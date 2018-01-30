//
//  CartAttributeCell.h
//  aTaohMall
//
//  Created by JMSHT on 2016/12/29.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopModel.h"


@class ShopModel;

@protocol ShopTableViewCellSelectDelegate <NSObject>
/** 选择按钮点击事件 */
- (void)cellSelectBtnClick:(UIButton *)sender;
/** 删除按钮点击事件 */
- (void)deleteShopGoodTouch:(UIButton *)sender;
/** 增减数量按钮点击事件 */
- (void)changeShopCount:(NSString *)sender SidWithString:(NSString *)sid DetailWithString:(NSString *)detailId Type:(NSString *)type Goods_Type:(NSString *)goods_type;
/** 手动输入数量 */
- (void)tableViewScroll:(UITextField *)textField SidWithString:(NSString *)sid DetailWithString:(NSString *)detailId Goods_Type:(NSString *)goods_type;
/** 手动输入商品件数，键盘不掉下，点击编辑完成 */
-(void)tableViewChangeNumber:(UITextField *)textField Sid:(NSString *)sid Number:(NSString *)number DetailId:(NSString *)detailId Goods_Type:(NSString *)goods_type;
/** 选择商品规格点击事件 */
- (void)changeShopDetail:(UIButton *)detailView Img:(NSString *)img Gid:(NSString *)gid Count:(NSString *)count Stock:(NSString *)stock Money:(NSString *)money Integer:(NSString *)integer GoodType:(NSString *)goods_type Status:(NSString *)status SmallIds:(NSString *)smallIds Sid:(NSString *)sid TF:(NSString *)tf;

/**** 修改属性之后刷新数据 *****/

-(void)ChangAttributeLaterReloadData;
@end


@interface CartAttributeCell : UITableViewCell

@property(nonatomic,strong) UIButton *SelectButton;

@property(nonatomic,strong) UIImageView *LogoImgView;

@property(nonatomic,strong) UILabel *GoodsNameLabel;

@property(nonatomic,strong) UILabel *AttributeLabel;

@property(nonatomic,strong) UILabel *PriceLabel;//有属性价格

@property(nonatomic,strong) UILabel *NewPriceLabel;//无属性价格

@property(nonatomic,strong) UILabel *NumberLabel;

@property(nonatomic,strong) UILabel *NewNumberLabel;

@property(nonatomic,strong) UIView *TextFieldView;//修改数量

@property(nonatomic,strong) UIView *NewTextFieldView;//无属性修改数量

@property(nonatomic,strong) UIButton *add;//加

@property(nonatomic,strong) UIImageView *line;//分割线

@property(nonatomic,strong) UIButton *Newadd;//无属性加

@property(nonatomic,strong) UIButton *reduce;//减

@property(nonatomic,strong) UIButton *Newreduce;//无属性减

@property(nonatomic,strong) UITextField *numberTF;

@property(nonatomic,strong) UITextField *NewnumberTF;

@property(nonatomic,strong) UIView *AttributeView;//属性输入框

@property(nonatomic,strong) UILabel *ChangeAttributeLabel;

@property(nonatomic,strong) UIImageView *RedImgViewKuang;//库存不足红色框

@property(nonatomic,strong) UILabel *StockNoMuchLabel;//库存不足文本

@property(nonatomic,strong) UIButton *ChangeAttribute;//修改属性

@property(nonatomic,strong) UIButton *deleteButton;//删除

@property(nonatomic,copy) NSString *YTString;//判断价格隐藏

@property(nonatomic,copy) NSString *NewDetailId;//判断价格隐藏

@property(nonatomic,copy) NSString *MyDetailId;//判断价格隐藏

@property(nonatomic,copy) NSString *ChangeStock;//判断价格隐藏
//从外部传入model
@property(nonatomic, strong)ShopModel *model;

@property (nonatomic, weak) id<ShopTableViewCellSelectDelegate>delegate;

/** cell编辑状态 */
@property (nonatomic, assign) BOOL shopCellEditState;
/** 选择按钮的选择状态 */
@property (nonatomic, assign) BOOL shopCellSelectBtnState;
/** 删除按钮的状态 */
@property (nonatomic, assign) BOOL shopCellDeleteBtnState;

/** 获取商品价格 */
- (NSInteger)getShopPrice;


@end
