//
//  CartAttributeCell.m
//  aTaohMall
//
//  Created by JMSHT on 2016/12/29.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "CartAttributeCell.h"

#import "UIImageView+WebCache.h"

#import "ShopModel.h"

#import "JRToast.h"

#import "UserMessageManager.h"//缓存数据

//#define <#macro#>

#define CellHeight [[UIScreen mainScreen] bounds].size.height*0.1799

#define CellWidth [UIScreen mainScreen].bounds.size.width*0.1733

#define AttributeViewWidth [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60-CellWidth-10
@interface CartAttributeCell ()<UITextFieldDelegate>
{
    
    
    
}
@end
@implementation CartAttributeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadMyCell];
    }
    return self;
}

-(void)loadMyCell
{
    
    self.SelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.SelectButton.frame=CGRectMake(20, (CellHeight-20)/2, 20, 20);
    self.SelectButton.userInteractionEnabled=YES;
    [self.SelectButton setBackgroundImage:[UIImage imageNamed:@"为勾选"] forState:UIControlStateNormal];
    [self.SelectButton setBackgroundImage:[UIImage imageNamed:@"勾"] forState:UIControlStateSelected];
    
//    self.SelectButton.frame=CGRectMake(0, 0, 40, 120);
//    self.SelectButton.userInteractionEnabled=YES;
//    [self.SelectButton setBackgroundImage:[UIImage imageNamed:@"New未选40x120"] forState:UIControlStateNormal];
//    [self.SelectButton setBackgroundImage:[UIImage imageNamed:@"New选中40x120"] forState:UIControlStateSelected];
    
    
//    self.SelectButton.selected=YES;
    
    [self.SelectButton addTarget:self action:@selector(HeaderEditBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:self.SelectButton];
    
    
    //红色框
    
    self.RedImgViewKuang = [[UIImageView alloc] initWithFrame:CGRectMake(45, 0, [UIScreen mainScreen].bounds.size.width-48, CellHeight-1)];
    
    self.RedImgViewKuang.image = [UIImage imageNamed:@"选中框"];
    
    [self addSubview:self.RedImgViewKuang];
    
    self.RedImgViewKuang.hidden=YES;
    
    
    self.LogoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, (CellHeight-CellHeight*0.8333)/2, CellHeight*0.8333, CellHeight*0.8333)];
    
    self.LogoImgView.image = [UIImage imageNamed:@"BGYT"];
    
    [self addSubview:self.LogoImgView];
    
    
    //商品名称
    self.GoodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CellHeight*0.8333+60, 10, [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60, 40)];
    self.GoodsNameLabel.numberOfLines=2;
    self.GoodsNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.GoodsNameLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    [self addSubview:self.GoodsNameLabel];
    
    
    // 修改数量View
    self.TextFieldView = [[UIView alloc] initWithFrame:CGRectMake(CellHeight*0.8333+60, 10, [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60-CellWidth-10, 29)];
    
    [self addSubview:self.TextFieldView];
    
    self.TextFieldView.hidden=YES;
    
    self.NewTextFieldView = [[UIView alloc] initWithFrame:CGRectMake(CellHeight*0.8333+60, (CellHeight-29)/2, [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60-CellWidth-10, 29)];
    
    [self addSubview:self.NewTextFieldView];
    
    self.NewTextFieldView.hidden=YES;
    
    UIImageView *Kuang = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.TextFieldView.frame.size.width, self.TextFieldView.frame.size.height)];
    
    Kuang.image = [UIImage imageNamed:@"边框"];
    
    [self.TextFieldView addSubview:Kuang];
    
    [self.NewTextFieldView addSubview:Kuang];
    
    
    //减
    self.reduce = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reduce.frame = CGRectMake(0, 0, 29, self.TextFieldView.frame.size.height);
    [self.reduce setTitle:@"" forState:0];
    [self.reduce setTitleColor:[UIColor blueColor] forState:0];
    [self.reduce setBackgroundImage:[UIImage imageNamed:@"减号666"] forState:0];
    [self.reduce addTarget:self action:@selector(ReduceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.TextFieldView addSubview:self.reduce];
    
    
    //减
    self.Newreduce = [UIButton buttonWithType:UIButtonTypeCustom];
    self.Newreduce.frame = CGRectMake(0, 0, 29, self.TextFieldView.frame.size.height);
    [self.Newreduce setTitle:@"" forState:0];
    [self.Newreduce setTitleColor:[UIColor blueColor] forState:0];
    [self.Newreduce setBackgroundImage:[UIImage imageNamed:@"减号666"] forState:0];
    [self.Newreduce addTarget:self action:@selector(NewReduceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.NewTextFieldView addSubview:self.Newreduce];
    
    
    //输入框
    self.numberTF = [[UITextField alloc] initWithFrame:CGRectMake(29, 0, self.TextFieldView.frame.size.width-58, self.TextFieldView.frame.size.height)];
    self.numberTF.textAlignment = NSTextAlignmentCenter;
//    self.numberTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.numberTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    self.numberTF.returnKeyType = UIReturnKeyDone;
    
    self.numberTF.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    self.numberTF.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.numberTF.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    [self.numberTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.numberTF.delegate = self;
    
    [self.TextFieldView addSubview:self.numberTF];
    
    
    
    self.NewnumberTF = [[UITextField alloc] initWithFrame:CGRectMake(29, 0, self.TextFieldView.frame.size.width-58, self.TextFieldView.frame.size.height)];
    self.NewnumberTF.textAlignment = NSTextAlignmentCenter;
//    self.NewnumberTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.NewnumberTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    self.NewnumberTF.returnKeyType = UIReturnKeyDone;
    
    self.NewnumberTF.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    self.NewnumberTF.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.NewnumberTF.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    [self.NewnumberTF addTarget:self action:@selector(NewtextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.NewnumberTF.delegate = self;
    
    [self.NewTextFieldView addSubview:self.NewnumberTF];
    
    
    
    //加
    self.add = [UIButton buttonWithType:UIButtonTypeCustom];
    self.add.frame = CGRectMake(self.TextFieldView.frame.size.width-29, 0, 29, self.TextFieldView.frame.size.height);
    [self.add setTitle:@"" forState:0];
    [self.add setTitleColor:[UIColor blueColor] forState:0];
    [self.add setBackgroundImage:[UIImage imageNamed:@"加号666"] forState:0];
    [self.add addTarget:self action:@selector(AddBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.TextFieldView addSubview:self.add];
    
    
    self.Newadd = [UIButton buttonWithType:UIButtonTypeCustom];
    self.Newadd.frame = CGRectMake(self.TextFieldView.frame.size.width-29, 0, 29, self.TextFieldView.frame.size.height);
    [self.Newadd setTitle:@"" forState:0];
    [self.Newadd setTitleColor:[UIColor blueColor] forState:0];
    [self.Newadd setBackgroundImage:[UIImage imageNamed:@"加号666"] forState:0];
    [self.Newadd addTarget:self action:@selector(NewAddBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.NewTextFieldView addSubview:self.Newadd];
    
    //属性
    self.AttributeView = [[UIView alloc] initWithFrame:CGRectMake(CellHeight*0.8333+60, CellHeight*0.5833, [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60-CellWidth-10, 29)];
    
    self.AttributeView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    [self addSubview:self.AttributeView];
    
    //属性文本
    self.ChangeAttributeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60-CellWidth-10-30, 20)];
    self.ChangeAttributeLabel.numberOfLines=1;
//    self.ChangeAttributeLabel.text = @"颜色：褐色；尺寸：均码；面料：棉";
    self.ChangeAttributeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.ChangeAttributeLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [self.AttributeView addSubview:self.ChangeAttributeLabel];
    
    //修改属性按钮
    self.ChangeAttribute = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ChangeAttribute.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60-CellWidth-10-20, 6, 17, 17);
    [self.ChangeAttribute setTitle:@"" forState:0];
    [self.ChangeAttribute setTitleColor:[UIColor blueColor] forState:0];
    [self.ChangeAttribute setBackgroundImage:[UIImage imageNamed:@"编辑-"] forState:0];
    [self.ChangeAttribute addTarget:self action:@selector(ChangeAttributeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.AttributeView addSubview:self.ChangeAttribute];
    
    //删除按钮
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-CellWidth, 0, CellWidth, CellHeight);
    [self.deleteButton setTitle:@"删除" forState:0];
    self.deleteButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    [self.deleteButton setTitleColor:[UIColor whiteColor] forState:0];
    [self.deleteButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:76/255.0 blue:77/255.0 alpha:1.0]];
    [self.deleteButton addTarget:self action:@selector(DeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteButton];
    
    
    //商品属性
    self.AttributeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CellHeight*0.8333+60, CellHeight*0.4166, [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60, 30)];
    self.AttributeLabel.numberOfLines=2;
    self.AttributeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:9];
    self.AttributeLabel.text=@"颜色：褐色；尺寸：均码；面料：棉";
    self.AttributeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self addSubview:self.AttributeLabel];
    
    //无属性商品价格
    self.NewPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CellHeight*0.8333+60, CellHeight*0.5833, [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60, 20)];
    self.NewPriceLabel.text=@"￥86.00+23.00积分";
    self.NewPriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.NewPriceLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [self addSubview:self.NewPriceLabel];
//    self.NewPriceLabel.hidden=YES;
    
    //商品数量
    self.NewNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, CellHeight*0.5833, 60, 20)];
    
    self.NewNumberLabel.text=@"x2";
    self.NewNumberLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.NewNumberLabel.textAlignment=NSTextAlignmentRight;
    self.NewNumberLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [self addSubview:self.NewNumberLabel];
    
    
    //有属性价格
    self.PriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CellHeight*0.8333+60, CellHeight*0.75-10, [UIScreen mainScreen].bounds.size.width-CellHeight*0.8333-60, 20)];
    self.PriceLabel.text=@"￥86.00+23.00积分";
    self.PriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.PriceLabel.textColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
    [self addSubview:self.PriceLabel];
    
    //商品数量
    self.NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, CellHeight*0.75-10, 60, 20)];
    
    self.NumberLabel.text=@"x2";
    self.NumberLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.NumberLabel.textAlignment=NSTextAlignmentRight;
    self.NumberLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [self addSubview:self.NumberLabel];
    
    
    self.StockNoMuchLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-120, CellHeight-18, 100, 15)];
    
    self.StockNoMuchLabel.text = @"库存只有1件";
    
    self.StockNoMuchLabel.textAlignment=NSTextAlignmentRight;
    
    self.StockNoMuchLabel.textColor=[UIColor redColor];
    
    self.StockNoMuchLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    [self addSubview:self.StockNoMuchLabel];
    
    self.StockNoMuchLabel.hidden=YES;
    
    
    self.line = [[UIImageView alloc] initWithFrame:CGRectMake(45, CellHeight-0.5, [UIScreen mainScreen].bounds.size.width-45, 0.5)];
    
    self.line.image = [UIImage imageNamed:@"分割线e2"];
    
    [self addSubview:self.line];
    
    
    //注册通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi6:) name:@"YTKeyBos" object:nil];
    
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi7:) name:@"changecellshuxing" object:nil];
    
    
    //属性框落下，修改属性按钮可以点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ButtonCanClick:) name:@"ButtonCanClick" object:nil];
    
    //购物车·刷新数据，键盘落下
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyBordReturnToCell:) name:@"KeyBordReturnToCell" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BackKeyBordReturnToCell:) name:@"BackKeyBordReturnToCell" object:nil];
    
}


