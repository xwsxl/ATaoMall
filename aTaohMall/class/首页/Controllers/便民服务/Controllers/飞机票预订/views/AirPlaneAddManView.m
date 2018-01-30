//
//  AirPlaneAddManView.m
//  aTaohMall
//
//  Created by JMSHT on 2017/5/23.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirPlaneAddManView.h"

#import "AirPlaneAddPassngerViewController.h"
#import "AirPlaneEditManViewController.h"

#import "AFNetworking.h"
#import "TrainToast.h"
#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"
#import "AirSelectView.h"

#import "WKProgressHUD.h"
#import "JRToast.h"
#import "BianMinModel.h"
#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@interface AirPlaneAddManView ()<AirPlaneEditManViewDelegate,AirPlaneAddPassngerDelagate>
{
    
    NSMutableArray *_data;
    
    NSMutableArray *_Man;
    
    NSMutableArray *_NewMan;
    
    int page;
}

@end
@implementation AirPlaneAddManView


- (UIViewController*)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(void)setPageString:(NSString *)PageString
{
    
    _PageString = PageString;
    
    page = [_PageString intValue];
    
}
-(void)setManArray:(NSArray *)ManArray
{
    
    
    _ManArray = ManArray;
    
//    NSLog(@"=====_data=======%@",_data);
    NSLog(@"=====_ManArray===%@",_ManArray);
    
    
//    [self getDatas];
    
//    [_Man removeAllObjects];
//
    [_NewMan removeAllObjects];
    
    for (int i = 0; i < _data.count; i++) {
        
        UIImageView *line = (UIImageView *)[self viewWithTag:200+i];
        line.image = [UIImage imageNamed:@"未选中框"];
        
        UIControl *shareControl5 = (UIControl *)[self viewWithTag:10+i];
        shareControl5.selected = YES;
        
        
//        for (int j = 0; j < _ManArray.count; j++) {
//            
//            BianMinModel *model = _ManArray[j];
//            
//            if ([model.ManSelectString isEqualToString:@"1"]) {
//                
//                UIImageView *line = (UIImageView *)[self viewWithTag:[model.TagString integerValue]];
//                line.image = [UIImage imageNamed:@"选中"];
//                UIControl *shareControl5 = (UIControl *)[self viewWithTag:[model.TagString integerValue]-10];
//                shareControl5.selected = NO;
//                
//            }
//            
//        }
        
    }
    
    
    for (int i = 0; i < _ManArray.count; i++) {
        
        BianMinModel *model = _ManArray[i];
        
        NSLog(@"====选中==%@",model.ManSelectString);
        
        if ([model.ManSelectString isEqualToString:@"1"]) {
            
            UIImageView *line = (UIImageView *)[self viewWithTag:[model.TagString integerValue]];
            line.image = [UIImage imageNamed:@"选中"];
            UIControl *shareControl5 = (UIControl *)[self viewWithTag:[model.TagString integerValue]-190];
            
            shareControl5.selected = NO;
            
            NSLog(@"====66666===%d",shareControl5.selected);
            
            [_NewMan addObject:model];
            
            
        }else{
            
//            UIImageView *line = (UIImageView *)[self viewWithTag:[model.TagString integerValue]];
//            line.image = [UIImage imageNamed:@"未选中框"];
//            UIControl *shareControl5 = (UIControl *)[self viewWithTag:[model.TagString integerValue]-10];
//            shareControl5.selected = NO;
            
        }
        
        
    }
    
}

