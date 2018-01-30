//
//  TrainBuyTicketVC.m
//  aTaohMall
//
//  Created by DingDing on 2017/8/25.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainBuyTicketVC.h"
#import "TrainProgressModel.h"
@interface TrainBuyTicketVC ()
{
    UIScrollView *_titleScroll;
    UILabel *statusLab;
    UIButton *statusBut;
    UIView   *statusView;
    UIView   *progressView;
    NSMutableArray *dataArray;
    NSString     *drawer_type;
    NSString     *message;
    NSInteger   drawerTypeHeight;
    CGSize size1;
    CGSize size2;
    UILabel * reasonLab;
}

@end

@implementation TrainBuyTicketVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDatas];
  //  [self setUI];

}

-(void)getDatas
{
    
    NSDictionary *params=@{@"orderno":self.orderno,@"status":self.status};
    [ATHRequestManager requestForTicketsProgressWithParams:params successBlock:^(NSDictionary *responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSArray *tempArr=responseObj[@"list"];
                if (!dataArray) {
                    dataArray=[[NSMutableArray alloc]init];
                }
                for (NSDictionary *dic in tempArr) {
                    TrainProgressModel *model=[[TrainProgressModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [dataArray addObject:model];
                }
                drawer_type=[NSString stringWithFormat:@"%@",responseObj[@"drawer_type"]];
                message=[NSString stringWithFormat:@"%@",responseObj[@"remark"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setUI];
                });
            });
            
        }
        else if ([responseObj[@"status"] isEqualToString:@"10002"]){
            [self setNoDataUIWithMessage:responseObj[@"message"]];
        }
        else
        {
            [TrainToast showWithText:[NSString stringWithFormat:@"%@",responseObj[@"message"]] duration:2.0];
        }
        
        
    } faildBlock:^(NSError *error) {
        
        [TrainToast showWithText:error.localizedDescription duration:2.0];
    }];
    
}