//-(void)tongzhi6:(NSNotification *)text
//{
//    //键盘收起
//    [self endEditing:YES];
//    
//}

-(void)BackKeyBordReturnToCell:(NSNotification *)text
{
    
    NSLog(@"购物车·刷新数据，键盘落下");
    
    [self.NewnumberTF resignFirstResponder];
    [self.numberTF resignFirstResponder];
    
    
    [self endEditing:YES];
    
    
}


-(void)KeyBordReturnToCell:(NSNotification *)text
{
    
    NSLog(@"购物车·刷新数据，键盘落下");
    
    [self.NewnumberTF resignFirstResponder];
    [self.numberTF resignFirstResponder];
    
    
    [self endEditing:YES];
    
    
}

-(void)ButtonCanClick:(NSNotification *)text
{
    self.ChangeAttribute.enabled=YES;
    
}

-(void)tongzhi7:(NSNotification *)text
{
    
    self.ChangeAttribute.enabled=YES;
    
    //修改属性传入的库存
    self.ChangeStock = text.userInfo[@"textThree"];
    
//    self.NewDetailId = text.userInfo[@"textFour"];
    
   NSLog(@"==textOne===%@======%@=====%@===textFour===%@",text.userInfo[@"textOne"],text.userInfo[@"textTwo"],text.userInfo[@"textThree"],text.userInfo[@"textFour"]);
    
    
    NSArray *array = [text.userInfo[@"textOne"] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"''+ "]];
    
    
    NSMutableArray *arrM = [NSMutableArray new];
    
    for (NSString *str in array) {
        
        
        if (![str isEqualToString:@""]) {
            
            [arrM addObject:str];
            
        }
    }
    
    NSString *str = [arrM componentsJoinedByString:@","];
    
    NSArray *array1 = [str componentsSeparatedByString:@","];
    
    
    NSArray *array3 = [text.userInfo[@"textTwo"] componentsSeparatedByString:@" "];
    