-(void)setManKidString:(NSString *)ManKidString
{
//    _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
    
    _ManKidString = ManKidString;
    
}
-(void)setTicketCount:(NSString *)TicketCount
{
//    _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
    
    _TicketCount = TicketCount;
    
    
    NSLog(@"====_TicketCount====%@",_TicketCount);
    
}
-(void)initManView
{
    
    for (int i = 0; i<_data.count; i++) {
        
        BianMinModel *model = _data[i];
        
        UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 50+50*i, [UIScreen mainScreen].bounds.size.width, 50)];
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
        if ([model.air_passenger isEqualToString:@"1"]) {
            
            IDLabel.text = [NSString stringWithFormat:@"成人-%@",model.passportseno];
            
        }else if ([model.air_passenger isEqualToString:@"3"]){
            
            IDLabel.text = [NSString stringWithFormat:@"婴儿-%@",model.passportseno];
            
        }else if([model.air_passenger isEqualToString:@"2"]){
            
            IDLabel.text = [NSString stringWithFormat:@"儿童-%@",model.passportseno];
        }
        
        IDLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        IDLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:12];
        [View addSubview:IDLabel];
        
        
        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(UIBounds.size.width-20-16, (50-21)/2, 20, 21)];
        line4.image = [UIImage imageNamed:@"未选中框"];
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
        shareControl5.selected=YES;
        [View addSubview:shareControl5];
        shareControl5.tag = i+10;
        [shareControl5 addTarget:self action:@selector(shareControl5:) forControlEvents:UIControlEventTouchUpInside];
        
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
        
        page=0;
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        self.sigen=[userDefaultes stringForKey:@"sigen"];
        
        
        _shareListView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 240)];
        _shareListView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
        [self addSubview:_shareListView];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 40)];
        selectView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [_shareListView addSubview:selectView];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (40-14)/2, 50, 14)];
        leftLabel.text = @"取消";
        leftLabel.textColor = [UIColor colorWithRed:88/255.0 green:168/255.0 blue:251/255.0 alpha:1.0];
        leftLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
        [selectView addSubview:leftLabel];
        
        UIControl *shareControl1 = [[UIControl alloc]initWithFrame:CGRectMake(15, 0, 50, 40)];
        [_shareListView addSubview:shareControl1];
        [shareControl1 addTarget:self action:@selector(shareControl1:) forControlEvents:UIControlEventTouchUpInside];
        
       
        UILabel *OKLabel = [[UILabel alloc] initWithFrame:CGRectMake(UIBounds.size.width-65, (40-14)/2, 50, 14)];
        OKLabel.text = @"确定";
        OKLabel.textAlignment = NSTextAlignmentRight;
        OKLabel.textColor = [UIColor colorWithRed:88/255.0 green:168/255.0 blue:251/255.0 alpha:1.0];
        OKLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:15];
        [selectView addSubview:OKLabel];
        
        UIControl *shareControl3 = [[UIControl alloc]initWithFrame:CGRectMake(UIBounds.size.width-65, 0, 50, 40)];
        [_shareListView addSubview:shareControl3];
        [shareControl3 addTarget:self action:@selector(shareControl3:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 200)];
        
        _scrollView.showsHorizontalScrollIndicator=YES;
        [_shareListView addSubview:_scrollView];
        
        UIView *AddView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        [_scrollView addSubview:AddView];
        
        UIImageView *addImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (50-15)/2, 15, 15)];
        addImgView.image = [UIImage imageNamed:@"icon-plus"];
        [AddView addSubview:addImgView];
        
        UILabel *AddLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, (50-14)/2, 100, 14)];
        AddLabel.text = @"新增乘机人";
        AddLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        AddLabel.font = [UIFont fontWithName:@"PingFang-SC-Regualr" size:14];
        [AddView addSubview:AddLabel];
        
        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 49, UIBounds.size.width-15, 1)];
        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
        [AddView addSubview:line3];
        
        UIControl *shareControl4 = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 50)];
        [AddView addSubview:shareControl4];
        [shareControl4 addTarget:self action:@selector(shareControl4:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self getDatas];
        
        
    }
    return self;
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
    
    NSLog(@"==pagepagepagepagepage==%d",page);
    
    if (page == 0) {
        
        for (int i = 0; i < _data.count; i++) {
            
            BianMinModel *model1 = _data[i];
            
            NSLog(@"==宣泄=%@",model1.ManSelectString);
            
            UIImageView *line = (UIImageView *)[self viewWithTag:200+i];
            line.image = [UIImage imageNamed:@"未选中框"];
            
            
            UIControl *shareControl5 = (UIControl *)[self viewWithTag:10+i];
            shareControl5.selected = YES;
            
            
            for (int j = 0; j < _ManArray.count; j++) {
                
                BianMinModel *model = _ManArray[j];
                
                if (![model1.username isEqualToString:model.username]) {
                    
                    model1.ManSelectString = @"0";
                    
                }
                
            }
            
        }
        
        
        if (_delegate && [_delegate respondsToSelector:@selector(CanClePerson:)]) {
            
            [_delegate CanClePerson:_ManArray];
            
        }
        [_NewMan removeAllObjects];
        
    }
    
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
    NSLog(@"取消");
    
    if (page == 0) {
        
        for (int i = 0; i < _data.count; i++) {
            
            BianMinModel *model1 = _data[i];
            
            NSLog(@"==宣泄=%@",model1.ManSelectString);
            
            UIImageView *line = (UIImageView *)[self viewWithTag:200+i];
            line.image = [UIImage imageNamed:@"未选中框"];
            
            
            UIControl *shareControl5 = (UIControl *)[self viewWithTag:10+i];
            shareControl5.selected = YES;
            
            
            for (int j = 0; j < _ManArray.count; j++) {
                
                BianMinModel *model = _ManArray[j];
                
                if (![model1.username isEqualToString:model.username]) {
                    
                    model1.ManSelectString = @"0";
                    
                }
                
            }
            
        }
        
        
        if (_delegate && [_delegate respondsToSelector:@selector(CanClePerson:)]) {
            
            [_delegate CanClePerson:_ManArray];
            
        }
        [_NewMan removeAllObjects];
        
    }
    
    
    [self hideInView];
}


