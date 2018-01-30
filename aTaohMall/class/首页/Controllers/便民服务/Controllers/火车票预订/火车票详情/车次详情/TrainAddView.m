//
//  TrainAddView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/16.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "TrainAddView.h"

#import "TrainAddManViewController.h"

#import "AFNetworking.h"
#import "TrainToast.h"
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"

#import "WKProgressHUD.h"
#import "JRToast.h"
#import "BianMinModel.h"
#import "TrainEditManViewController.h"
#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface TrainAddView ()<TrainAddDelegate,TrainEditDelegate>
{
    UIImageView *Wanimg;
    UIImageView *Duanimg;
    UIImageView *zaoimg;
    
    NSMutableArray *_data;
    
    NSMutableArray *_Man;
    
    NSMutableArray *_NewMan;
    
    NSMutableArray *_SelectID;
    int page;
    
}
@end

@implementation TrainAddView

- (UIViewController*)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


-(void)setManArray:(NSArray *)ManArray
{
    
    
    _ManArray = ManArray;
   
    [_SelectID removeAllObjects];
    
    
    
    for (int i = 0; i < _data.count; i++) {
        BianMinModel *model=_data[i];
        model.ManSelectString=@"0";
        UIImageView *line = (UIImageView *)[self viewWithTag:200+i];
        line.image = [UIImage imageNamed:@"未选中框"];
        
        UIControl *shareControl5 = (UIControl *)[self viewWithTag:10+i];
        shareControl5.selected = YES;
        
        for (BianMinModel *model2 in _ManArray) {
            if ([model.ManId isEqualToString:model2.ManId]) {
                UIImageView *line = (UIImageView *)[self viewWithTag:200+i];
                line.image = [UIImage imageNamed:@"选中"];
                model.ManSelectString=@"1";
                UIControl *shareControl5 = (UIControl *)[self viewWithTag:10+i];
                shareControl5.selected = NO;
                
                [_SelectID addObject:model.ManId];
                
            }
        }
        
    }
    
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        _huiseControl=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
        _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
        [_huiseControl addTarget:self action:@selector(huiseControlClick) forControlEvents:UIControlEventTouchUpInside];
        _huiseControl.alpha=0;
        self.backgroundColor = [UIColor whiteColor];
        
        _data = [NSMutableArray new];
        
        _Man = [NSMutableArray new];
        
        _NewMan = [NSMutableArray new];
        
        _SelectID = [NSMutableArray new];
        
        page=0;
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        self.sigen=[userDefaultes stringForKey:@"sigen"];
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 240)];
        _shareListView.backgroundColor = RGBACOLOR(238, 238, 238, 1);
        [self addSubview:_shareListView];
        
        
        UIView *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
//        title.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [_shareListView addSubview:title];
        
        UILabel *CancleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (40-14)/2, 100, 14)];
        CancleLabel.text = @"取消";
        CancleLabel.textColor = [UIColor colorWithRed:88/255.0 green:168/255.0 blue:251/255.0 alpha:1.0];
        CancleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
        [title addSubview:CancleLabel];
        
        UIControl *shareControl1 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        shareControl1.tag = 1;
        [_shareListView addSubview:shareControl1];
        [shareControl1 addTarget:self action:@selector(shareControl1:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *OKLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-115, (40-14)/2, 100, 14)];
        OKLabel.text = @"确定";
        OKLabel.textColor = [UIColor colorWithRed:88/255.0 green:168/255.0 blue:251/255.0 alpha:1.0];
        OKLabel.textAlignment = NSTextAlignmentRight;
        OKLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
        [title addSubview:OKLabel];
        
        UIControl *shareControl2 = [[UIControl alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 0, 100, 40)];
        shareControl2.tag = 1;
        [_shareListView addSubview:shareControl2];
        [shareControl2 addTarget:self action:@selector(shareControl2:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, [UIScreen mainScreen].bounds.size.width, 1)];
        line.image = [UIImage imageNamed:@"分割线-拷贝"];
        [title addSubview:line];
        
        
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 200)];
        _scrollView.backgroundColor=[UIColor whiteColor];
        _scrollView.showsHorizontalScrollIndicator=YES;
        
        [_shareListView addSubview:_scrollView];
        
        
        UIView *AddView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        AddView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:AddView];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, [UIScreen mainScreen].bounds.size.width, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [AddView addSubview:line3];
        
        UIImageView *addImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (50-15)/2, 15, 15)];
        addImgView.image = [UIImage imageNamed:@"icon-plus"];
        [AddView addSubview:addImgView];
        
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, (50-13)/2, 100, 13)];
        shareLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        shareLabel.text = @"新增乘车人";
        shareLabel.textAlignment = NSTextAlignmentLeft;
        [AddView addSubview:shareLabel];
        
        UIControl *shareControl4 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        shareControl4.tag = 1;
        shareControl4.userInteractionEnabled=YES;
        [_scrollView addSubview:shareControl4];
        [shareControl4 addTarget:self action:@selector(shareControl4:) forControlEvents:UIControlEventTouchUpInside];
        
        

        
    
        [self getDatas];
        
        
        
    }
    return self;
}