//    NSLog(@"777777==%ld==%@=%@(unsigned long)",array3.count,array3[0],array3[1]);
    
//    NSLog(@"888888==%ld==%@=%@==%@(unsigned long)",array1.count,array1[0],array1[1],array1[2]);
    
    //判断回显修改的属性值
    
    if (array3.count==1) {
        
        
//        _model.attribute_str = [NSString stringWithFormat:@"%@：%@",array3[0],array1[1]];
        
    }else if (array3.count==2){
        

        
//        _model.attribute_str = [NSString stringWithFormat:@"%@：%@ %@：%@",array3[0],array1[1],array3[1],array1[2]];
        
    }else if (array3.count==3){
        
        
//        _model.attribute_str = [NSString stringWithFormat:@"%@：%@ %@：%@ %@：%@",array3[0],array1[1],array3[1],array1[2],array3[2],array1[3]];
        
        
    }else if (array3.count==4){
        
        
//        _model.attribute_str = [NSString stringWithFormat:@"%@：%@ %@：%@ %@：%@ %@：%@",array3[0],array1[1],array3[1],array1[2],array3[2],array1[3],array3[3],array1[4]];
        
    }
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(ChangAttributeLaterReloadData)]) {
        
        [_delegate ChangAttributeLaterReloadData];
        
    }
    
    
}