-(void)setUI
{
    //导航栏
    [self initNav];
   // self.view.backgroundColor=RGB(244, 244, 244);
    _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight)];
    
    _titleScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+100);
    //Button的高
    
    _titleScroll.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_titleScroll];
    
    
    size1=[message sizeWithFont:KNSFONT(14) maxSize:CGSizeMake(kScreen_Width-30, 100)];
    statusLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, size1.width, size1.height)];
    statusLab.font=KNSFONT(14);
    statusLab.textColor=RGB(51, 51, 51);
    statusLab.text=message;
    statusLab.numberOfLines=0;
    [_titleScroll addSubview:statusLab];
    
    
    if ([drawer_type isEqualToString:@"1"]) {
        
    CGSize size=[@"查看常见购票失败原因" sizeWithFont:KNSFONT(12) maxSize:CGSizeMake(kScreen_Width, 12)];
    statusBut=[UIButton buttonWithType:UIButtonTypeCustom];
    statusBut.frame=CGRectMake(15, 5+size1.height+10, size.width, size.height);
    statusBut.titleLabel.font=KNSFONT(12);
    [statusBut setTitle:@"查看常见购票失败原因" forState:UIControlStateNormal];
    [statusBut setTitleColor:RGB(43, 143, 255) forState:UIControlStateNormal];
    [statusBut addTarget:self action:@selector(checkReason:) forControlEvents:UIControlEventTouchUpInside];
    [_titleScroll addSubview:statusBut];
    statusBut.selected=NO;
    UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(size.width+15+5, 5+size1.height+12, 12, 12)];
    IV.image=KImage(@"iconfont-xiajiantou");
    [_titleScroll addSubview:IV];
    
    NSString *str=@"-同时段已购其他车次，与本次购票行程冲突；\n\n-某乘车人为第一次在网上订票，需到火车站核验身份；\n\n-使用了不真实的身份证号码；\n\n-铁路局认为某乘车人身份信息涉嫌被他人冒用；\n\n-所选座席类型余票不足；\n\n-当日退票已超过三次。";
    size2=[str sizeWithFont:KNSFONT(14) maxSize:CGSizeMake(kScreen_Width-30, 300)];
        
    statusView=[[UIView alloc]initWithFrame:CGRectMake(0, 15+size1.height+10+12+10, 0, 0)];
        
    [_titleScroll addSubview:statusView];
    reasonLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 0, 0)];
    reasonLab.font=KNSFONT(14);
    reasonLab.textColor=RGB(153, 153, 153);
    reasonLab.numberOfLines=0;
    reasonLab.text=str;
    [statusView addSubview:reasonLab];
        drawerTypeHeight=22;
    }
    else
    {
        drawerTypeHeight=0;
    }
   
    NSLog(@"dataarr.count=%ld",dataArray.count);
    
    progressView=[[UIView alloc]initWithFrame:CGRectMake(0,drawerTypeHeight+15+size1.height+10, kScreen_Width, 80*(dataArray.count-1)+33)];
    
    [_titleScroll addSubview:progressView];
    for (int i=0; i<dataArray.count; i++) {
        TrainProgressModel *model=dataArray[i];
        if (i==0) {
            UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(14, 7, 12, 12)];
            IV.image=KImage(@"icon_yuan-1");
            [progressView addSubview:IV];
            
            UILabel * progressLab = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, kScreen_Width-50, 13)];
            progressLab.font=[UIFont boldSystemFontOfSize:18];
            progressLab.textColor=RGB(51, 51, 51);
            progressLab.text=model.content;
            if ([model.content containsString:@"%"]) {
            NSArray *arr=[model.content componentsSeparatedByString:@"%"];
                model.content=[arr componentsJoinedByString:@""];
                progressLab.text=model.content;
                
                NSString *ShiFuPriceForColor2 = arr[1];
                // 创建对象.
                NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:progressLab.text];
                //
                NSRange range1 = [progressLab.text rangeOfString:ShiFuPriceForColor2];
                [mAttStri1 addAttribute:NSFontAttributeName value:KNSFONTM(18) range:range1];
                [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
                

                progressLab.attributedText=mAttStri1;
                
            }
           CGSize size4=[model.content sizeWithFont:[UIFont boldSystemFontOfSize:18] maxSize:CGSizeMake(kScreen_Width-50, 60)];
            progressLab.frame=CGRectMake(35, -5, size4.width, size4.height+10);
            progressLab.numberOfLines=0;
            [progressView addSubview:progressLab];
            
            UILabel * timeLab = [[UILabel alloc]initWithFrame:CGRectMake(35, size4.height, 200, 12)];
            timeLab.font=KNSFONT(14);
            timeLab.textColor=RGB(102, 102, 102);
            timeLab.text=model.get_date;
            [progressView addSubview:timeLab];
            
            if ([model.type isEqualToString:@"11"]) {
                timeLab.hidden=YES;
                CGRect rect=progressLab.frame;
                progressLab.frame=CGRectMake(rect.origin.x, rect.origin.y+5, rect.size.width, rect.size.height);
            }
            
        }
        else
        {
            UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake(15, 19+80*(i-1), 10, 80)];
            IV.image=KImage(@"icon_yuan-up");
            [progressView addSubview:IV];
            UILabel * progressLab = [[UILabel alloc]initWithFrame:CGRectMake(35, 0+80*i, kScreen_Width-50, 12)];
            progressLab.font=KNSFONT(14);
            progressLab.textColor=RGB(51, 51, 51);
            progressLab.text=model.content;
            if ([model.content containsString:@"%"]) {
                NSArray *arr=[model.content componentsSeparatedByString:@"%"];
                model.content=[arr componentsJoinedByString:@""];
                progressLab.text=model.content;
                

                NSString *ShiFuPriceForColor2 = arr[1];
                // 创建对象.
                NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:progressLab.text];
                //
                NSRange range1 = [progressLab.text rangeOfString:ShiFuPriceForColor2];
                [mAttStri1 addAttribute:NSFontAttributeName value:KNSFONT(18) range:range1];
               
                [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0] range:range1];
               // [mAttStri1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Bold" size:13] range:range1];
                progressLab.attributedText=mAttStri1;
                
            }

            CGSize size3=[model.content sizeWithFont:KNSFONT(14) maxSize:CGSizeMake(kScreen_Width-50, 70)];
            progressLab.frame=CGRectMake(35, -5+80*i, kScreen_Width-50, size3.height+10);
            progressLab.numberOfLines=0;
            [progressView addSubview:progressLab];
            UILabel * timeLab = [[UILabel alloc]initWithFrame:CGRectMake(35, size3.height+80*i, kScreen_Width-50, 12)];
            timeLab.font=KNSFONT(14);
            timeLab.textColor=RGB(102, 102, 102);
            timeLab.text=model.get_date;
            [progressView addSubview:timeLab];
            if ([model.type isEqualToString:@"11"]) {
                timeLab.hidden=YES;
                CGRect rect=progressLab.frame;
                progressLab.frame=CGRectMake(rect.origin.x, rect.origin.y+5, rect.size.width, rect.size.height);
            }
        }
    }
    
    _titleScroll.contentSize=CGSizeMake(kScreen_Width, drawerTypeHeight+15+size1.height+10+80*(dataArray.count-1)+43);
    
}
-(void)setNoDataUIWithMessage:(NSString *)noDataMessage
{
    [self initNav];
    CGSize size=[noDataMessage sizeWithFont:KNSFONTM(16) maxSize:kScreen_Size];
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width-size.width)/2, (kScreen_Height-65-size.height)/2, size.width, size.height)];
    lab.font=KNSFONTM(16);
    lab.textColor=RGB(102, 102, 102);
    lab.text=noDataMessage;
    [self.view addSubview:lab];

}
-(void)checkReason:(UIButton *)sender
{
    sender.selected=!sender.selected;
    if (sender.selected==NO) {
        CGRect rect2=progressView.frame;
        [UIView animateWithDuration:1.0 animations:^{
            statusView.frame=CGRectMake(0, 15+size1.height+10+12+10, 0, 0);
            reasonLab.frame=CGRectMake(15, 0, 0, 0);
            progressView.frame=CGRectMake(0, rect2.origin.y-size2.height-10, kScreen_Width, rect2.size.height);
            _titleScroll.contentSize=CGSizeMake(kScreen_Width, drawerTypeHeight+15+size1.height+10+80*(dataArray.count-1)+43);
        }];
        
    }else
    {
        CGRect rect2=progressView.frame;
        [UIView animateWithDuration:1.0 animations:^{
            statusView.frame=CGRectMake(0, 15+size1.height+10+12+10, kScreen_Width, size2.height+10);
            reasonLab.frame=CGRectMake(15, 0, kScreen_Width-30, size2.height);
            progressView.frame=CGRectMake(0, rect2.origin.y+size2.height+10, kScreen_Width, rect2.size.height);
        }];
     _titleScroll.contentSize=CGSizeMake(kScreen_Width, drawerTypeHeight+15+size1.height+10+80*(dataArray.count-1)+43+size2.height+10);
    }
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
    
    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt setImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
    
    [Qurt addTarget:self action:@selector(QurtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:Qurt];
    
    //创建搜索
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    label.text = @"详情";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
//    UIButton *Tui = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    Tui.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-17-15, 34, 17, 17);
//    
//    //    [Qurt setBackgroundImage:[UIImage imageNamed:@"iconfont-fanhui2yt"] forState:0];
//    
//    [Tui setImage:[UIImage imageNamed:@"提示111"] forState:0];
//    
//    
//    [Tui addTarget:self action:@selector(TuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    [titleView addSubview:Tui];
    
    
}

-(void)QurtBtnClick{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}


@end