-(void)getDatas
{
    
    for (int i = 0; i < _data.count; i++) {
        
        UIView *view = (UIView *)[self viewWithTag:600+i];
        [view removeFromSuperview];
        
        UILabel *price = (UILabel *)[self viewWithTag:400+i];
        [price removeFromSuperview];
        
        UILabel *Id = (UILabel *)[self viewWithTag:300+i];
        [Id removeFromSuperview];
        
        UIImageView *RedImgView = (UIImageView *)[self viewWithTag:500+i];
        [RedImgView removeFromSuperview];
        
        UIImageView *line = (UIImageView *)[self viewWithTag:200+i];
        [line removeFromSuperview];
        
        UIControl *shareControl6 = (UIControl *)[self viewWithTag:100+i];
        [shareControl6 removeFromSuperview];
        
        UIControl *shareControl5 = (UIControl *)[self viewWithTag:10+i];
        [shareControl5 removeFromSuperview];
        
    }
    [_data removeAllObjects];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getTrainPassengers_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSDictionary *dict = @{@"sigen":self.sigen};
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr=111查询乘车人=%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSLog(@"乘车人信息=%@",dic);
            
            
            
            if ([dic[@"status"] isEqualToString:@"10000"]) {
                
                //                _ManArray = nil;
                
                for (NSDictionary *dict in dic[@"list"]) {
                    
                    BianMinModel *model = [[BianMinModel alloc] init];
                    
                    model.ManId = [NSString stringWithFormat:@"%@",dict[@"id"]];
                    model.ManUid = [NSString stringWithFormat:@"%@",dict[@"uid"]];
                    model.username = [NSString stringWithFormat:@"%@",dict[@"username"]];
                    model.air_passenger = [NSString stringWithFormat:@"%@",dict[@"air_passenger"]];
                    model.passporttypeseid = [NSString stringWithFormat:@"%@",dict[@"passporttypeseid"]];
                    model.passportseno = [NSString stringWithFormat:@"%@",dict[@"passportseno"]];
                    model.ManSelectString = @"0";
                    
                    [_data addObject:model];
                    
                }
                
                
                
                _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 50*(_data.count+1));
                
                
                [self updateData];
                [self initManView];
                
                
            }else{
                
                
                //                [JRToast showWithText:dic[@"message"] duration:2.0f];
                
            }
            
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        
        
    }];
    
}


-(void)updateData
{
    if (_ManArray.count>0) {
        for (int i=0; i<_data.count; i++) {
            BianMinModel *model=_data[i];
            for (int j=0; j<_ManArray.count; j++) {
                BianMinModel *model2=_ManArray[j];
                if ([model.ManId isEqualToString:model2.ManId]) {
                    model.childArr=[NSMutableArray arrayWithArray:model2.childArr];
                    model.ManSelectString=@"1";
                    [_data replaceObjectAtIndex:i withObject:model];
                
                }
            }
            
        }
    }
    for (BianMinModel *model in _data) {
        NSLog(@"model.child.count=%ld",model.childArr.count);
    }
    
    //重新修改数据
    [_Man removeAllObjects];
    
    for (BianMinModel *model in _data) {
        
        if ([model.ManSelectString isEqualToString:@"1"]) {
            
            [_Man addObject:model];
            
            
        }
        NSLog(@"====选中人==%@",model.ManSelectString);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(TrainAddMan:)]) {
        
        [_delegate TrainAddMan:_Man];
    }
    
}