-(void)HeaderEditBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(cellSelectBtnClick:)]) {
        [self.delegate cellSelectBtnClick:sender];
    }
    
}

-(void)setYTString:(NSString *)YTString
{
    
    
}
//设置选择按钮的状态
- (void)setShopCellSelectBtnState:(BOOL)shopCellSelectBtnState{
    _shopCellSelectBtnState = shopCellSelectBtnState;
    self.SelectButton.selected = shopCellSelectBtnState;
}

//设置编辑状态
- (void)setShopCellEditState:(BOOL)shopCellEditState{
    _shopCellEditState = shopCellEditState;
    _GoodsNameLabel.hidden = shopCellEditState;
    _NewPriceLabel.hidden = shopCellEditState;
    _PriceLabel.hidden = shopCellEditState;
    _NumberLabel.hidden = shopCellEditState;
    _NewNumberLabel.hidden = shopCellEditState;
    _AttributeLabel.hidden = shopCellEditState;
    _AttributeView.hidden = !shopCellEditState;
//    _TextFieldView.hidden = !shopCellEditState;
    _deleteButton.hidden = !shopCellEditState;
    
    if (shopCellEditState) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//    _NewTextFieldView.hidden = !shopCellEditState;
//    _StockNoMuchLabel.hidden = shopCellEditState;
    
    NSNull *null = [[NSNull alloc] init];
    
    if ([_model.detailId isEqual:null]) {
        
        self.NewTextFieldView.hidden=!shopCellEditState;
        
        self.TextFieldView.hidden=YES;
        
    }else{
        
        
        self.NewTextFieldView.hidden=YES;
        
        self.TextFieldView.hidden=!shopCellEditState;
        
        
    }
    
    
    if (shopCellEditState==1) {
        
        _StockNoMuchLabel.hidden = YES;
        
    }else{
        
        if ([_model.number intValue] > [_model.stock intValue]) {
            
            _StockNoMuchLabel.hidden=NO;
            
            
        }else{
            
            _StockNoMuchLabel.hidden=YES;
            
            
        }
        
    }
    
    
}

