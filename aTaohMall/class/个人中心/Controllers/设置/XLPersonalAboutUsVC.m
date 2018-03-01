//
//  XLPersonalAboutUsVC.m
//  aTaohMall
//
//  Created by Hawky on 2018/2/26.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLPersonalAboutUsVC.h"
#import "XLNaviVIew.h"
@interface XLPersonalAboutUsVC ()<XLNaviViewDelegate>
{
    UIScrollView *_scroll;
}
@end

@implementation XLPersonalAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    XLNaviView *Navi=[[XLNaviView alloc] initWithMessage:@"关于我们" ImageName:@""];
    Navi.delegate=self;
    [self.view addSubview:Navi];
    UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight)];
    IV.image=KImage(@"xl-bg");
    [self.view addSubview:IV];

    _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight)];
    _scroll.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scroll];

    UIImageView *LogoIV=[[UIImageView alloc] initWithFrame:CGRectMake((kScreen_Width-Width(100))/2, Width(43), Width(100), Width(100))];
    LogoIV.image=KImage(@"AppIcon");
    [_scroll addSubview:LogoIV];

    UILabel * versionLab = [[UILabel alloc]initWithFrame:CGRectMake(0, Width(100)+Width(43)+Width(15), kScreen_Width, 22)];
    versionLab.font=KNSFONT(16);
    versionLab.textAlignment=NSTextAlignmentCenter;
    versionLab.textColor=RGB(74, 74, 74);
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(CFBridgingRetain(infoDictionary));
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    versionLab.text=[NSString stringWithFormat:@"版本号:%@",app_Version];
    [_scroll addSubview:versionLab];

    NSString *str=@"      安淘惠商城以O2O为业务基础，积分通用、支付硬件、异业联盟、海淘直达等多种商业模式为辅，打造了一个拥有完整业务生态链的O2O商城，并深入耕耘数年，发展至今已初具规模。\n      安淘惠商城致力于为消费者提供上佳的O2O购物体验，自上线以来，坚持“正品行货”的理念，对假货零容忍，采取六大品控措施， 保障正品，大量品牌直供，从源头杜绝假货。\n      通过内容丰富、人性化的网站（http://athmall.com/）和覆盖多端的移动客户端，安淘惠商城以富有竞争力的价格，提供具有丰富品类及卓越品质的商品和优质服务，以灵活多变的方式送达消费者，并且提供安全可靠的支付方式。\n      安淘惠商城致力于打造一站式 综合O2O购物平台，服务中国亿万家庭，以丰富品类的商品销售以及多样的购物体验，覆盖用户多元需求。\n";


    CGSize size=[str sizeWithFont:KNSFONT(14) maxSize:CGSizeMake(kScreen_Width-Width(50), MAXFLOAT)];

    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(Width(25), Width(100)+Width(43)+Width(15)+22+Width(30), kScreen_Width-Width(50), size.height)];
    lab.font=KNSFONT(14);
    lab.numberOfLines=0;
    lab.textColor=RGB(102, 102, 102);
    lab.text=str;
    [_scroll addSubview:lab];

}

-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