- (void)shareControl3:(UIControl *)sender
{
    NSLog(@"确定");
    
    [_Man removeAllObjects];
    [_NewMan removeAllObjects];
    
    for (BianMinModel *model in _data) {
        
        if ([model.ManSelectString isEqualToString:@"1"]) {
            
            [_Man addObject:model];
            
            [_NewMan addObject:model];
            
        }
//        NSLog(@"====选中人==%@",model.ManSelectString);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(AirPlaneAddMan:)]) {
        
        [_delegate AirPlaneAddMan:_Man];
    }
    
    page=1;
    [self hideInView];
}
//添加
- (void)shareControl4:(UIControl *)sender
{
    NSLog(@"添加乘车人");
//    [self hideInView];
    
    if (_data.count >= 15) {
        
        
        [TrainToast showWithText:@"最多可添加15位乘机人" duration:2.0f];
        
    }else{
        
        
        AirPlaneAddPassngerViewController *vc = [[AirPlaneAddPassngerViewController alloc] init];
        
        vc.delegate = self;
        self.viewController.navigationController.navigationBar.hidden=YES;
        [self.viewController.navigationController pushViewController:vc animated:NO];
    }
    
    
    
}

//选择
- (void)shareControl5:(UIControl *)sender
{
    UIImageView *label = (UIImageView *)[self viewWithTag:sender.tag+190];
    
    BianMinModel *model = _data[sender.tag-10];
    
    model.TagString = [NSString stringWithFormat:@"%ld",sender.tag+190];
    
//    NSLog(@"==username==%@==ManKidString==%@==model.passporttypeseid==%@===%d",model.username,_ManKidString,model.air_passenger,sender.selected);
    
    
    NSLog(@"====77777===%d",sender.selected);
    
    if (sender.selected) {
        
        NSLog(@"选中");
        
        NSLog(@"===_Man.count===%ld",(long)_NewMan.count);
        
        
        if (_NewMan.count >= [_TicketCount intValue]) {
            
            
            [TrainToast showWithText:[NSString stringWithFormat:@"坐席不足，最多可选择%d位乘客",[_TicketCount intValue]] duration:2.0f];
            
            
        }else if(_NewMan.count >= 9){
            
            
            [TrainToast showWithText:[NSString stringWithFormat:@"最多可选择9位乘客"] duration:2.0f];
            
        }else if(![model.air_passenger isEqualToString:_ManKidString]){
            
            if ([_ManKidString isEqualToString:@"1"]) {
                
                
                [TrainToast showWithText:[NSString stringWithFormat:@"乘机人只能添加成人"] duration:2.0f];
                
            }else if ([_ManKidString isEqualToString:@"2"]){
                
                
                [TrainToast showWithText:[NSString stringWithFormat:@"乘机人只能添加儿童"] duration:2.0f];
                
            }
            
            
        }else{
            
            
            model.ManSelectString = @"1";
            [_NewMan addObject:model];
            
            label.image = [UIImage imageNamed:@"选中"];
            
            sender.selected = !sender.selected;
            
//            page++;
        }
        
        
    }else{
        
        NSLog(@"不选中");
        
        model.ManSelectString = @"0";
        [_NewMan removeObject:model];
        
        label.image = [UIImage imageNamed:@"未选中框"];
        
        sender.selected=YES;
        
//        page--;
        
    }
    
}

//编辑
- (void)shareControl6:(UIControl *)sender
{
    
    NSLog(@"===%ld",(long)sender.tag);
    
    BianMinModel *model = _data[sender.tag-100];
    
    AirPlaneEditManViewController *vc = [[AirPlaneEditManViewController alloc] init];
    vc.ManId  = model.ManId;
    vc.ManUid = model.ManUid;
    vc.passenger_name = model.username;
    vc.certificate_type = model.passporttypeseid;
    vc.certificate_number = model.passportseno;
    vc.passenger_phone = model.phone;
    vc.delegate=self;
    
    self.viewController.navigationController.navigationBar.hidden=YES;
    [self.viewController.navigationController pushViewController:vc animated:NO];
    
}
-(void)huiseControlClick{
    
    
    
    [self hideInView];
}

//添加代理
-(void)AirPlaneAddPassnger
{
    
    [self getDatas];
    
}
//编辑、删除代理
-(void)AirPlaneEditManReload
{
    [self getDatas];
    
}
-(void)getDatas
{
    
    [_Man removeAllObjects];
    
//    _huiseControl.backgroundColor=RGBACOLOR(0, 0, 0, 0.74);
    
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
    
    NSString *url = [NSString stringWithFormat:@"%@getAirPassenger_mob.shtml",URL_Str];
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
                    model.phone = [NSString stringWithFormat:@"%@",dict[@"phone"]];
                    model.ManSelectString = @"0";
                    
                    [_data addObject:model];
                    
                }
                
                _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 50*(_data.count+1));
                
                [self initManView];
                
            }else{
                
                
//                [JRToast showWithText:dic[@"message"] duration:2.0f];
                
            }
            

            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"%@",error);
        
        
    }];
    
}

@end