//设置删除按钮的位置和编辑状态
- (void)setShopCellDeleteBtnState:(BOOL)shopCellDeleteBtnState{
    _shopCellDeleteBtnState = shopCellDeleteBtnState;
    if (shopCellDeleteBtnState == YES) {
        [UIView animateWithDuration:0.3f animations:^{
            
            
            _deleteButton.hidden = NO;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.3f animations:^{
            
            _deleteButton.hidden = YES;
            
        } completion:^(BOOL finished) {
        }];
    }
}

-(void)setModel:(ShopModel *)model
{
    
    
    
    _model = model;
    
    NSLog(@"===库存====%@====%@",_model.YYYYYYYYY,_model.TTTTTTTTT);
    
//    [self endEditing:YES];
//    
//    [self.NewnumberTF resignFirstResponder];
//    [self.numberTF resignFirstResponder];
    
    if ([_model.YYYYYYYYY isEqualToString:@"666"]) {
        
        self.RedImgViewKuang.hidden = NO;
        self.StockNoMuchLabel.hidden=NO;
        self.StockNoMuchLabel.text = [NSString stringWithFormat:@"(库存只有%@件)",_model.TTTTTTTTT];
        
        
    }else{
        
        self.RedImgViewKuang.hidden = YES;
        self.StockNoMuchLabel.hidden=YES;
        
    }
//    self.GoodsNameLabel.text=_model.name;
    
//    if ([_model.TTTTTTTTT intValue] < [_NewnumberTF.text intValue]) {
//        
//        _NewnumberTF.text = _model.TTTTTTTTT;
//        
//    }
    
}

//减
-(void)ReduceBtnClick:(UIButton *)sender
{
    [self endEditing:YES];
    
    
    if (self.ChangeStock.length==0) {
        
        
    }else{
        
        
        if ([_model.attribute isEqualToString:@"2"]) {
            
            
            _model.TTTTTTTTT =self.ChangeStock;
            
        }
        
        
    }
    
    NSLog(@"==111=减===%@",_model.TTTTTTTTT);
    
    if ([_numberTF.text intValue] <= [_model.TTTTTTTTT intValue]) {
        
        self.RedImgViewKuang.hidden = YES;
        self.StockNoMuchLabel.hidden=YES;
        
    }else{
        
        self.RedImgViewKuang.hidden = NO;
        self.StockNoMuchLabel.hidden=NO;
        self.StockNoMuchLabel.text = [NSString stringWithFormat:@"(库存只有%@件)",_model.TTTTTTTTT];
    }
    
    
    if ([_numberTF.text intValue] == 1) {
        
        _reduce.userInteractionEnabled = NO;
        
//        _reduce.enabled=NO;
        
        
    }else{
        
//        _reduce.enabled=YES;
        
        _numberTF.text = [NSString stringWithFormat:@"%d",[_numberTF.text intValue] - 1];
        
    }
    
    _model.count = _numberTF.text;
    
    _NumberLabel.text = [NSString stringWithFormat:@"x%@",_numberTF.text];
    
    if ([self.delegate respondsToSelector:@selector(changeShopCount:SidWithString:DetailWithString:Type:Goods_Type:)]) {
        [self.delegate changeShopCount:_numberTF.text SidWithString:_model.sid DetailWithString:_model.detailId Type:@"0" Goods_Type:_model.attribute];
    }
    
}

//减
-(void)NewReduceBtnClick:(UIButton *)sender
{
    [self endEditing:YES];
    
    if (self.ChangeStock.length==0) {
        
        
    }else{
        
        
        if ([_model.attribute isEqualToString:@"2"]) {
            
            _model.TTTTTTTTT =self.ChangeStock;
        }
        
        
    }
    
    
    NSLog(@"==222=减===%@",_model.TTTTTTTTT);
    
    if ([_NewnumberTF.text intValue] <= [_model.TTTTTTTTT intValue]) {
        
        self.RedImgViewKuang.hidden = YES;
        self.StockNoMuchLabel.hidden=YES;
        
    }else{
        
        self.RedImgViewKuang.hidden = NO;
        self.StockNoMuchLabel.hidden=NO;
        self.StockNoMuchLabel.text = [NSString stringWithFormat:@"(库存只有%@件)",_model.TTTTTTTTT];
    }
    
    
    if ([_NewnumberTF.text intValue] == 1) {
        
        _Newreduce.userInteractionEnabled = NO;
        
//        _Newreduce.enabled=NO;
        
    }else{
        
//        _Newreduce.enabled=YES;
        
        _NewnumberTF.text = [NSString stringWithFormat:@"%d",[_NewnumberTF.text intValue] - 1];
        
    }
    
    _model.count = _NewnumberTF.text;
    
    _NumberLabel.text = [NSString stringWithFormat:@"x%@",_NewnumberTF.text];
    
    if ([self.delegate respondsToSelector:@selector(changeShopCount:SidWithString:DetailWithString:Type:Goods_Type:)]) {
        
        [self.delegate changeShopCount:_NewnumberTF.text SidWithString:_model.sid DetailWithString:_model.detailId Type:@"0" Goods_Type:_model.attribute];
        
    }
    
}

//加

-(void)AddBtnClick:(UIButton *)sender
{
    [self endEditing:YES];
    
    NSLog(@"===加===");
    
    _reduce.userInteractionEnabled = YES;
    
    if (self.ChangeStock.length==0) {
        
        
    }else{
        
        
        if ([_model.attribute isEqualToString:@"2"]) {
            
            
            _model.stock =self.ChangeStock;
            
        }
        
        
    }
    
    
    if ([_numberTF.text intValue] == [_model.stock intValue]) {
        
//        [JRToast showWithText:[NSString stringWithFormat:@"最多只能买%@件哦",_model.stock] duration:1.0f];
        _numberTF.text = _model.stock;
        
    }else if([_numberTF.text intValue] > [_model.stock intValue]){
        
//        [JRToast showWithText:[NSString stringWithFormat:@"最多只能买%@件哦",_model.stock] duration:1.0f];
        
        if (_model.attribute_str.length==0) {
            
            [JRToast showWithText:[NSString stringWithFormat:@"已超出该商品库存"] duration:1.0f];
            
        }else{
            
            [JRToast showWithText:[NSString stringWithFormat:@"已超出该组库存数"] duration:1.0f];
            
        }
        
    }else{
        
        _numberTF.text = [NSString stringWithFormat:@"%d",[_numberTF.text intValue] + 1];
    }
    
    _model.count = _numberTF.text;
    
    _NumberLabel.text = [NSString stringWithFormat:@"x%@",_numberTF.text];
    
    if ([self.delegate respondsToSelector:@selector(changeShopCount:SidWithString:DetailWithString:Type:Goods_Type:)]) {
        
        [self.delegate changeShopCount:_numberTF.text SidWithString:_model.sid DetailWithString:_model.detailId Type:@"1" Goods_Type:_model.attribute];
    }
    
}

//加

-(void)NewAddBtnClick:(UIButton *)sender
{
    
    [self endEditing:YES];
    
    NSLog(@"===加===");
    
    
    _Newreduce.userInteractionEnabled = YES;
    
    if (self.ChangeStock.length==0) {
        
        
    }else{
        
        
        if ([_model.attribute isEqualToString:@"2"]) {
            
            
            _model.stock =self.ChangeStock;
            
        }
        
        
    }
    
    
    if ([_NewnumberTF.text intValue] == [_model.stock intValue]) {
        
//        [JRToast showWithText:[NSString stringWithFormat:@"最多只能买%@件哦",_model.stock] duration:1.0f];
        
        
        _NewnumberTF.text = _model.stock;
        
    }else if([_NewnumberTF.text intValue] > [_model.stock intValue]){
        
//        [JRToast showWithText:[NSString stringWithFormat:@"最多只能买%@件哦",_model.stock] duration:1.0f];
        
        if (_model.attribute_str.length==0) {
            
            [JRToast showWithText:[NSString stringWithFormat:@"已超出该商品库存"] duration:1.0f];
            
        }else{
            
            [JRToast showWithText:[NSString stringWithFormat:@"已超出该组库存数"] duration:1.0f];
            
        }
        
    }else{
        
        _NewnumberTF.text = [NSString stringWithFormat:@"%d",[_NewnumberTF.text intValue] + 1];
    }
    
    _model.count = _NewnumberTF.text;
    
    _NumberLabel.text = [NSString stringWithFormat:@"x%@",_NewnumberTF.text];
    
    if ([self.delegate respondsToSelector:@selector(changeShopCount:SidWithString:DetailWithString:Type:Goods_Type:)]) {
        
        [self.delegate changeShopCount:_NewnumberTF.text SidWithString:_model.sid DetailWithString:_model.detailId Type:@"1" Goods_Type:_model.attribute];
    }
    
}


#pragma mark -- UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
}
- (void)textFieldDidChange:(UITextField *)textField{
    
    
    NSLog(@"===111==textFieldDidChange====%@",textField.text);
    
    
    if (self.ChangeStock.length==0) {
        
        
    }else{
        
        
        if ([_model.attribute isEqualToString:@"2"]) {
            
            
            _model.stock =self.ChangeStock;
        }
        
        
    }
    
    unichar str = '2';
    
    if (![textField.text isEqualToString:@""]) {
        
        str = [textField.text characterAtIndex:0];
        
    }
    
    NSString *CT_NUM = @"^[0-9]*$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    
    BOOL isMatch1 = [pred1 evaluateWithObject:textField.text];
    
    
    if ([textField.text intValue] > [_model.stock intValue]) {
        
        textField.text = _model.stock;
//        NSLog(@"最多只能买%@件哦",_model.stock);
        
//        [JRToast showWithText:[NSString stringWithFormat:@"最多只能买%@件哦",_model.stock] duration:1.0f];
        
        if (_model.attribute_str.length==0) {
            
            [JRToast showWithText:[NSString stringWithFormat:@"已超出该商品库存"] duration:1.0f];
            
        }else{
            
            [JRToast showWithText:[NSString stringWithFormat:@"已超出该组库存数"] duration:1.0f];
            
        }
        
        //超出库存，保存最大库存量
        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
            
            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:_model.stock DetailId:_model.detailId Goods_Type:_model.attribute];
            
        }
        
        
    }else if([textField.text intValue] < 0){
        
        [JRToast showWithText:[NSString stringWithFormat:@"您输入的库存有误"] duration:1.0f];
        
        //超出库存，保存最大库存量
        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
            
            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:@"1" DetailId:_model.detailId Goods_Type:_model.attribute];
            
        }
        
    }else if([textField.text intValue] == 0){
        
//        [JRToast showWithText:[NSString stringWithFormat:@"您输入的库存有误"] duration:1.0f];
        
//        textField.text = @"1";
        
        //超出库存，保存最大库存量
        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
            
            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:@"1" DetailId:_model.detailId Goods_Type:_model.attribute];
            
        }
        
    }else if(!isMatch1){
        
//        [JRToast showWithText:[NSString stringWithFormat:@"您输入的库存有误"] duration:1.0f];
        
        //超出库存，保存最大库存量
        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
            
            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:_model.number DetailId:_model.detailId Goods_Type:_model.attribute];
            
        }
        
