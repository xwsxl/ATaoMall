//
//  PersonalShoppingRefundTypeVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingRefundTypeVC.h"
#import "PersonalShoppingReplyRefundVC.h"

#import "PersonalShoppingRefundView.h"
#import "XLRedNaviView.h"

#import "XLShoppingModel.h"
@interface PersonalShoppingRefundTypeVC ()<XLRedNaviViewDelegate>

@property (nonatomic,strong)XLRedNaviView *navi;
@property (nonatomic,strong)PersonalShoppingRefundView *shoppingView;
@end

@implementation PersonalShoppingRefundTypeVC
/*******************************************************      控制器生命周期       ******************************************************/

//
- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)setDataModel:(XLShoppingModel *)dataModel
{
    _dataModel=dataModel;
    [self SetUI];
}
//
-(void)SetUI
{
    CGFloat height=0;
    [self navi];
    height+=_navi.frame.size.height;
    [self.view setBackgroundColor:UIColorFromRGB(0xf4f4f4)];
    XLShoppingModel *model=self.dataModel;
    _shoppingView=[[PersonalShoppingRefundView alloc] initWithFrame:CGRectMake(0, height, kScreen_Width, Height(30)+70) AndShoppingName:model.name scopimgName:model.scopeimg attributeStr:model.attribute_str];
    [self.view addSubview:_shoppingView];

    height+=_shoppingView.frame.size.height;

    height+=Height(10);
    for (int i=0; i<2; i++) {
        UIButton *refundBut=[UIButton buttonWithType:UIButtonTypeCustom];
        refundBut.frame=CGRectMake(0, height, kScreen_Width, 60);
        [refundBut setBackgroundColor:[UIColor whiteColor]];
        refundBut.tag=100+i;
        [self.view addSubview:refundBut];
        height+=refundBut.frame.size.height;

        UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(15), 15, 18, 17)];
        [refundBut addSubview:IV];

        UILabel *typeLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(38), 15, kScreen_Width-Width(38)-Width(15)-10, 13)];
        [refundBut addSubview:typeLab];

        UILabel *detailLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(38), 15+13+7, kScreen_Width-Width(38)-Width(15)-10, 12)];
        [refundBut addSubview:detailLab];

        UIImageView *rightIV=[[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-Width(15)-8, (60-13)/2.0, 8, 13)];
        [rightIV setImage:KImage(@"icon_more")];
        [refundBut addSubview:rightIV];
        if (i==0) {
            IV.image=KImage(@"icon_Refundonly");
            typeLab.font=KNSFONT(13);
            typeLab.text=@"仅退款";
            typeLab.textColor=RGB(51, 51, 51);

            detailLab.font=KNSFONT(12);
            detailLab.text=@"未收到货(包含未签收)，或卖家协商同意前提下";
            detailLab.textColor=RGB(153, 153, 153);


        }
        if (i==1) {
            IV.image=KImage(@"icon_Refundreturns");
            typeLab.font=KNSFONT(13);
            typeLab.text=@"退款退货";
            typeLab.textColor=RGB(51, 51, 51);

            detailLab.font=KNSFONT(12);
            detailLab.text=@"已收到货，或需要退换已收到的货物";
            detailLab.textColor=RGB(153, 153, 153);


        }

        [refundBut addTarget:self action:@selector(RefundButClick:) forControlEvents:UIControlEventTouchUpInside];


        if (i<2-1) {
            UIImageView *lineIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, height, kScreen_Width, 1)];
            [lineIV setImage:KImage(@"分割线-拷贝")];
            [self.view addSubview:lineIV];
            height+=lineIV.frame.size.height;
        }
    }




}

/*******************************************************      数据请求       ******************************************************/

/*******************************************************      初始化视图       ******************************************************/

/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
//
-(void)RefundButClick:(UIButton *)sender
{
    NSString *refundType=@"";
    if (sender.tag-100==0) {
        refundType=@"2";
    }else
    {
        refundType=@"1";
    }
    YLog(@"%@",self.dataModel.order_batchid);
    PersonalShoppingReplyRefundVC *VC=[[PersonalShoppingReplyRefundVC alloc] init];
    [VC setDataModel:self.dataModel AndRefundType:refundType andRefundTime:_RefundTotalTime andQurtAllDan:self.QurtAllDan];
    [self.navigationController pushViewController:VC animated:NO];

}

/*******************************************************      协议方法       ******************************************************/

-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

/*******************************************************      代码提取(多是复用代码)       ******************************************************/



-(XLRedNaviView *)navi
{
    if (!_navi) {

        _navi=[[XLRedNaviView alloc]initWithMessage:@"退款/退货选择" ImageName:@""];
        [self.view addSubview:_navi];
        _navi.delegate=self;
    }
    return _navi;
}

@end