-(void)initManView
{
    
    NSLog(@"===%ld",(long)_data.count);
    
    for (BianMinModel *model in _data) {
        
        NSLog(@"===用户是否被选中===%@",model.ManSelectString);
        
    }
    
    for (int i = 0; i<_data.count; i++) {
        
        BianMinModel *model = _data[i];
        
        UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 50+50*i, [UIScreen mainScreen].bounds.size.width, 50)];
        View.backgroundColor = [UIColor whiteColor];
        View.tag =600+i;
        [_scrollView addSubview:View];
        
        
        UIImageView *ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (50-15)/2, 15, 15)];
        ImgView.image = [UIImage imageNamed:@"icon-edition"];
        ImgView.tag=500+i;
        [View addSubview:ImgView];
        
        UILabel *NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 13, 200, 13)];
        NameLabel.text = model.username;
        NameLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        NameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        NameLabel.tag = 400+i;
        [View addSubview:NameLabel];
        
        
        UILabel *IDLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 300, 13)];
        
        IDLabel.tag=300+i;
        IDLabel.text = [NSString stringWithFormat:@"%@",model.passportseno];
        IDLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        IDLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:12];
        [View addSubview:IDLabel];
        
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-20-16, (50-21)/2, 20, 21)];
        
        if ([model.ManSelectString isEqualToString:@"1"]) {
            
            line4.image = [UIImage imageNamed:@"选中"];
            
        }else{
            
            line4.image = [UIImage imageNamed:@"未选中框"];
        }
        
        line4.tag=i+200;
        [View addSubview:line4];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, UIBounds.size.width-15, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [View addSubview:line3];
        
        UIControl *shareControl6 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 60, 50)];
        [View addSubview:shareControl6];
        shareControl6.tag = i+100;
        [shareControl6 addTarget:self action:@selector(shareControl6:) forControlEvents:UIControlEventTouchUpInside];
        
        UIControl *shareControl5 = [[UIControl alloc]initWithFrame:CGRectMake(UIBounds.size.width-65, 0, 60, 50)];
        
        if ([model.ManSelectString isEqualToString:@"1"]) {
            
            shareControl5.selected=NO;
            
        }else{
            
            shareControl5.selected=YES;
        }
        
        
        [View addSubview:shareControl5];
        shareControl5.tag = i+10;
        [shareControl5 addTarget:self action:@selector(shareControl5:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

- (void)showInView:(UIView *) view {
    if (self.isHidden) {
        self.hidden = NO;
        if (_huiseControl.superview==nil) {
            [view addSubview:_huiseControl];
        }
        [UIView animateWithDuration:0.2 animations:^{
            _huiseControl.alpha=1;
        }];
        CATransition *animation = [CATransition  animation];
        animation.delegate = self;
        animation.duration = 0.2f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromTop;
        [self.layer addAnimation:animation forKey:@"animation1"];
        self.frame = CGRectMake(0,view.frame.size.height - 240, UIBounds.size.width, 240);
        [view addSubview:self];
    }
}


- (void)hideInView {
    if (!self.isHidden) {
        self.hidden = YES;
        CATransition *animation = [CATransition  animation];
        animation.delegate = self;
        animation.duration = 0.2f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromBottom;
        [self.layer addAnimation:animation forKey:@"animtion2"];
        [UIView animateWithDuration:0.2 animations:^{
            _huiseControl.alpha=0;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)shareControl1:(UIControl *)sender
{
    
    [self hideInView];
}

//确定
- (void)shareControl2:(UIControl *)sender
{
    
    
    [_Man removeAllObjects];
    
    for (BianMinModel *model in _data) {
        
        if ([model.ManSelectString isEqualToString:@"1"]) {
            
            [_Man addObject:model];
            
            
        }
            NSLog(@"====选中人==%@",model.ManSelectString);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(TrainAddMan:)]) {
        
        [_delegate TrainAddMan:_Man];
    }
    
    page=1;
    
    [self hideInView];
    
}

//编辑
- (void)shareControl6:(UIControl *)sender
{
    
//    [self hideInView];
    
    BianMinModel *model = _data[sender.tag-100];
    
    TrainEditManViewController *vc = [[TrainEditManViewController alloc] init];
    vc.delegate = self;
    vc.ManId = model.ManId;
    vc.Username = model.username;
    vc.PassId  =model.passportseno;
    self.viewController.navigationController.navigationBar.hidden=YES;
    [self.viewController.navigationController pushViewController:vc animated:NO];
    
    
}

//选择
- (void)shareControl5:(UIControl *)sender
{
    [_NewMan removeAllObjects];
    
    for (BianMinModel *model in _data) {
        
        if ([model.ManSelectString isEqualToString:@"1"]) {
            
            [_NewMan addObject:model];
        }
//        NSLog(@"===选择===%@",model.ManSelectString);
        
    }
    
    UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+190];
    
    BianMinModel *model = _data[sender.tag-10];
    
    model.TagString = [NSString stringWithFormat:@"%ld",sender.tag+190];
    
    
    if (sender.selected) {
        
        NSLog(@"选中");
        
        if (_NewMan.count + [self.Number integerValue] >= [_TicketCount intValue]) {
            
            
            [TrainToast showWithText:[NSString stringWithFormat:@"坐席不足，最多可选择%d位乘客",[_TicketCount intValue]] duration:2.0f];
            
            
        }else if(_NewMan.count + [self.Number integerValue]>= 5){
            
            
            [TrainToast showWithText:[NSString stringWithFormat:@"最多可选择5位乘客"] duration:2.0f];
            
        }else{
            
            
            model.ManSelectString = @"1";

            label.image = [UIImage imageNamed:@"选中"];
            
            sender.selected = !sender.selected;
            
        }
        
        
    }else{
        
        NSLog(@"不选中");
        
        model.ManSelectString = @"0";
        
        label.image = [UIImage imageNamed:@"未选中框"];
        
        sender.selected=YES;
        
        
    }
    [_data replaceObjectAtIndex:sender.tag-10 withObject:model];
    
}

-(void)TrainEditData
{
    
    
    [self getDatas];
    
}

-(void)TrainReloadData
{
    
    [self getDatas];
    
}
- (void)shareControl4:(UIControl *)sender
{
    
//    [self hideInView];
    
    if (_data.count >= 15) {
        
        
        [TrainToast showWithText:@"最多可添加15位乘车人" duration:2.0f];
        
    }else{
        
        TrainAddManViewController *vc = [[TrainAddManViewController alloc] init];
        vc.delegate = self;
        
        self.viewController.navigationController.navigationBar.hidden=YES;
        [self.viewController.navigationController pushViewController:vc animated:NO];
    }
    
    
    
}

-(void)huiseControlClick{
    [self hideInView];
}

@end