//        [textField resignFirstResponder];
        
    }else if(str == '0'){
        
        [JRToast showWithText:[NSString stringWithFormat:@"您输入的库存有误"] duration:1.0f];
        
        //超出库存，保存最大库存量
        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
            
            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:@"1" DetailId:_model.detailId Goods_Type:_model.attribute];
            
        }
        
        [textField resignFirstResponder];
        
    }else{
        
        //输入数量小于库存量，保存输入库存量
        
        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
            
            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:textField.text DetailId:_model.detailId Goods_Type:_model.attribute];
            
        }
        
    }
//    _model.count = textField.text;
    
    
}

- (void)NewtextFieldDidChange:(UITextField *)textField{
    
    
    NSLog(@"===222==textFieldDidChange====%@",textField.text);
    
    if (self.ChangeStock.length==0) {
        
        
    }else{
        
        
        if ([_model.attribute isEqualToString:@"2"]) {
            
            _model.stock =self.ChangeStock;
        }
        
        
    }
    
    unichar str = '2';
    
    if (![textField.text isEqualToString:@""]) {
        
        str = [textField.text characterAtIndex:0];
        
    }
    
    NSString *CT_NUM = @"^[0-9]*$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    
    BOOL isMatch1 = [pred1 evaluateWithObject:textField.text];
    
    
    
    if ([textField.text intValue] > [_model.stock intValue]) {
        textField.text = _model.stock;
        //        NSLog(@"最多只能买%@件哦",_model.stock);
        
//        [JRToast showWithText:[NSString stringWithFormat:@"最多只能买%@件哦",_model.stock] duration:1.0f];
        
        if (_model.attribute_str.length==0) {
            
            [JRToast showWithText:[NSString stringWithFormat:@"已超出该商品库存"] duration:1.0f];
            
        }else{
            
            [JRToast showWithText:[NSString stringWithFormat:@"已超出该组库存数"] duration:1.0f];
            
        }
        
        //超出库存，保存最大库存量
        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
            
            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:_model.stock DetailId:_model.detailId Goods_Type:_model.attribute];
            
        }
        
        
    }else if([textField.text intValue] < 0){
        
        [JRToast showWithText:[NSString stringWithFormat:@"您输入的库存有误"] duration:1.0f];
        
        //超出库存，保存最大库存量
        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
            
            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:@"1" DetailId:_model.detailId Goods_Type:_model.attribute];
            
        }
        
    }else if([textField.text intValue] == 0){
        
//        [JRToast showWithText:[NSString stringWithFormat:@"您输入的库存有误"] duration:1.0f];
        
//        textField.text = @"1";
        
        //超出库存，保存最大库存量
        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
            
            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:@"1" DetailId:_model.detailId Goods_Type:_model.attribute];
            
        }
        
    }else if(!isMatch1){
        
//        [JRToast showWithText:[NSString stringWithFormat:@"您输入的库存有误"] duration:1.0f];
        
        //超出库存，保存最大库存量
        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
            
            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:_model.number DetailId:_model.detailId Goods_Type:_model.attribute];
            
        }
        
