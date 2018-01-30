//
//  PublicAnnouncementViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/31.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PublicAnnouncementViewController.h"

@interface PublicAnnouncementViewController ()
{
    
    UIScrollView *_titleScroll;
}
@end

@implementation PublicAnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
    [self initNav];
    
    _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    
    _titleScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*2);
    //Button的高
    
    _titleScroll.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_titleScroll];
    
    
    
    
    
    UILabel *NumberLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, 20)];
    NumberLabel1.text = @"关于民航旅客行李中携带锂电池规定的公告";
    NumberLabel1.numberOfLines = 0;
    NumberLabel1.textAlignment = NSTextAlignmentCenter;
    NumberLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NumberLabel1.font = [UIFont fontWithName:@"PingFang-SC-Light" size:14];
    [_titleScroll addSubview:NumberLabel1];
    
    
    UILabel *NumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, [UIScreen mainScreen].bounds.size.width-30, 1400)];
    NumberLabel.text = @"    为了加强旅客行李中锂电池的航空运输安全，民航局、民航华东地区管理局先后下发《关于加强旅客行李中锂电池安全航空运输的通知》，要求民航各相关单位进一步做好旅客行李中锂电池的安全运输管理工作，对于旅客行李中携带锂电池的，按照国际民航组织《危险物品安全航空运输技术细则》以下规定执行： \n   由于三星Galaxy Note 7设备近期发生了多起爆炸事件，为避免安全风险，航空公司禁止在旅客的托运行李和随身携带物品中放置此型号设备，并在飞行途中保持全程关机并避免对其充电。 \n    旅客或机组成员为个人自用内含锂或锂离子电池芯或电池的便携式电子装置 (锂电池移动电源、手表、计算器、照相机、手机、手提电脑、便携式摄像机等)应作为手提行李携带登机，并且锂金属电池的锂含量不得超过2克，锂离子电池的额定能量值不得超过100Wh（瓦特小时）。超过100Wh但不超过160Wh的， 经航空公司批准后可以装在手提行李中的设备上。超过160Wh的锂电池严禁携带。 \n    便携式电子装置的备用电池必须单个做好保护以防短路（放入原零售包装或以其他方式将电极绝缘，如在暴露的电极上贴胶带，或将每个电池放入单独的塑料袋或保护盒当中），并且仅能在手提行李中携带。经航空公司批准的100 -160Wh的备用锂电池只能携带两个。 \n    飞行过程中装有启动开关的锂电池移动电源（充电宝），应当确保开关处于关闭状态。不得使用移动电源为消费电子设备充电或作为外部电源使用；不得开启移动电源的其他功能。 旅客和机组成员携带锂离子电池驱动的轮椅或其他类似的代步工具和旅客为医疗用途携带的、内含锂金属或锂离子电池芯或电池的便携式医疗电子装置的，必须依照《危险物品安全航空运输技术细则》的运输和包装要求携带并经航空公司批准。\n一、可携带的锂电池 \n   可以作为手提行李携带含不超过100Wh（瓦特小时）锂电池的笔记本电脑、手机、照相机、手表等个人自用便携式电子设备及备用电池登机。\n     一般来讲，手机的锂电池额定能量多在3～10Wh；单反照相机锂电池的能量多在10～20Wh；便携式摄像机的锂电池能量多在20-40Wh；笔记本电脑的锂电池能量为30-100Wh多不等。因此，手机、常用便携式摄像机、单反照相机以及绝大多数手提电脑等电子设备中的锂电池通常不会超过100Wh的限制。 \n二、限制携带的锂电池 \n    经航空公司批准，可以携带含超过100Wh但不超过160Wh锂电池的电子设备登机。每位旅客携带此类备用电池不能超过两个，且不能托运。 \n   可能含有超过100Wh锂电池的设备如新闻媒体器材、影视摄制组器材、演出道具、医疗器材、电动玩具、电动工具、工具箱等。 \n三、禁止携带的锂电池 \n   禁止携带或托运超过160Wh的大型锂电池或电子设备。 \n四、备用锂电池的保护措施 \n   备用电池必须单个做好保护以防短路（放入原零售包装或以其他方式将电极绝缘，如在暴露的电极上贴胶带，或将每个电池放入单独的塑料袋或保护盒当中）。 \n五、锂电池额定能量的判定方法 \n    若锂电池上没有直接标注额定能量Wh（瓦特小时），则锂电池额定能量可按照以下方式进行换算:\n        1、如果已知电池的标称电压(V )和标称容量(Ah)，可以通过计算得到额定瓦特小时的数值： Wh= V x Ah 标称电压和标称容量通常标记在电池上。\n  2、如果电池上只标记有毫安时(mAh)，可将该数值除以1000得到安培小时(Ah) 。 \n例如：锂电池标称电压为3.7V，标称容量为760 mAh ，其额定瓦特小时数为： \n760 mAh / 1000 = 0.76Ah \n3.7Vx0.76Ah=2.9Wh \n关于民航旅客携带“充电宝”乘机规定的公告\n充电宝是指主要功能用于给手机等电子设备提供外部电源的锂电池移动电源。根据现行有效国际民航组织《危险物品安全航空运输技术细则》和《中国民用航空危险品运输管理规定》，旅客携带充电宝乘机应遵守以下规定： \n一、充电宝必须是旅客个人自用携带。\n 二、充电宝只能在手提行李中携带或随身携带，严禁在托运行李中携带。 \n三、充电宝额定能量不超过100Wh,无需航空公司批准；额定能量超过100Wh但不超过160Wh，经航空公司批准后方可携带，但每名旅客不得携带超过两个充电宝。 \n四、严禁携带额定能量超过160Wh的充电宝；严禁携带未标明额定能量同时也未能通过标注的其他参数计算得出额定能量的充电宝。 \n五、不得在飞行过程中使用充电宝给电子设备充电。对于有启动开关的充电宝，在飞行过程中应始终关闭充电宝。 \n上述规定同时适用于机组人员。 \n本公告自公布之日起施行。 \n附：充电宝额定能量的判定方法 充电宝额定能量的判定方法 \n若充电宝上没有直接标注额定能量Wh（瓦特小时），则充电宝额定能量可按照以下方式进行换算: \n1、如果已知充电宝的标称电压(V )和标称容量(Ah)，可以通过计算得到额定能量的数值： Wh= V x Ah 标称电压和标称容量通常标记在充电宝上。 \n2、如果充电宝上只标记有毫安时(mAh)，可将该数值除以1000得到安培小时(Ah) 。 \n例如：充电宝标称电压为3.7V，标称容量为760 mAh ，其额定能量为： \n760 mAh ÷ 1000 = 0.76Ah \n3.7V×0.76Ah=2.9Wh";
    NumberLabel.numberOfLines = 0;
    NumberLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NumberLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    
    
    NSString *stringForColor = @"关于民航旅客携带“充电宝”乘机规定的公告";
    NSString *stringForColor1 = @"退票手续费：";
    
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:NumberLabel.text];
    //
    NSRange range = [NumberLabel.text rangeOfString:stringForColor];
    NSRange range1 = [NumberLabel.text rangeOfString:stringForColor1];
    
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:14] range:range];
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:14] range:range1];
    
    
    NumberLabel.attributedText=mAttStri;
    
    [_titleScroll addSubview:NumberLabel];
    
    
}

//创建导航栏
-(void)initNav
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, [UIScreen mainScreen].bounds.size.width, 1)];
    
    line.image = [UIImage imageNamed:@"分割线-拷贝"];
    
    [self.view addSubview:line];
    
    
    //返回按钮
    
    UIButton *Qurt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    Qurt.frame = CGRectMake(10, 25+KSafeTopHeight, 30, 30);
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-80, 30)];
    
    label.text = @"关于民航旅客行李中携带锂电池规定的公告";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
}
-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
