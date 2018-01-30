//
//  TrainXieYiViewController.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/15.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainXieYiViewController.h"

@interface TrainXieYiViewController ()
{
    
    UIScrollView *_titleScroll;
}
@end

@implementation TrainXieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame=[UIScreen mainScreen].bounds;
    
     [self initNav];
    
    _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    
    if ([UIScreen mainScreen].bounds.size.width > 320) {
        
        _titleScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*3);
    }else{
        
        _titleScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*4);
    }
    
    //Button的高
    
    
    _titleScroll.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_titleScroll];
    
    
   
    
    
    UILabel *NumberLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, 20)];
    NumberLabel1.text = @"火车票平台用户协议";
    NumberLabel1.numberOfLines = 0;
    NumberLabel1.textAlignment = NSTextAlignmentCenter;
    NumberLabel1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NumberLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [_titleScroll addSubview:NumberLabel1];
    
    
    UILabel *NumberLabel = [[UILabel alloc] init];
    
    if ([UIScreen mainScreen].bounds.size.width > 320) {
        
        NumberLabel.frame = CGRectMake(15, 40, [UIScreen mainScreen].bounds.size.width-30, 1700);
        
    }else{
        
        NumberLabel.frame = CGRectMake(15, 40, [UIScreen mainScreen].bounds.size.width-30, 2100);
    }
    
    
    NumberLabel.text = @"      在安淘惠平台委托预订火车票之前，请您（即用户）仔细阅读下述协议条款。一旦您点击确认本协议，即表示您已接受了以下所述的条款和条件，同意受本协议约束。如果您不同意接受全部的条款和条件，那么您将无法预订火车票。\n\n第一条　协议订立\n1.1　本许可协议的缔约方为在安淘惠平台为用户提供火车票及火车票保险预订服务的服务商（服务商）和用户（“您”），本许可协议具有合同效力。\n1.2　用户在线确认或书面签署《服务协议》和本协议后，方可使用平台服务商提供的火车票委托预订服务（以下简称“服务”）。\n第二条　服务说明\n2.1　用户通过本平台委托预订火车票及其他产品的相关服务均由服务商提供，安淘惠平台仅为技术服务提供方。\n2.2　由于全国各铁路管理部门对火车票售票的不同规定与要求，服务商均无法承诺用户支付后可实现百分之百出票。\n2.3　火车委托预订服务内容以本协议、安淘惠相关规则，及服务商在平台服务产品详情页面中公示的内容（以下简称“服务商约定”）为准。但服务商自行公示内容需符合国家相关法律法规规定，且符合本协议及平台火车票订购相关规则约定，否则无效。\n第三条　用户的权利和义务\n3.1　用户在委托服务商提供相关产品服务前,应仔细阅读本协议、安淘惠规则及服务商所公示的委托预订流程、售后服务等服务商约定。\n3.2　用户提交委托订单时，应当准确填写乘车人的姓名、身份证号、手机联系方式、日期、出发到达车站、车次、座位类型等信息内容，以确保乘车人可取票，委托订单一经提交无法更改填写信息。\n3.3　用户应在提交订单后30分钟内完成付款，收到出票成功确认短信信息后出票成功，收到出保成功确认短信信息后出保成功。用户应按照与服务商约定自行去火车站或售票点取票并享有其他产品（如有）对应的服务。如用户未按时完成付款，则该订单将会被系统自动取消；用户知悉服务产品存在委托预订可能失败情形，因此用户接受付款完成后，在未收到出票成功确认短信信息情形下，仅以退款方式解决。\n3.4　用户委托预订成功后，如需取消订单或办理退票手续的，依据本协议约定进行。\n3.5　用户因委托预订产生的咨询、退票服务等均与服务商咨询、办理。如因此产生争议由用户与服务商协商解决，安淘惠不承担责任。\n3.6　用户授权安淘惠可向服务商、铁路局等铁路管理部门披露用户提交订单中所涉及的个人信息。用户授权服务商可为完成用户委托的预订火车票服务目的在必须时向铁路局、对应保险公司（如用户委托订购了保险产品）披露用户提交订单中所提交的用户个人信息。\n第四条　服务商权利义务\n4.1　服务商承诺其发布于安淘惠平台的所有信息真实、准确、有效，符合相关法律法规及安淘惠相关规则规定。其承诺实时更新国内火车票产品信息，确保其发布之包括但不限于车次、价格等信息均真实、准确、有效。\n4.2　服务商承诺对用户订单能否出票及时反馈用户并按如下约定办理退票、退款：\n（1）退票流程：\nA、交易成功但用户未取票的，如用户在发车前一小时且在甲方营业时间内在线申请退票的，则甲方承诺在扣除退票票款手续费后保证100%退票。\nB、符合以下情形之一的，用户自行前往火车站办理退票手续、然后在线申请退票以便完成退款：\na、交易成功且用户已取票的；\nb、交易成功且用户未取票，且用户在发车前一小时内（含一小时）提出退票申请的；\nc、交易成功且用户未取票，用户在发车一小时前在线申请退票，但申请退票时间不在甲方营业时间内的。甲方承诺在用户退票成功后24小时内扣除退票手续费后向用户付款账户内退款；\n4.3　服务商承诺对用户提交订单信息内容保密，除本协议约定的披露情形，未经信息提交人同意，不得向任何第三方泄露。\n第五条　免责说明\n5.1　因全国各铁路局随时会调整车次、票价、坐席等信息，因此，用户委托订购之火车票的车次、票价、坐席等信息最终以实际购买票面为准。\n5.2　因用户提供错误订单信息所导致的损失，用户需自行承担，安淘惠平台及服务商不承担任何责任。\n5.3　因不可抗力，包括但不限于黑客入侵、计算机病毒等原因造成用户资料泄露、丢失、被盗用、被篡改的，安淘惠平台不承担任何责任。\n第六条　争议解决及法律适用\n6.1　在用户的预订生效后，如果在本协议或订单约定内容履行过程中，对相关事宜的履行发生争议，用户同意按照中华人民共和国颁布的相关法律法规来解决争议，并同意接受广东省深圳市人民法院的管辖。\n6.2.　最终解释权归本公司所有。";
    NumberLabel.numberOfLines = 0;
    NumberLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    NumberLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    
    
    NSString *stringForColor = @"第一条　协议订立";
    NSString *stringForColor1 = @"第二条　服务说明";
    NSString *stringForColor2 = @"第三条　用户的权利和义务";
    NSString *stringForColor3 = @"第四条　服务商权利义务";
    NSString *stringForColor4 = @"第五条　免责说明";
    NSString *stringForColor5 = @"第六条　争议解决及法律适用";
    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:NumberLabel.text];
    //
    NSRange range = [NumberLabel.text rangeOfString:stringForColor];
    NSRange range1 = [NumberLabel.text rangeOfString:stringForColor1];
    NSRange range2 = [NumberLabel.text rangeOfString:stringForColor2];
    NSRange range3 = [NumberLabel.text rangeOfString:stringForColor3];
    NSRange range4 = [NumberLabel.text rangeOfString:stringForColor4];
    NSRange range5 = [NumberLabel.text rangeOfString:stringForColor5];
    
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16] range:range];
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16] range:range1];
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16] range:range2];
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16] range:range3];
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16] range:range4];
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:16] range:range5];
    
    
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-100, 30)];
    
    label.text = @"火车票预订协议";
    
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