//        [textField resignFirstResponder];
        
    }else if(str == '0'){
        
        [JRToast showWithText:[NSString stringWithFormat:@"您输入的库存有误"] duration:1.0f];
        
        //超出库存，保存最大库存量
        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
            
            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:@"1" DetailId:_model.detailId Goods_Type:_model.attribute];
            
        }
        
        [textField resignFirstResponder];
        
        
    }else{
        
        //超出库存，保存最大库存量
        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
            
            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:textField.text DetailId:_model.detailId Goods_Type:_model.attribute];
            
        }
    }
//    _model.count = textField.text;
    
    
}


//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    
//    //超出库存
//    
////    if (self.ChangeStock.length==0) {
////        
////        
////    }else{
////        
////        
////        if ([_model.attribute isEqualToString:@"2"]) {
////            
////            _model.stock =self.ChangeStock;
////            
////        }
////        
////        
////    }
//    
//    if ([string intValue] <= 0) {
//        
////        [JRToast showWithText:@"您输入的件数有误" duration:1.0f];
//
////        [self endEditing:YES];
//        
//    }else{
//        
//        
//        if ([self.delegate respondsToSelector:@selector(tableViewChangeNumber:Sid:Number:DetailId:Goods_Type:)]) {
//            
//            [self.delegate tableViewChangeNumber:textField Sid:_model.sid Number:string DetailId:_model.detailId Goods_Type:_model.attribute];
//            
//        }
//        
//        
//        
//    }
//    
//    NSLog(@"用户输入的====%@====输入框=%@",string,textField.text);
//    
//    return YES;
//}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
//    NSLog(@"==textField.text===%@=",textField.text);
    
    
    if (self.ChangeStock.length==0) {
        
        
    }else{
        
        if ([_model.attribute isEqualToString:@"2"]) {
            
            _model.stock =self.ChangeStock;
        }
        
        
    }
    
    unichar str = '2';
    
    if (![textField.text isEqualToString:@""]) {
        
        str = [textField.text characterAtIndex:0];
        
    }
    
    
    NSString *CT_NUM = @"^[0-9]*$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    
    BOOL isMatch1 = [pred1 evaluateWithObject:textField.text];
    
    
    if ([textField.text intValue] <= 0) {
        
        [JRToast showWithText:@"您输入的件数有误" duration:1.0f];
        
        textField.text= @"1";
        
    }else if(str == '0'){
        
        [JRToast showWithText:@"您输入的件数有误" duration:1.0f];
        
        textField.text= @"1";
        
    }else if(!isMatch1){
        
        [JRToast showWithText:[NSString stringWithFormat:@"您输入的库存有误"] duration:1.0f];
        
        textField.text= _model.number;
        
    }else{
        
        if ([self.delegate respondsToSelector:@selector(tableViewScroll:SidWithString:DetailWithString:Goods_Type:)]) {
            [self.delegate tableViewScroll:textField SidWithString:_model.sid DetailWithString:_model.detailId Goods_Type:_model.attribute];
        }
    }
}

//修改属性
-(void)ChangeAttributeClick:(UIButton *)sender
{
    
    NSLog(@"===修改属性==%ld",self.NewDetailId.length);
    
    NSNull *null = [[NSNull alloc] init];
    
    [self endEditing:YES];
    
    [UserMessageManager Height:@"100"];
    
    self.ChangeAttribute.enabled=NO;
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    //读取数组NSArray类型的数据
    self.NewDetailId = [userDefaultes stringForKey:@"shuxingstring"];
    
    
    NSLog(@"8888888888----%@",[userDefaultes stringForKey:@"shuxingstring"]);
    
    if (self.NewDetailId.length==0) {
        
        self.MyDetailId = _model.smallIds;
        
    }else{
        
        self.MyDetailId = self.NewDetailId;
        
        [UserMessageManager ShuXingAgain:self.NewDetailId];
        
        
    }
    
    
    NSLog(@"=111=MyDetailId=%@=smallIds=%@=NewDetailId=%@",self.MyDetailId,_model.smallIds,self.NewDetailId);
    
    if ([self.delegate respondsToSelector:@selector(changeShopDetail:Img:Gid:Count:Stock:Money:Integer:GoodType:Status:SmallIds:Sid:TF:)]) {
        [self.delegate changeShopDetail:_ChangeAttribute Img:_model.scopeimg Gid:_model.gid Count:_model.count Stock:_model.stock Money:_model.pay_maney Integer:_model.pay_integer GoodType:_model.good_type Status:_model.status SmallIds:_model.smallIds Sid:_model.sid TF:_model.number];
        
    }
    
    
    [UserMessageManager RemoveShuXingString];
    
  NSLog(@"=222=MyDetailId=%@=smallIds=%@=NewDetailId=%@=length=%ld",self.MyDetailId,_model.smallIds,self.NewDetailId,(unsigned long)self.NewDetailId.length);
    
}

//删除
-(void)DeleteBtnClick:(UIButton *)sender
{
    
    NSLog(@"===删除===");
    
    if ([self.delegate respondsToSelector:@selector(deleteShopGoodTouch:)]) {
        [self.delegate deleteShopGoodTouch:sender];
    }
    
    
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    
//    [self endEditing:YES];
//    
//}

/**
 *  隐藏键盘
 */
- (void)hiddenKeyboard{
    
    [self endEditing:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self endEditing:YES];
    
    return YES;
    
}


@end
