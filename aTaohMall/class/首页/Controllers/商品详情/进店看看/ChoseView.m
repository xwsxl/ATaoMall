
//
//  ChoseView.m
//  AddShoppingCart
//
//  Created by 主用户 on 16/3/23.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "ChoseView.h"
#import "UIImageView+WebCache.h"

#import "GoodsAttributeModel.h"
#import "AFNetworking.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"

#import "UserMessageManager.h"
#import "NewLoginViewController.h"

#import "WKProgressHUD.h"
#import "JRToast.h"

#import "XSInfoView.h"

#import "SVProgressHUD.h"
#import "PersonalShoppingDanDetailVC.h"
#import "PersonalAllDanVC.h"

@interface ChoseView()<LoginMessageDelegate,UIAlertViewDelegate>
{
    NSMutableArray *newArrM;
    NSMutableArray *newArrM1;
    NSMutableArray *newArrM2;
    NSMutableArray *newArrM3;
    
    NSString *string;
    NSString *string1;
    NSString *string5;
    NSString *string6;
    
    UIButton *button5;
    UIButton *button6;
    UIButton *button7;
    UIButton *button8;
    
    NSString *ytColor;
    NSString *ytSize;
    NSString *ytStyle;
    NSString *ytMianLiao;
    
    UIView *view;
    
}
@end

@implementation ChoseView
@synthesize alphaiView,whiteView,img,lb_detail,lb_price,lb_stock,mainscrollview,sizeView,colorView,countView,bt_sure,bt_cart,bt_nowbuy,bt_cancle,lb_line,colorarr,sizearr,stock,stockdic,arr3,arr4,arr5,arr3View,arr4View,lb_arr3,lb_arr4,Goods_type,Goods_status,gid1;

- (UIViewController*)viewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"yangtao" object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChoseViewReloadData:) name:@"ChoseViewReloadData" object:nil];
        
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChoseViewReloadData1:) name:@"ChoseViewReloadData1" object:nil];
        
        NSLog(@"=====self.Goods_type======%@",self.Goods_type);
        
    
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        
         NSLog(@"==属性框的高度==%ld",[userDefaultes stringForKey:@"height"].length);
        
        self.backgroundColor = [UIColor clearColor];
        
        
        //半透明视图
        alphaiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        //        alphaiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        alphaiView.backgroundColor = [UIColor clearColor];
        
        alphaiView.alpha = 0.1;
        
        [self addSubview:alphaiView];
        
        NSLog(@"=屏幕高度=%f",[UIScreen mainScreen].bounds.size.height);
        
        NSLog(@"====self.superview====%@",self.superclass);
        
        if ([UIScreen mainScreen].bounds.size.height <= 568.000000) {
            
            
            
            if ([userDefaultes stringForKey:@"height"].length==0) {
                
                NSLog(@"11111&&**&*&**&*&*");
                
                //装载商品信息的视图
                whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width, self.frame.size.height-100)];
                
            }else{
                
                NSLog(@"22222&&**&*&**&*&*");
                
                //装载商品信息的视图
                whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.frame.size.width, self.frame.size.height-200)];
                
            }
            
            
        }else{
            
            
            
            if ([userDefaultes stringForKey:@"height"].length==0) {
                
                NSLog(@"333333&&**&*&**&*&*");
                
                //装载商品信息的视图
                whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.frame.size.width, self.frame.size.height-200)];
                
            }else{
                
                NSLog(@"44444&&**&*&**&*&*");
                
                //装载商品信息的视图
                whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, self.frame.size.width, self.frame.size.height-300)];
                
            }
            
        }
        
        
        
        
//        whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100)];
        
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [whiteView addGestureRecognizer:tap];
        
        
        //图片添加框
//        UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(9, -21, 1, 102)];
//        line1.image = [UIImage imageNamed:@"分割线YT"];
//        [whiteView addSubview:line1];
//        
//        UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(110, -21, 1, 102)];
//        line2.image = [UIImage imageNamed:@"分割线YT"];
//        [whiteView addSubview:line2];
//        
//        UIImageView *line3 = [[UIImageView alloc] initWithFrame:CGRectMake(9, -21, 102, 1)];
//        line3.image = [UIImage imageNamed:@"分割线-拷贝"];
//        [whiteView addSubview:line3];
//        
//        UIImageView *line4 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 81, 102, 1)];
//        line4.image = [UIImage imageNamed:@"分割线-拷贝"];
//        [whiteView addSubview:line4];
        
        
        UIView *ImgView = [[UIView alloc] initWithFrame:CGRectMake(10, -20, 100, 100)];
        
//        ImgView.layer.cornerRadius  = 4;
//        ImgView.layer.masksToBounds = YES;
        
        
        
        [whiteView addSubview:ImgView];
        //商品图片
        img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        img.image = [UIImage imageNamed:@"1.jpg"];
        
        img.backgroundColor = [UIColor yellowColor];
        img.layer.cornerRadius = 4;
        img.layer.borderColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0].CGColor;
        img.layer.borderWidth = 1;
        
        img.layer.cornerRadius  = 4;
        img.layer.masksToBounds = YES;
        
        [img.layer setMasksToBounds:YES];
        
        [ImgView addSubview:img];
        
        bt_cancle= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_cancle.frame = CGRectMake(whiteView.frame.size.width-30, 10,20, 20);
        [bt_cancle setBackgroundImage:[UIImage imageNamed:@"删除按钮"] forState:0];
        [whiteView addSubview:bt_cancle];
        
        //商品价格
        lb_price = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, 10, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 20)];
        lb_price.textColor = [UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0];
        lb_price.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:lb_price];
        //商品库存
        lb_stock = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, lb_price.frame.origin.y+lb_price.frame.size.height, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 20)];
        lb_stock.textColor = [UIColor blackColor];
        lb_stock.font = [UIFont systemFontOfSize:14];
        [whiteView addSubview:lb_stock];
        //用户所选择商品的尺码和颜色
//        NSLog(@"kkkkkkkk=%f,%f",lb_stock.frame.origin.y,lb_stock.frame.size.height);
        lb_detail = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, lb_stock.frame.origin.y+lb_stock.frame.size.height+lb_arr3.frame.size.height+lb_arr4.frame.size.height, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40)+50, 40)];
        lb_detail.numberOfLines = 2;
//        lb_detail.shadowOffset=CGSizeMake(0, -1);
        lb_detail.textColor = [UIColor blackColor];
        lb_detail.font = [UIFont systemFontOfSize:14];
//        lb_detail.backgroundColor = [UIColor greenColor];
        [whiteView addSubview:lb_detail];
        //分界线
        
        
        lb_line = [[UILabel alloc] initWithFrame:CGRectMake(20, img.frame.origin.y+img.frame.size.height, whiteView.frame.size.width-40, 0.5)];
        lb_line.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        [whiteView addSubview:lb_line];
        
//        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(20, img.frame.origin.y+img.frame.size.height, whiteView.frame.size.width-40, 0.5)];
//        
//        line.image = [UIImage imageNamed:@"分割线-拷贝"];
//        
//        [whiteView addSubview:line];
        
        //确定按钮
        bt_sure= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_sure.frame = CGRectMake(0, whiteView.frame.size.height-50,whiteView.frame.size.width, 50);
        [bt_sure setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        [bt_sure setTitleColor:[UIColor whiteColor] forState:0];
        bt_sure.titleLabel.font = [UIFont systemFontOfSize:20];
        [bt_sure setTitle:@"确定" forState:0];
        [whiteView addSubview:bt_sure];
        
        
        bt_cart= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_cart.frame = CGRectMake(0, whiteView.frame.size.height-50,whiteView.frame.size.width/2, 50);
        [bt_cart setBackgroundColor:[UIColor orangeColor]];
        [bt_cart setTitleColor:[UIColor whiteColor] forState:0];
        bt_cart.titleLabel.font = [UIFont systemFontOfSize:20];
        [bt_cart setTitle:@"加入购物车" forState:0];
        bt_cart.userInteractionEnabled=YES;
        
        [whiteView addSubview:bt_cart];
        
        
        bt_nowbuy= [UIButton buttonWithType:UIButtonTypeCustom];
        bt_nowbuy.frame = CGRectMake(whiteView.frame.size.width/2, whiteView.frame.size.height-50,whiteView.frame.size.width/2, 50);
        [bt_nowbuy setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        [bt_nowbuy setTitleColor:[UIColor whiteColor] forState:0];
        bt_nowbuy.titleLabel.font = [UIFont systemFontOfSize:20];
        [bt_nowbuy setTitle:@"立即购买" forState:0];
        bt_nowbuy.userInteractionEnabled=YES;
        
        [whiteView addSubview:bt_nowbuy];
        
        
        
        //有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看
        mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, lb_line.frame.origin.y+lb_line.frame.size.height, whiteView.frame.size.width, bt_sure.frame.origin.y-(lb_line.frame.origin.y+lb_line.frame.size.height))];
        mainscrollview.showsHorizontalScrollIndicator = NO;
        mainscrollview.showsVerticalScrollIndicator = NO;
        
//        mainscrollview.contentSize =  CGSizeMake(0, [UIScreen mainScreen].bounds.size.width-40);
        
        [whiteView addSubview:mainscrollview];
        //购买数量的视图
        countView = [[BuyCountView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        
        [mainscrollview addSubview:countView];
        [countView.bt_add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
        countView.tf_count.delegate = self;
        countView.tf_count.keyboardType=UIKeyboardTypeNumberPad;
        [countView.bt_reduce addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}


- (void)ChoseViewReloadData1:(NSNotification *)text{
    
    //创建菊花
    WKProgressHUD *hud = [WKProgressHUD showInView:self withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [hud dismiss:YES];
        
    });
    
}


- (void)ChoseViewReloadData:(NSNotification *)text{
    
    //创建菊花
    WKProgressHUD *hud = [WKProgressHUD showInView:self withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [hud dismiss:YES];
        
    });
    
}
- (void)tongzhi:(NSNotification *)text{
    
    
    NSDictionary *dict=text.userInfo;
    
    NSString *user=dict[@"userid"];
    
    NSLog(@"PPPPPPPPPPPPPPPPPPPPPP=====%@",user);
    
    self.yangtao=user;
}


-(void)setSigenWithString:(NSString *)string1 andStatusWithString:(NSString *)string2 andIntegralWithString:(NSString *)string3 andPhoneWithString:(NSString *)string4 andHeaderImageWithString:(NSString *)string5 andUserId:(NSString *)string6
{
    
    NSLog(@"=++++++++choseView++++^^^^^^^^^&&&&&&&&");
}


-(void)initTypeView:(NSArray *)sizeArr :(NSArray *)colorArr :(NSArray *)Arr3 :(NSArray *)Arr4 :(NSArray *)Arr5 :(NSDictionary *)stockDic andGoodsImageView:(NSString *)imgStr andMoney:(NSString *)money andJiFen:(NSString *)jifen andKuCun:(NSString *)kucun andCount:(NSString *)count andGoods_type:(NSString *)type andStatus:(NSString *)status andGid:(NSString *)gid andYTBack:(NSString *)ytback andMid:(NSString *)mid andYYY:(NSString *)yyyyy andSmallIds:(NSString *)smallIds andStorename:(NSString *)storename andLogo:(NSString *)logo andSendWayType:(NSString *)sendWayType andMoneyType:(NSString *)MoneyType andCut:(NSString *)cut
{
    NSLog(@"===>>>>===type==mid==%@=====%@====smallIds====%@",type,mid,smallIds);
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    if ([cut isEqualToString:@"100"]) {
        
        countView.hidden=YES;
        
    }
    self.Goods_type = type;
    
    if ([type isEqualToString:@"1"] || [yyyyy isEqualToString:@"1"] || [yyyyy isEqualToString:@"2"] || [yyyyy isEqualToString:@"666"]) {
        
        
        //确定按钮
        
        bt_sure.hidden=NO;
        
        bt_cart.hidden=YES;
        
        bt_nowbuy.hidden = YES;
        
        
        
    }else{
        
        
        
        bt_sure.hidden=YES;
        
        bt_cart.hidden=NO;
        
        bt_nowbuy.hidden = NO;
       
        
        
        
    }
    
    
    
    
    sizearr = sizeArr;
    colorarr = colorArr;
    stockdic = stockDic;
    arr3 = Arr3;
    arr4 = Arr4;
    arr5 = Arr5;
    Goods_type=type;
    Goods_status=status;
    
    gid1=gid;
    
    CGFloat fheight=0;
    self.count = count;
    
//    [img sd_setImageWithURL:[NSURL URLWithString:imgStr]];
    
    [img sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"default_image"] options:SDWebImageProgressiveDownload];
    
    if ([jifen isEqualToString:@""] || [jifen isEqualToString:@"0.00"]) {
        
        lb_price.text=[NSString stringWithFormat:@"￥%.02f",[money floatValue]];
        
    }else if ([money isEqualToString:@""] || [money isEqualToString:@"0.00"]){
        
        lb_price.text=[NSString stringWithFormat:@"%.02f积分",[jifen floatValue]];
        
    }else{
        
        lb_price.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",[money floatValue],[jifen floatValue]];
    }
    
    NSLog(@"======HuanCunShuXingStock======%@==kucun==%@",[userDefaultes stringForKey:@"HuanCunShuXingStock"],kucun);
    
    if ([userDefaultes stringForKey:@"HuanCunShuXingStock"].length==0) {
        
        lb_stock.text=[NSString stringWithFormat:@"库存%@件",kucun];
        
    }else{
        
        
        lb_stock.text=[NSString stringWithFormat:@"库存%@件",[userDefaultes stringForKey:@"HuanCunShuXingStock"]];
    }
    
    
    
    for (NSInteger i = 0; i<[arr5 count]; i++) {
    
        NSString *str = [Arr5 objectAtIndex:i];
        
        if (i==0) {
            
        
        //尺码
    sizeView = [[TypeView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-20, 50) andDatasource:sizearr :str];
    sizeView.delegate = self;
    [mainscrollview addSubview:sizeView];
    sizeView.frame = CGRectMake(10, 0, self.frame.size.width-20, sizeView.height);
            fheight += sizeView.frame.size.height;
       }
        if (i==1) {
        //颜色分类
        colorView = [[TypeView alloc] initWithFrame:CGRectMake(10, fheight, self.frame.size.width-20, 50) andDatasource:colorarr :str];
        colorView.delegate = self;
        [mainscrollview addSubview:colorView];
        colorView.frame = CGRectMake(10,sizeView.frame.size.height, self.frame.size.width-20, colorView.height);
            fheight += colorView.frame.size.height;
        }
        if (i == 2) {
            arr3View = [[TypeView alloc] initWithFrame:CGRectMake(10,fheight+arr3View.frame.size.height, self.frame.size.width-20, 50) andDatasource:arr3 :str];
            arr3View.delegate = self;
            [mainscrollview addSubview:arr3View];
            arr3View.frame = CGRectMake(10,fheight, self.frame.size.width-20, arr3View.height);
            fheight += arr3View.frame.size.height;
        }
        if (i == 3) {
            arr4View = [[TypeView alloc] initWithFrame:CGRectMake(10, fheight + arr4View.frame.size.height, self.frame.size.width-20, 50) andDatasource:arr4 :str];
            arr4View.delegate = self;
            [mainscrollview addSubview:arr4View];
            arr4View.frame = CGRectMake(10,fheight, self.frame.size.width-20, arr4View.height);
            fheight += arr4View.frame.size.height;
        }
        
//        NSLog(@"pppppppp=%f",fheight);
        
    }
    

    countView.frame = CGRectMake(10, fheight, self.frame.size.width-20, 50);
    mainscrollview.contentSize = CGSizeMake(self.frame.size.width, countView.frame.size.height+countView.frame.origin.y);
    
//    lb_price.text = @"¥100";
//    lb_stock.text = @"库存100000件";
    lb_detail.text = @"请选择 尺码 颜色分类";
    
    //点击图片放大图片
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    img.userInteractionEnabled = YES;
    [img addGestureRecognizer:tap1];
    
    
    
    NSArray *array;
    
    if ([smallIds isEqualToString:@""]) {
        
        array = nil;
        
        
    }else{
        
        NSString *shu = smallIds;
    
        array = [shu componentsSeparatedByString:@"_"];
        
    }
    
    
    NSLog(@"====array==%ld===%@",array.count,array);
    
    NSLog(@"+++%@++++%@++++++%@+++++%@++",[userDefaultes stringForKey:@"color"],[userDefaultes stringForKey:@"size"],[userDefaultes stringForKey:@"style"],[userDefaultes stringForKey:@"mianliao"]);
    
    NSLog(@"+--+---+%@+--++--+%@++--+++--+%@+++++%@++",[userDefaultes stringForKey:@"color1"],[userDefaultes stringForKey:@"size1"],[userDefaultes stringForKey:@"style1"],[userDefaultes stringForKey:@"mianliao1"]);
    
    
    NSLog(@"====%lu======%lu=====%lu======%lu==",(unsigned long)colorArr.count,(unsigned long)sizeArr.count,(unsigned long)Arr3.count,Arr4.count);
    
    
    
    //再次缓存
    
    if ([userDefaultes stringForKey:@"color"].length > 0) {
        
        [UserMessageManager GoodsColor2:[userDefaultes stringForKey:@"color"]];
        
 //       [UserMessageManager GoodsColor2:[userDefaultes stringForKey:@"color1"]];
        
        
    }
    
    if ([userDefaultes stringForKey:@"size"].length > 0) {
        
        [UserMessageManager GoodsSize2:[userDefaultes stringForKey:@"size"]];
        
//        [UserMessageManager GoodsSize2:[userDefaultes stringForKey:@"size1"]];
        
    }
    
    if ([userDefaultes stringForKey:@"style"].length > 0) {
        
        [UserMessageManager GoodsStyle2:[userDefaultes stringForKey:@"style"]];
        
 //       [UserMessageManager GoodsStyle2:[userDefaultes stringForKey:@"style1"]];
    }
    
    if ([userDefaultes stringForKey:@"mianliao"].length > 0) {
        
        [UserMessageManager GoodsMianLiao2:[userDefaultes stringForKey:@"mianliao"]];
        
//        [UserMessageManager GoodsMianLiao2:[userDefaultes stringForKey:@"mianliao1"]];
        
    }
    
    
    NSLog(@"==再次缓存长度==%@=%@=%@=%@",[userDefaultes stringForKey:@"color"],[userDefaultes stringForKey:@"size"],[userDefaultes stringForKey:@"style"],[userDefaultes stringForKey:@"mianliao"]);
    
    //=====================================================
    
    
    
    
    //=====================================================
    if ([userDefaultes stringForKey:@"color"].length>0) {
        
        //        [self resumeBtn:colorarr :colorView];
        //        [ self resumeBtn:arr3 :arr3View];
        //        [self resumeBtn:arr4 :arr4View];
        
        if (array.count==0) {
            
            
            sizeView.seletIndex=[[userDefaultes stringForKey:@"color"] intValue];
            
            [self resumeBtn:sizearr :sizeView];
            
            ytColor=[userDefaultes stringForKey:@"color"];
            
        }else if (array.count==1){
            
            
            for (int i = 0; i< sizearr.count; i++) {
                
                GoodsAttributeModel *model=sizearr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    sizeView.seletIndex=[array[0] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[0];
                    
                    
                }
                
            }
            
            
        }else if (array.count==2){
            
            
            
            for (int i = 0; i< sizearr.count; i++) {
                
                GoodsAttributeModel *model=sizearr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    sizeView.seletIndex=[array[0] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    sizeView.seletIndex=[array[1] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[1];
                    
                    
                }
                
                
            }
            
            
            
        }else if (array.count==3){
            
            
            
            for (int i = 0; i< sizearr.count; i++) {
                
                GoodsAttributeModel *model=sizearr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    sizeView.seletIndex=[array[0] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    sizeView.seletIndex=[array[1] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    sizeView.seletIndex=[array[2] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[2];
                    
                    
                }
                
                
            }
            
            
            
            
        }else if (array.count==4){
            
            
            
            for (int i = 0; i< sizearr.count; i++) {
                
                GoodsAttributeModel *model=sizearr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    sizeView.seletIndex=[array[0] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    sizeView.seletIndex=[array[1] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    sizeView.seletIndex=[array[2] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[2];
                    
                    
                }else if([model.mallId intValue] == [array[3] intValue]){
                    
                    sizeView.seletIndex=[array[3] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[3];
                    
                    
                }
            }
        }
        
    }else{
        
        
        
        
        if (array.count==0) {
            
            NSLog(@"666666");
            sizeView.seletIndex=[[userDefaultes stringForKey:@"color1"] intValue];
            
            [self resumeBtn:sizearr :sizeView];
            
            ytColor=[userDefaultes stringForKey:@"color1"];
            
            
        }else if (array.count==1){
            
            NSLog(@"7777777");
            
            for (int i = 0; i< sizearr.count; i++) {
                
                GoodsAttributeModel *model=sizearr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    sizeView.seletIndex=[array[0] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[0];
                    
                    
                }
                
                
            }
            
            
        }else if (array.count==2){
            
            NSLog(@"888888====%ld",sizearr.count);
            
            
            for (int i = 0; i< sizearr.count; i++) {
                
                GoodsAttributeModel *model=sizearr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    sizeView.seletIndex=[array[0] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[0];
                    
                    NSLog(@"===1========%@",ytColor);
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    
                    
                    
                    sizeView.seletIndex=[array[1] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[1];
                    
                    NSLog(@"===2========%@",ytColor);
                    
                    
                }
                
                
                
            }
            
            
        }else if (array.count==3){
            
            NSLog(@"999999");
            
            for (int i = 0; i< sizearr.count; i++) {
                
                GoodsAttributeModel *model=sizearr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    sizeView.seletIndex=[array[0] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    sizeView.seletIndex=[array[1] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    sizeView.seletIndex=[array[2] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[2];
                    
                    
                }
                
                
            }
            
            
            
            
        }else if (array.count==4){
            
            NSLog(@"555555");
            
            for (int i = 0; i< sizearr.count; i++) {
                
                GoodsAttributeModel *model=sizearr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    sizeView.seletIndex=[array[0] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    sizeView.seletIndex=[array[1] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    sizeView.seletIndex=[array[2] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[2];
                    
                    
                }else if([model.mallId intValue] == [array[3] intValue]){
                    
                    sizeView.seletIndex=[array[3] intValue];
                    
                    [self resumeBtn:sizearr :sizeView];
                    
                    ytColor=array[3];
                    
                    
                }
                
            }
            
        }
        
    }
    
    if ([userDefaultes stringForKey:@"size"].length>0) {
        
        
        
        //        [self resumeBtn:sizearr :sizeView];
        //       [ self resumeBtn:arr3 :arr3View];
        //       [self resumeBtn:arr4 :arr4View];
        
        
        if (array.count==0) {
            
            
            colorView.seletIndex=[[userDefaultes stringForKey:@"size"] intValue];
            [self resumeBtn:colorarr :colorView];
            
            ytSize=[userDefaultes stringForKey:@"size"];
            
            
        }else if (array.count==1){
            
            
            for (int i = 0; i< colorarr.count; i++) {
                
                GoodsAttributeModel *model=colorarr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    colorView.seletIndex=[array[0] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[0];
                    
                    
                }
                
            }
            
            
        }else if (array.count==2){
            
            for (int i = 0; i< colorarr.count; i++) {
                
                GoodsAttributeModel *model=colorarr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    colorView.seletIndex=[array[0] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    colorView.seletIndex=[array[1] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[1];
                    
                    
                }
                
            }
            
            
        }else if (array.count==3){
            
            
            for (int i = 0; i< colorarr.count; i++) {
                
                GoodsAttributeModel *model=colorarr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    colorView.seletIndex=[array[0] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    colorView.seletIndex=[array[1] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    colorView.seletIndex=[array[2] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[2];
                    
                    
                }
                
            }
            
            
            
        }else if (array.count==4){
            
            
            for (int i = 0; i< colorarr.count; i++) {
                
                GoodsAttributeModel *model=colorarr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    colorView.seletIndex=[array[0] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    colorView.seletIndex=[array[1] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    colorView.seletIndex=[array[2] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[2];
                    
                    
                }else if([model.mallId intValue] == [array[3] intValue]){
                    
                    colorView.seletIndex=[array[3] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[3];
                    
                    
                }
            }
        }
        
    }else{
        
        if (array.count==0) {
            
            
            colorView.seletIndex=[[userDefaultes stringForKey:@"size1"] intValue];
            [self resumeBtn:colorarr :colorView];
            
            ytSize=[userDefaultes stringForKey:@"size1"];
            
            
        }else if (array.count==1){
            
            
            for (int i = 0; i< colorarr.count; i++) {
                
                GoodsAttributeModel *model=colorarr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    colorView.seletIndex=[array[0] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[0];
                    
                    
                }
                
            }
            
            
        }else if (array.count==2){
            
            for (int i = 0; i< colorarr.count; i++) {
                
                GoodsAttributeModel *model=colorarr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    colorView.seletIndex=[array[0] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    colorView.seletIndex=[array[1] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[1];
                    
                    
                }
                
            }
            
            
        }else if (array.count==3){
            
            
            for (int i = 0; i< colorarr.count; i++) {
                
                GoodsAttributeModel *model=colorarr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    colorView.seletIndex=[array[0] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    colorView.seletIndex=[array[1] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    colorView.seletIndex=[array[2] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[2];
                    
                    
                }
                
            }
            
            
            
        }else if (array.count==4){
            
            
            for (int i = 0; i< colorarr.count; i++) {
                
                GoodsAttributeModel *model=colorarr[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    colorView.seletIndex=[array[0] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    colorView.seletIndex=[array[1] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    colorView.seletIndex=[array[2] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[2];
                    
                    
                }else if([model.mallId intValue] == [array[3] intValue]){
                    
                    colorView.seletIndex=[array[3] intValue];
                    [self resumeBtn:colorarr :colorView];
                    
                    ytSize=array[3];
                    
                    
                }
            }
        }
    }
    
    if ([userDefaultes stringForKey:@"style"].length>0) {
        
        
        //        [self resumeBtn:colorarr :colorView];
        //        [self resumeBtn:sizearr :sizeView];
        
        //        [self resumeBtn:arr4 :arr4View];
        
        
        
        if (array.count==0) {
            
            
            arr3View.seletIndex=[[userDefaultes stringForKey:@"style"] intValue];
            [self resumeBtn:arr3 :arr3View];
            
            ytStyle=[userDefaultes stringForKey:@"style"];
            
            
        }else if (array.count==1){
            
            
            for (int i = 0; i< arr3.count; i++) {
                
                GoodsAttributeModel *model=arr3[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr3View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[0];
                    
                    
                }
            }
            
            
        }else if (array.count==2){
            
            for (int i = 0; i< arr3.count; i++) {
                
                GoodsAttributeModel *model=arr3[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr3View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    arr3View.seletIndex=[array[1] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[1];
                    
                    
                }
            }
            
            
        }else if (array.count==3){
            
            
            for (int i = 0; i< arr3.count; i++) {
                
                GoodsAttributeModel *model=arr3[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr3View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    arr3View.seletIndex=[array[1] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    arr3View.seletIndex=[array[2] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[2];
                    
                    
                }
                
            }
            
            
        }else if (array.count==4){
            
            
            for (int i = 0; i< arr3.count; i++) {
                
                GoodsAttributeModel *model=arr3[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr3View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    arr3View.seletIndex=[array[1] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    arr3View.seletIndex=[array[2] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[2];
                    
                    
                }else if([model.mallId intValue] == [array[3] intValue]){
                    
                    arr3View.seletIndex=[array[3] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[3];
                    
                    
                }
            }
        }
        
    }else{
        
        if (array.count==0) {
            
            
            arr3View.seletIndex=[[userDefaultes stringForKey:@"style1"] intValue];
            [self resumeBtn:arr3 :arr3View];
            
            ytStyle=[userDefaultes stringForKey:@"style1"];
            
            
        }else if (array.count==1){
            
            
            for (int i = 0; i< arr3.count; i++) {
                
                GoodsAttributeModel *model=arr3[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr3View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[0];
                    
                    
                }
            }
            
            
        }else if (array.count==2){
            
            for (int i = 0; i< arr3.count; i++) {
                
                GoodsAttributeModel *model=arr3[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr3View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    arr3View.seletIndex=[array[1] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[1];
                    
                    
                }
            }
            
            
        }else if (array.count==3){
            
            
            for (int i = 0; i< arr3.count; i++) {
                
                GoodsAttributeModel *model=arr3[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr3View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    arr3View.seletIndex=[array[1] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    arr3View.seletIndex=[array[2] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[2];
                    
                    
                }
                
            }
            
            
        }else if (array.count==4){
            
            
            for (int i = 0; i< arr3.count; i++) {
                
                GoodsAttributeModel *model=arr3[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr3View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    arr3View.seletIndex=[array[1] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    arr3View.seletIndex=[array[2] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[2];
                    
                    
                }else if([model.mallId intValue] == [array[3] intValue]){
                    
                    arr3View.seletIndex=[array[3] intValue];
                    [self resumeBtn:arr3 :arr3View];
                    
                    ytStyle=array[3];
                    
                    
                }
            }
        }
    }
    
    
    if ([userDefaultes stringForKey:@"mianliao"].length>0) {
        
        
        //        [self resumeBtn:colorarr :colorView];
        //        [self resumeBtn:sizearr :sizeView];
        //       [ self resumeBtn:arr3 :arr3View];
        
        
        
        if (array.count==0) {
            
            
            arr4View.seletIndex=[[userDefaultes stringForKey:@"mianliao"] intValue];
            [self resumeBtn:arr4 :arr4View];
            
            ytMianLiao=[userDefaultes stringForKey:@"mianliao"];
            
            
        }else if (array.count==1){
            
            
            for (int i = 0; i< arr4.count; i++) {
                
                GoodsAttributeModel *model=arr4[i];
                
                NSLog(@"=======%@",model.mallId);
                
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr4View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[0];
                    
                    
                }
                
            }
            
            
            
        }else if (array.count==2){
            
            
            for (int i = 0; i< arr4.count; i++) {
                
                GoodsAttributeModel *model=arr4[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr4View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    arr4View.seletIndex=[array[1] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[1];
                    
                    
                }
                
                
            }
            
            
            
        }else if (array.count==3){
            
            
            for (int i = 0; i< arr4.count; i++) {
                
                GoodsAttributeModel *model=arr4[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr4View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    arr4View.seletIndex=[array[1] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    arr4View.seletIndex=[array[2] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[2];
                    
                    
                }
                
            }
            
            
            
        }else if (array.count==4){
            
            for (int i = 0; i< arr4.count; i++) {
                
                GoodsAttributeModel *model=arr4[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr4View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    arr4View.seletIndex=[array[1] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    arr4View.seletIndex=[array[2] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[2];
                    
                    
                }else if([model.mallId intValue] == [array[3] intValue]){
                    
                    arr4View.seletIndex=[array[3] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[3];
                    
                    
                }
            }
        }
        
    }else{
        
        if (array.count==0) {
            
            
            arr4View.seletIndex=[[userDefaultes stringForKey:@"mianliao1"] intValue];
            [self resumeBtn:arr4 :arr4View];
            
            ytMianLiao=[userDefaultes stringForKey:@"mianliao1"];
            
            
        }else if (array.count==1){
            
            
            for (int i = 0; i< arr4.count; i++) {
                
                GoodsAttributeModel *model=arr4[i];
                
                NSLog(@"=======%@",model.mallId);
                
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr4View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[0];
                    
                    
                }
                
            }
            
            
            
        }else if (array.count==2){
            
            
            for (int i = 0; i< arr4.count; i++) {
                
                GoodsAttributeModel *model=arr4[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr4View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    arr4View.seletIndex=[array[1] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[1];
                    
                    
                }
                
                
            }
            
            
            
        }else if (array.count==3){
            
            
            for (int i = 0; i< arr4.count; i++) {
                
                GoodsAttributeModel *model=arr4[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr4View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    arr4View.seletIndex=[array[1] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    arr4View.seletIndex=[array[2] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[2];
                    
                    
                }
                
            }
            
            
            
        }else if (array.count==4){
            
            for (int i = 0; i< arr4.count; i++) {
                
                GoodsAttributeModel *model=arr4[i];
                
                NSLog(@"=======%@",model.mallId);
                
                if([model.mallId intValue] == [array[0] intValue]){
                    
                    arr4View.seletIndex=[array[0] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[0];
                    
                    
                }else if([model.mallId intValue] == [array[1] intValue]){
                    
                    arr4View.seletIndex=[array[1] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[1];
                    
                    
                }else if([model.mallId intValue] == [array[2] intValue]){
                    
                    arr4View.seletIndex=[array[2] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[2];
                    
                    
                }else if([model.mallId intValue] == [array[3] intValue]){
                    
                    arr4View.seletIndex=[array[3] intValue];
                    [self resumeBtn:arr4 :arr4View];
                    
                    ytMianLiao=array[3];
                    
                    
                }
            }
        }
    }
    
    
    NSLog(@"==%@==%@===%@===%@==",ytColor,ytSize,ytStyle,ytMianLiao);
    
    //=======================================
    
    
    if ([userDefaultes stringForKey:@"jianshu"].length==0) {
        
        countView.tf_count.text=@"1";
        
        if ([userDefaultes stringForKey:@"rember"].length==0) {
            
            countView.tf_count.text = @"1";
            
        }else{
            
            countView.tf_count.text = [userDefaultes stringForKey:@"rember"];
            
        }
        
        
        
    }else{
        
       countView.tf_count.text=[userDefaultes stringForKey:@"jianshu"];
        
    }
    
    
    if (ytColor.length==0 && ytSize.length==0 && ytStyle.length==0 && ytMianLiao.length==0) {//1
        
        
    }else if(ytColor.length>0 && ytSize.length==0 && ytStyle.length==0 && ytMianLiao.length==0) {
        
        
        self.ShuXingString=[NSString stringWithFormat:@"%@",ytColor];
        
        NSLog(@"==2=self.ShuXingString==%@=",self.ShuXingString);
        
        
        if (colorArr.count>0 || Arr3.count>0 || Arr4.count>0) {
            
            
        }else{
            
            [self getDatas];
            
            

        }
                
    }else if (ytColor.length==0 && ytSize.length>0 && ytStyle.length==0 && ytMianLiao.length==0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@",ytSize];
        
        NSLog(@"==3=self.ShuXingString==%@=",self.ShuXingString);
        
        if (sizeArr.count>0 || Arr3.count>0 || Arr4.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
    }else if (ytColor.length==0 && ytSize.length==0 && ytStyle.length>0 && ytMianLiao.length==0){
        
        
        self.ShuXingString=[NSString stringWithFormat:@"%@",ytStyle];
        
        NSLog(@"==4=self.ShuXingString==%@=",self.ShuXingString);
        
        if (colorArr.count>0 || sizeArr.count>0 || Arr4.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
        
    }else if (ytColor.length==0 && ytSize.length==0 && ytStyle.length==0 && ytMianLiao.length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@",ytMianLiao];
        
        NSLog(@"==5=self.ShuXingString==%@=",self.ShuXingString);
        
        if (colorArr.count>0 || Arr3.count>0 || sizeArr.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
    }else if (ytColor.length>0 && ytSize.length>0 && ytStyle.length==0 && ytMianLiao.length==0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@",ytColor,ytSize];
        
        
//        NSLog(@"==6=lb_detail.text====%@",lb_detail.text);
        
        NSLog(@"==6=self.ShuXingString==%@=",self.ShuXingString);
        
        if (Arr3.count>0 || Arr4.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
    }else if (ytColor.length==0 && ytSize.length>0 && ytStyle.length>0 && ytMianLiao.length==0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@",ytSize,ytStyle];
        
        NSLog(@"==7=self.ShuXingString==%@=",self.ShuXingString);
        
        if (sizeArr.count>0 || Arr4.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
    }else if (ytColor.length==0 && ytSize.length==0 && ytStyle.length>0 && ytMianLiao.length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@",ytStyle,ytMianLiao];
        
        NSLog(@"==8=self.ShuXingString==%@=",self.ShuXingString);
        
        if (colorArr.count>0 || sizeArr.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
    }else if (ytColor.length>0 && ytSize.length==0 && ytStyle.length>0 && ytMianLiao.length==0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@",ytColor,ytStyle];
        
        NSLog(@"==9=self.ShuXingString==%@=",self.ShuXingString);
        
        if (colorArr.count>0 || Arr4.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
    }else if (ytColor.length>0 && ytSize.length==0 && ytStyle.length==0 && ytMianLiao.length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@",ytColor,ytMianLiao];
        
        NSLog(@"==10=self.ShuXingString==%@=",self.ShuXingString);
        
        if (colorArr.count>0 || Arr3.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
    }else if (ytColor.length==0 && ytSize.length>0 && ytStyle.length==0 && ytMianLiao.length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@",ytSize,ytMianLiao];
        
        NSLog(@"==11=self.ShuXingString==%@=",self.ShuXingString);
        
        if (sizeArr.count>0 || Arr3.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
    }else if (ytColor.length>0 && ytSize.length>0 && ytStyle.length>0 && ytMianLiao.length==0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@_%@",ytColor,ytSize,ytStyle];
        
        NSLog(@"==12=self.ShuXingString==%@=",self.ShuXingString);
        
        if (Arr4.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
    }else if (ytColor.length==0 && ytSize.length>0 && ytStyle.length>0 && ytMianLiao.length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@_%@",ytSize,ytStyle,ytMianLiao];
        
        NSLog(@"==13=self.ShuXingString==%@=",self.ShuXingString);
        
        if (sizeArr.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
    }else if (ytColor.length>0 && ytSize.length==0 && ytStyle.length>0 && [userDefaultes stringForKey:@"mianliao"].length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@_%@",ytColor,ytStyle,ytMianLiao];
        
        NSLog(@"==14=self.ShuXingString==%@=",self.ShuXingString);
        
        if (colorArr.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
    }else if (ytColor.length>0 && ytSize.length>0 && ytStyle.length==0 && ytMianLiao.length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@_%@",ytColor,ytSize,ytMianLiao];
        
        NSLog(@"==15=self.ShuXingString==%@=",self.ShuXingString);
        
        if (Arr3.count>0) {
            
            
        }else{
            
            [self getDatas];
            
        }
        
    }else if (ytColor.length>0 && ytSize.length>0 && ytStyle.length>0 && ytMianLiao.length>0){
        
        self.ShuXingString=[NSString stringWithFormat:@"%@_%@_%@_%@",ytColor,ytSize,ytStyle,ytMianLiao];
        
        NSLog(@"==16=self.ShuXingString==%@=",self.ShuXingString);
        
        [self getDatas];
        
    }
    
    
    if ([userDefaultes stringForKey:@"color"].length > 0) {
        
        if (array.count==0) {
            
            button5=(UIButton *)[sizeView viewWithTag:[[userDefaultes stringForKey:@"color"] integerValue]+100];
        }else{
            
            button5=(UIButton *)[sizeView viewWithTag:[ytColor integerValue]+100];
            
        }
    }else{
        
        if (array.count==0) {
            
            button5=(UIButton *)[sizeView viewWithTag:[[userDefaultes stringForKey:@"color1"] integerValue]+100];
            
        }else{
            
            button5=(UIButton *)[sizeView viewWithTag:[ytColor integerValue]+100];
            
        }
    }
    
    [button5 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//    button5.selected=YES;
    
    self.string1=button5.titleLabel.text;
    string1=button5.titleLabel.text;
    
    [button5 setTitleColor:[UIColor whiteColor] forState:0];
    [button5 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
    
    if ([userDefaultes stringForKey:@"size"].length > 0) {
        
        if (array.count==0) {
            
            button6=(UIButton *)[colorView viewWithTag:[[userDefaultes stringForKey:@"size"] integerValue]+100];
        }else{
            
            
            button6=(UIButton *)[colorView viewWithTag:[ytSize integerValue]+100];
            
        }
        
    }else{
        
        if (array.count==0) {
            
            button6=(UIButton *)[colorView viewWithTag:[[userDefaultes stringForKey:@"size1"] integerValue]+100];
        }else{
            
            
            button6=(UIButton *)[colorView viewWithTag:[ytSize integerValue]+100];
            
        }
    }
    [button6 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//    button6.selected=YES;
    
    self.string=button6.titleLabel.text;
    string=button6.titleLabel.text;
    
    [button6 setTitleColor:[UIColor whiteColor] forState:0];
    [button6 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
    if ([userDefaultes stringForKey:@"style"].length > 0) {
        
        if (array.count==0) {
            
            button7=(UIButton *)[arr3View viewWithTag:[[userDefaultes stringForKey:@"style"] integerValue]+100];
            
        }else{
            
            button7=(UIButton *)[arr3View viewWithTag:[ytStyle integerValue]+100];
            
        }
    }else{
        
        if (array.count==0) {
            
            button7=(UIButton *)[arr3View viewWithTag:[[userDefaultes stringForKey:@"style1"] integerValue]+100];
            
        }else{
            
            button7=(UIButton *)[arr3View viewWithTag:[ytStyle integerValue]+100];
        }
    }
    [button7 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//    button7.selected=YES;
    
    self.string5=button7.titleLabel.text;
    string5=button7.titleLabel.text;
    
    [button7 setTitleColor:[UIColor whiteColor] forState:0];
    [button7 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
    
    if ([userDefaultes stringForKey:@"mianliao"].length > 0) {
        
        if (array.count==0) {
            
            button8=(UIButton *)[arr4View viewWithTag:[[userDefaultes stringForKey:@"mianliao"] integerValue]+100];
            
        }else{
            
            button8=(UIButton *)[arr4View viewWithTag:[ytMianLiao integerValue]+100];
            
        }
    }else{
        
        if (array.count==0) {
            
            button8=(UIButton *)[arr4View viewWithTag:[[userDefaultes stringForKey:@"mianliao1"] integerValue]+100];
            
        }else{
            
            button8=(UIButton *)[arr4View viewWithTag:[ytMianLiao integerValue]+100];
            
        }
    }
    
    [button8 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//    button8.selected=YES;
    
    self.string6=button8.titleLabel.text;
    string6=button8.titleLabel.text;
    
    [button8 setTitleColor:[UIColor whiteColor] forState:0];
    [button8 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
    
    //单属性商品，默认选中
    if (string.length==0 && string1.length==0 && string5.length==0 && string6.length==0) {
        
//        lb_detail.text = @"请选择 颜色 尺码 风格 面料";
        lb_detail.text = @"请选择 商品规格";
 //       lb_detail.text=[NSString stringWithFormat:@"请选择 %@ %@ %@ %@",arr5[0],arr5[1],arr5[2],arr5[3]];
        
    }else if (string1.length==0 && string5.length==0 && string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'",string];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else if (string.length==0 && string5.length==0 && string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'",string1];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else if (string.length==0 && string1.length==0 && string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'",string5];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else if (string.length==0 && string1.length==0 && string5.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'",string6];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else if (string5.length==0 && string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'",string1,string];
        
        [UserMessageManager MoRen:lb_detail.text];
        
        NSLog(@"565656565656=%@",lb_detail.text);
        
    }else if (string.length==0 && string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'",string1,string5];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else if (string.length==0 && string1.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'",string5,string6];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else if (string1.length==0 && string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'",string,string5];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else if (string1.length==0 && string5.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'",string,string6];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else if (string.length==0 && string5.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'",string1,string6];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else if (string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'+\'%@\'",string1,string,string5];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else if (string.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'+\'%@\'",string1,string5,string6];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else if (string1.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'+\'%@\'",string,string5,string6];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else if (string5.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'+\'%@\'",string1,string,string6];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }else{
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'+\'%@\'+\'%@\'",string1,string,string5,string6];
        
        [UserMessageManager MoRen:lb_detail.text];
        
    }
    
    
    
    
}

////加入购物车
//-(void)addCart
//{
//    
//    NSLog(@"加入购物车");
//    
//}
//
////立即购买
//-(void)NowbuyBtnClick
//{
//    
//    NSLog(@"立即购买");
//}

/**
 *  此处嵌入浏览图片代码
 */
-(void)showBigImage:(UITapGestureRecognizer *)tap
{
    NSLog(@"放大图片");
}
#pragma mark-typedelegete
-(void)btnindex:(int)tag
{
//    NSString *size =[sizearr objectAtIndex:1];
//    NSString *color =[colorarr objectAtIndex:1];
           // lb_stock.text = [NSString stringWithFormat:@"库存%@件",[[stockdic objectForKey: size] objectForKey:color]];
//   lb_detail.text = [NSString stringWithFormat:@"已选 \"%@\" \"%@\"",size,color];
    
//    [UserMessageManager removeAllGoodsAttribute];
    
    
    countView.tf_count.text=@"1";
    
//    string=@"";
//    string1=@"";
//    string5=@"";
//    string6=@"";
//    
//    self.string=@"";
//    self.string1=@"";
//    self.string5=@"";
//    self.string6=@"";
//    
//    
//    button5.selected=NO;
//    button6.selected=NO;
//    button7.selected=NO;
//    button8.selected=NO;
    
    
    UIButton *button1=(UIButton *)[sizeView viewWithTag:sizeView.seletIndex+100];
    UIButton *button2=(UIButton *)[colorView viewWithTag:colorView.seletIndex+100];
    UIButton *button3=(UIButton *)[arr3View viewWithTag:arr3View.seletIndex+100];
    UIButton *button4=(UIButton *)[arr4View viewWithTag:arr4View.seletIndex+100];
    
    
//    NSLog(@"kkkkkkkkkkk==%@",button.titleLabel.text);
    
    
//    [UserMessageManager removeAllGoodsAttribute];
    
    
//    [self resumeBtn:colorarr :colorView];
//    [self resumeBtn:sizearr :sizeView];
//    [ self resumeBtn:arr3 :arr3View];
//    [self resumeBtn:arr4 :arr4View];
    NSLog(@"==选择Id===%d",tag);
    NSLog(@"=====button1.tag=====%ld",(long)button1.tag);
    
    //============================
    
    if (tag==button1.tag-100) {
        
        
        NSLog(@"1111111111111");
        
        string1=@"";
        
        self.string1=@"";
        
        
//        button5.selected=NO;
        //        button6.selected=YES;
        //        button7.selected=YES;
        //        button8.selected=YES;
        //
        //        [button6 setBackgroundColor:[UIColor redColor]];
        //        [button7 setBackgroundColor:[UIColor redColor]];
        //        [button8 setBackgroundColor:[UIColor redColor]];
        
        [UserMessageManager removeColor];
        
        
        //        colorView.seletIndex=tag;
        
        
        [self resumeBtn:arr3 :arr3View];
        [self resumeBtn:sizearr :sizeView];
        [self resumeBtn:arr4 :arr4View];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        
        button6=(UIButton *)[colorView viewWithTag:[[userDefaultes stringForKey:@"size"] integerValue]+100];
        [button6 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//        button6.selected=YES;
        self.string=button6.titleLabel.text;
        string=button6.titleLabel.text;
        [button6 setTitleColor:[UIColor whiteColor] forState:0];
        [button6 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
        
        button7=(UIButton *)[arr3View viewWithTag:[[userDefaultes stringForKey:@"style"] integerValue]+100];
        [button7 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//        button7.selected=YES;
        self.string5=button7.titleLabel.text;
        string5=button7.titleLabel.text;
        [button7 setTitleColor:[UIColor whiteColor] forState:0];
        [button7 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
        button8=(UIButton *)[arr4View viewWithTag:[[userDefaultes stringForKey:@"mianliao"] integerValue]+100];
        [button8 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//        button8.selected=YES;
        self.string6=button8.titleLabel.text;
        string6=button8.titleLabel.text;
        [button8 setTitleColor:[UIColor whiteColor] forState:0];
        [button8 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
        
        
        
        //        button8.enabled=NO;
        //        button6.enabled=NO;
        //        button7.enabled=NO;
    }
    
    
    if (tag==button2.tag-100) {
        
        
        NSLog(@"22222222222222");
        string=@"";
        
        
        self.string=@"";
        
        
        //        button5.selected=YES;
        button6.selected=NO;
        //        button7.selected=YES;
        //        button8.selected=YES;
        //
        //        [button5 setBackgroundColor:[UIColor redColor]];
        //        [button7 setBackgroundColor:[UIColor redColor]];
        //        [button8 setBackgroundColor:[UIColor redColor]];
        
        
        [UserMessageManager removeSize];
        
        //        sizeView.seletIndex=tag;
        
        [self resumeBtn:colorarr :colorView];
        [self resumeBtn:arr3 :arr3View];
        [self resumeBtn:arr4 :arr4View];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        button5=(UIButton *)[sizeView viewWithTag:[[userDefaultes stringForKey:@"color"] integerValue]+100];
        [button5 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//        button5.selected=YES;
        self.string1=button5.titleLabel.text;
        string1=button5.titleLabel.text;
        [button5 setTitleColor:[UIColor whiteColor] forState:0];
        [button5 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
        
        button7=(UIButton *)[arr3View viewWithTag:[[userDefaultes stringForKey:@"style"] integerValue]+100];
        [button7 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//        button7.selected=YES;
        self.string5=button7.titleLabel.text;
        string5=button7.titleLabel.text;
        [button7 setTitleColor:[UIColor whiteColor] forState:0];
        [button7 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
        
        button8=(UIButton *)[arr4View viewWithTag:[[userDefaultes stringForKey:@"mianliao"] integerValue]+100];
        [button8 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//        button8.selected=YES;
        self.string6=button8.titleLabel.text;
        string6=button8.titleLabel.text;
        [button8 setTitleColor:[UIColor whiteColor] forState:0];
        [button8 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
        
        
        //        button5.enabled=NO;
        //        button8.enabled=NO;
        //        button7.enabled=NO;
        
    }
    
    if (tag==button3.tag-100) {
        
        
        NSLog(@"33333333333");
        string5=@"";
        
        
        self.string5=@"";
        
        
        //        button5.selected=YES;
        //        button6.selected=YES;
//        button7.selected=NO;
        //        button8.selected=YES;
        
        //        [button5 setBackgroundColor:[UIColor redColor]];
        //        [button6 setBackgroundColor:[UIColor redColor]];
        //        [button8 setBackgroundColor:[UIColor redColor]];
        
        
        [UserMessageManager removeStyle];
        
        //        arr4View.seletIndex=tag;
        
        [self resumeBtn:colorarr :colorView];
        [self resumeBtn:arr3 :arr3View];
        [self resumeBtn:sizearr :sizeView];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        
        button5=(UIButton *)[sizeView viewWithTag:[[userDefaultes stringForKey:@"color"] integerValue]+100];
        [button5 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//        button5.selected=YES;
        self.string1=button5.titleLabel.text;
        string1=button5.titleLabel.text;
        [button5 setTitleColor:[UIColor whiteColor] forState:0];
        [button5 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
        
        button6=(UIButton *)[colorView viewWithTag:[[userDefaultes stringForKey:@"size"] integerValue]+100];
        [button6 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//        button6.selected=YES;
        self.string=button6.titleLabel.text;
        string=button6.titleLabel.text;
        [button6 setTitleColor:[UIColor whiteColor] forState:0];
        [button6 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
        button8=(UIButton *)[arr4View viewWithTag:[[userDefaultes stringForKey:@"mianliao"] integerValue]+100];
        [button8 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//        button8.selected=YES;
        self.string6=button8.titleLabel.text;
        string6=button8.titleLabel.text;
        [button8 setTitleColor:[UIColor whiteColor] forState:0];
        [button8 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
        
        //        [self resumeBtn:arr4 :arr4View];
        
        
        
        //        button5.enabled=NO;
        //        button6.enabled=NO;
        //        button8.enabled=NO;
        
        
        
    }
    
    if (tag==button4.tag-100) {
        
        
        NSLog(@"444444444444");
        
        string6=@"";
        
        self.string6=@"";
        
        
        //        button5.selected=YES;
        //        button6.selected=YES;
        //        button7.selected=YES;
//        button8.selected=NO;
        
        //        [button5 setBackgroundColor:[UIColor redColor]];
        //        [button6 setBackgroundColor:[UIColor redColor]];
        //        [button7 setBackgroundColor:[UIColor redColor]];
        
        
        [UserMessageManager removeMianLiao];
        
        //        arr3View.seletIndex=tag;
        
        
        [self resumeBtn:colorarr :colorView];
        [self resumeBtn:sizearr :sizeView];
        [self resumeBtn:arr4 :arr4View];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        
        button5=(UIButton *)[sizeView viewWithTag:[[userDefaultes stringForKey:@"color"] integerValue]+100];
        [button5 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//        button5.selected=YES;
        self.string1=button5.titleLabel.text;
        string1=button5.titleLabel.text;
        [button5 setTitleColor:[UIColor whiteColor] forState:0];
        [button5 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
        button6=(UIButton *)[colorView viewWithTag:[[userDefaultes stringForKey:@"size"] integerValue]+100];
        [button6 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//        button6.selected=YES;
        self.string=button6.titleLabel.text;
        string=button6.titleLabel.text;
        [button6 setTitleColor:[UIColor whiteColor] forState:0];
        [button6 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
        
        button7=(UIButton *)[arr3View viewWithTag:[[userDefaultes stringForKey:@"style"] integerValue]+100];
        [button7 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
//        button7.selected=YES;
        self.string5=button7.titleLabel.text;
        string5=button7.titleLabel.text;
        [button7 setTitleColor:[UIColor whiteColor] forState:0];
        [button7 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
        
        
        
        //        button5.enabled=NO;
        //        button6.enabled=NO;
        //        button7.enabled=NO;
        
    }
    //============================

//    
//    NSString *string;
//    NSString *string1;
//    NSString *string5;
//    NSString *string6;
    
    
    if (colorView.seletIndex>0) {
        
        //        [newArrM removeAllObjects];
        //
        //        [newArrM addObject:button2.titleLabel.text];
        
        string=button2.titleLabel.text;
        
        
        self.string=string;
        
        
    }
    
    if (sizeView.seletIndex>0) {
        
        //        [newArrM1 removeAllObjects];
        //
        //        [newArrM1 addObject:button1.titleLabel.text];
        
        string1=button1.titleLabel.text;
        
        
        
        self.string1=string1;
        
        
        
    }
    
    
    if (arr3View.seletIndex>0) {
        
        //        [newArrM2 removeAllObjects];
        //
        //        [newArrM2 addObject:button3.titleLabel.text];
        
        string5=button3.titleLabel.text;
        
        
        
        self.string5=string5;
        
        
        
    }
    
    if (arr4View.seletIndex>0) {
        
        //        [newArrM3 removeAllObjects];
        //
        //        [newArrM3 addObject:button4.titleLabel.text];
        
        string6=button4.titleLabel.text;
        
        
        
        self.string6=string6;
        
        
    }
    
//    [self resumeBtn:colorarr :colorView];
//    
//    [self resumeBtn:arr3 :arr3View];
//    
//    [self resumeBtn:sizearr :sizeView];
//    [self resumeBtn:arr4 :arr4View];
    //
    
    
    
    //    if (newArrM.count==0 && newArrM1.count==0 && newArrM2.count==0 && newArrM3.count==0) {
    //
    //        lb_detail.text = @"请选择 颜色 尺码 风格 面料";
    //
    //    }else{
    
    //        NSString *string;
    //        NSString *string1;
    //        NSString *string5;
    //        NSString *string6;
    //
    //        for (NSString *string3 in newArrM) {
    //
    //            string=string3;
    //            self.string=string3;
    //        }
    //        for (NSString *string4 in newArrM1) {
    //
    //            string1=string4;
    //            self.string1=string4;
    //        }
    //        for (NSString *string7 in newArrM2) {
    //
    //            string5=string7;
    //
    //            self.string5=string7;
    //        }
    //        for (NSString *string8 in newArrM3) {
    //
    //            string6=string8;
    //
    //            self.string6=string8;
    //        }
    
    if (string.length==0 && string1.length==0 && string5.length==0 && string6.length==0) {
        
        lb_detail.text = @"请选择 颜色 尺码 风格 面料";
        
    }else if (string1.length==0 && string5.length==0 && string6.length==0){
        
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'",string];
        
        NSLog(@"==1=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString:string];
        
    }else if (string.length==0 && string5.length==0 && string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'",string1];
        
        NSLog(@"==2=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString1:string1];
        
    }else if (string.length==0 && string1.length==0 && string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'",string5];
        
        NSLog(@"==3=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString5:string5];
        
    }else if (string.length==0 && string1.length==0 && string5.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'",string6];
        
        NSLog(@"==4=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString6:string6];
        
    }else if (string5.length==0 && string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'",string1,string];
        
        NSLog(@"==5=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString1:string1];
        
        [UserMessageManager YTString:string];
        
    }else if (string.length==0 && string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'",string1,string5];
        
        NSLog(@"==6=string5.length====%@",lb_detail.text);
        
        [UserMessageManager YTString1:string1];
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString5:string5];
        
    }else if (string.length==0 && string1.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'",string5,string6];
        
        NSLog(@"==7=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString6:string6];
        [UserMessageManager YTString5:string5];
        
    }else if (string1.length==0 && string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'",string,string5];
        
        NSLog(@"==8=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString5:string5];
        [UserMessageManager YTString:string];
        
    }else if (string1.length==0 && string5.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'",string,string6];
        
        NSLog(@"==9=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString6:string6];
        [UserMessageManager YTString:string];
        
    }else if (string.length==0 && string5.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'",string1,string6];
        
        NSLog(@"==10=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString6:string6];
        [UserMessageManager YTString1:string1];
        
    }else if (string6.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'+\'%@\'",string1,string,string5];
        
        NSLog(@"==11=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString5:string5];
        [UserMessageManager YTString1:string1];
        [UserMessageManager YTString:string];
        
    }else if (string.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'+\'%@\'",string1,string5,string6];
        
        NSLog(@"==12=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString6:string6];
        [UserMessageManager YTString5:string5];
        [UserMessageManager YTString1:string1];
        
    }else if (string1.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'+\'%@\'",string,string5,string6];
        
        NSLog(@"==13=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString:string];
        [UserMessageManager YTString6:string6];
        [UserMessageManager YTString5:string5];
        
    }else if (string5.length==0){
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'+\'%@\'",string1,string,string6];
        
        NSLog(@"==14=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString1:string1];
        [UserMessageManager YTString:string];
        [UserMessageManager YTString6:string6];
        
        
    }else{
        
        lb_detail.text = [NSString stringWithFormat:@"已选 \'%@\'+\'%@\'+\'%@\'+\'%@\'",string1,string,string5,string6];
        
        NSLog(@"==15=string5.length====%@",lb_detail.text);
        
        [UserMessageManager AttibuteBackShow:lb_detail.text];
        [UserMessageManager YTString1:string1];
        [UserMessageManager YTString:string];
        [UserMessageManager YTString5:string5];
        [UserMessageManager YTString6:string6];
    }

    
    
    /////////////////////////////////获取数据/////////////////////////////////////////////////////////
    
    if (sizearr.count==0 && colorarr.count==0 && arr3.count==0 && arr4.count==0) {//1
        
        
        
    }else if (sizearr.count==0 && colorarr.count>0 && arr3.count>0 && arr4.count>0) {//颜色2
        
        if (colorView.seletIndex >0&&arr3View.seletIndex>0&&arr4View.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d_%d_%d",colorView.seletIndex,arr3View.seletIndex,arr4View.seletIndex];
            
            NSLog(@"=2==self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            
            //选完组合，获取数据就缓存
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            
            [UserMessageManager GoodsSize2:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle2:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao2:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            
        }
    }else if (colorarr.count==0 && sizearr.count>0 && arr3.count>0 && arr4.count>0){//尺寸3
        
        if (sizeView.seletIndex >0&&arr3View.seletIndex>0&&arr4View.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d_%d_%d",sizeView.seletIndex,arr3View.seletIndex,arr4View.seletIndex];
            
            NSLog(@"==3=self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor2:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle2:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao2:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            
            
        }
    }else if (arr3.count==0 && sizearr.count>0 && arr4.count>0 && colorarr.count>0){//风格4
        
        if (sizeView.seletIndex >0&&colorView.seletIndex>0&&arr4View.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d_%d_%d",sizeView.seletIndex,colorView.seletIndex,arr4View.seletIndex];
            
            NSLog(@"==4=self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor2:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize2:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao2:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            
            
        }
    }else if (arr4.count==0 && colorarr.count>0 && arr3.count>0 && sizearr.count>0){//面料5
        
        if (sizeView.seletIndex >0&&colorView.seletIndex>0&&arr3View.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d_%d_%d",sizeView.seletIndex,colorView.seletIndex,arr3View.seletIndex];
            
            NSLog(@"==5=self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor2:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize2:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle2:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            
            
        }
    }else if(sizearr.count==0 && colorarr.count==0 && arr3.count==0 && arr4.count>0){//6
        
        if (arr4View.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d",arr4View.seletIndex];
            
            NSLog(@"==6=self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao2:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            
        }
    }else if(sizearr.count==0 && colorarr.count==0 && arr4.count==0 && arr3.count>0){//7
        
        if (arr3View.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d",arr3View.seletIndex];
            
            NSLog(@"==7=self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle2:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            
        }
    }else if(sizearr.count==0 && arr3.count==0 && arr4.count==0 && colorarr.count>0){//8
        
        if (colorView.seletIndex>=0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d",colorView.seletIndex];
            
            NSLog(@"==8=self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize2:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            
        }
    }else if(colorarr.count==0 && arr3.count==0 && arr4.count==0 && sizearr.count>0){//9
        
        if (sizeView.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d",sizeView.seletIndex];
            
            NSLog(@"==9=self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor2:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            
        }
    }else if(arr3.count==0 && arr4.count==0 && sizearr.count>0 && colorarr.count>0){//10
        
        if (sizeView.seletIndex>0 && colorView.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d_%d",sizeView.seletIndex,colorView.seletIndex];
            
            NSLog(@"==10=self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor2:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize2:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            
            
        }
    }else if(colorarr.count==0 && arr4.count==0 && sizearr.count>0 && arr3.count>0){//11
        
        if (sizeView.seletIndex>0 && arr3View.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d_%d",sizeView.seletIndex,arr3View.seletIndex];
            
            NSLog(@"=11==self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor2:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle2:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            
        }
    }else if(colorarr.count==0 && arr3.count==0 && sizearr.count>0 && arr4.count>0){//12
        
        if (sizeView.seletIndex>0 && arr4View.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d_%d",sizeView.seletIndex,arr4View.seletIndex];
            
            NSLog(@"==12=self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor2:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao2:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            
        }
    }else if(sizearr.count==0 && arr4.count==0 && colorarr.count>0 && arr3.count>0){//13
        
        if (colorView.seletIndex>0 && arr3View.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d_%d",colorView.seletIndex,arr3View.seletIndex];
            
            NSLog(@"==13=self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize2:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle2:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            
        }
    }else if(sizearr.count==0 && arr3.count==0 && colorarr.count>0 && arr4.count>0){//14
        
        if (colorView.seletIndex>0 && arr4View.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d_%d",colorView.seletIndex,arr4View.seletIndex];
            
            NSLog(@"=14==self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize2:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao2:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            
        }
    }else if(sizearr.count==0 && colorarr.count==0 && arr4.count>0 && arr3.count>0){//15
        
        if (arr3View.seletIndex>0 && arr4View.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d_%d",arr3View.seletIndex,arr4View.seletIndex];
            
            NSLog(@"==15=self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle2:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao2:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            
        }
    }else{//16
        
        if (sizeView.seletIndex >0&&colorView.seletIndex >0&&arr3View.seletIndex>0&&arr4View.seletIndex>0) {
            
            self.ShuXingString=[NSString stringWithFormat:@"%d_%d_%d_%d",sizeView.seletIndex,colorView.seletIndex,arr3View.seletIndex,arr4View.seletIndex];
            
            
            NSLog(@"==16=self.ShuXingString==%@=",self.ShuXingString);
            
            [self getDatas];
            
            //缓存颜色
            [UserMessageManager GoodsColor:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor1:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            [UserMessageManager GoodsColor2:[NSString stringWithFormat:@"%d",sizeView.seletIndex]];
            //缓存尺码
            [UserMessageManager GoodsSize:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize1:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            [UserMessageManager GoodsSize2:[NSString stringWithFormat:@"%d",colorView.seletIndex]];
            //缓存风格
            [UserMessageManager GoodsStyle:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle1:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            [UserMessageManager GoodsStyle2:[NSString stringWithFormat:@"%d",arr3View.seletIndex]];
            //缓存面料
            [UserMessageManager GoodsMianLiao:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao1:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];
            [UserMessageManager GoodsMianLiao2:[NSString stringWithFormat:@"%d",arr4View.seletIndex]];

            
            
            
        }
        
    }
    
    
    
    //////////////////////////////////////////////////////////////////////////////////////////
    
    
    
//    //通过seletIndex是否>=0来判断尺码和颜色是否被选择，－1则是未选择状态
//    if (sizeView.seletIndex >=0&&colorView.seletIndex >=0) {
//       [ self resumeBtn:colorarr :colorView];
//       [self resumeBtn:sizearr :sizeView];
//        [ self resumeBtn:arr3 :arr3View];
//        [self resumeBtn:arr4 :arr4View];
//        //尺码和颜色都选择的时候
//        NSString *size =[sizearr objectAtIndex:sizeView.seletIndex];
//        NSString *color =[colorarr objectAtIndex:colorView.seletIndex];
//        lb_stock.text = [NSString stringWithFormat:@"库存%@件",[[stockdic objectForKey: size] objectForKey:color]];
//        lb_detail.text = [NSString stringWithFormat:@"已选 \"%@\" \"%@\"",size,color];
//        stock =[[[stockdic objectForKey: size] objectForKey:color] intValue];
//        
////        [self reloadTypeBtn:[stockdic objectForKey:size] :colorarr :colorView];
////        [self reloadTypeBtn:[stockdic objectForKey:color] :sizearr :sizeView];
////        NSLog(@"%d",colorView.seletIndex);
////        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",colorView.seletIndex+1]];
//    }else if (sizeView.seletIndex ==-1&&colorView.seletIndex == -1)
//    {
//        //尺码和颜色都没选的时候
//        lb_price.text = @"¥100";
//        lb_stock.text = @"库存100000件";
//        lb_detail.text = @"请选择 尺码 颜色分类";
//        stock = 100000;
//        //全部恢复可点击状态
//        [self resumeBtn:colorarr :colorView];
//        [self resumeBtn:sizearr :sizeView];
//        
//    }else if (sizeView.seletIndex ==-1&&colorView.seletIndex >= 0)
//    {
//        //只选了颜色
////        NSString *color =[colorarr objectAtIndex:colorView.seletIndex];
//        //根据所选颜色 取出该颜色对应所有尺码的库存字典
////        NSDictionary *dic = [stockdic objectForKey:color];
////        [self reloadTypeBtn:dic :sizearr :sizeView];
//        [self resumeBtn:colorarr :colorView];
//        lb_stock.text = @"库存100000件";
//        lb_detail.text = @"请选择 尺码";
//        stock = 100000;
//        
////        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",colorView.seletIndex+1]];
//    }else if (sizeView.seletIndex >= 0&&colorView.seletIndex == -1)
//    {
//        //只选了尺码
////        NSString *size =[sizearr objectAtIndex:sizeView.seletIndex];
//        //根据所选尺码 取出该尺码对应所有颜色的库存字典
////        NSDictionary *dic = [stockdic objectForKey:size];
//        [self resumeBtn:sizearr :sizeView];
////        [self reloadTypeBtn:dic :colorarr :colorView];
//        lb_stock.text = @"库存100000件";
//        lb_detail.text = @"请选择 颜色分类";
//        stock = 100000;
//        
//    }
}

//获取属性数据

-(void)getDatas
{
    
    countView.bt_add.enabled = YES;
    [countView.bt_add setTitleColor:[UIColor blackColor] forState:0];
    
    NSLog(@")))))))))))))===gid1=(((((((((===%@",gid1);
    
    
    WKProgressHUD *hud = [WKProgressHUD showInView:self withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
//        [hud dismiss:YES];
        
    });
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getGoodAttributeDetailListBySmallIds_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
//    [UserMessageManager removeAllImageSecect];
    
    self.userId=[userDefaultes stringForKey:@"userid"];
    
    if ([userDefaultes stringForKey:@"userid"].length==0) {
        
        self.userId=@"";
        
    }
    
    NSDictionary *dic = @{@"smallIds":self.ShuXingString,@"userId":self.userId,@"gid":gid1,@"good_type":self.Goods_type};
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
//            NSLog(@"xmlStr%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            view.hidden=YES;
            
            NSLog(@"===属性====%@",dic2);
            
            self.bPandun = @"2";
            
            
                NSString *OrderString=dic2[@"status"];
                
                if ([OrderString isEqualToString:@"10000"]) {
                    
                    for (NSDictionary *dict in dic2[@"list"]) {
                        
                        NSLog(@"==detailId=%@",dict[@"detailId"]);
                        NSLog(@"=exchange==%@",dict[@"exchange"]);
                        NSLog(@"==freight=%@",dict[@"freight"]);
                        NSLog(@"==pay_integral=%@",dict[@"pay_integral"]);
                        NSLog(@"==pay_money=%@",dict[@"pay_money"]);
                        NSLog(@"==stock=%@",dict[@"stock"]);
                        
                        self.StockString = dict[@"stock"];
                        
                        _detailId = [NSString stringWithFormat:@"%@",dict[@"detailId"]];
                        
                        //                _detailId =  dict[@"detailId"];
                        
                        
                        
                        
                        //               _detailId = @"888888";
                        _exchange = dict[@"exchange"];
                        _amount = dict[@"amount"];
                        NSLog(@"detailId=%@",_detailId);
                        
                        
                        _yunfei=dict[@"freight"];
                        self.pay_integral=dict[@"pay_integral"];
                        self.pay_money=dict[@"pay_money"];
                        self.count=dict[@"count"];
                        self.user_amount=[NSString stringWithFormat:@"%@",dict[@"user_amount"]];
                        
                        if ([dict[@"pay_integral"] isEqualToString:@""] || [dict[@"pay_integral"] isEqualToString:@"0.00"]) {
                            
                            lb_price.text=[NSString stringWithFormat:@"￥%@",dict[@"pay_money"]];
                            
                        }else if ([dict[@"pay_money"] isEqualToString:@""] || [dict[@"pay_money"] isEqualToString:@"0.00"]){
                            
                            lb_price.text=[NSString stringWithFormat:@"%@积分",dict[@"pay_integral"]];
                            
                        }else{
                            
                            lb_price.text=[NSString stringWithFormat:@"￥%@+%@积分",dict[@"pay_money"],dict[@"pay_integral"]];
                        }
                        
                        //缓存已选组合库存
                        [UserMessageManager HuanCunShuXingStock:dict[@"stock"]];
                        
                        lb_stock.text=[NSString stringWithFormat:@"库存%@件",dict[@"stock"]];
                        self.stock=[dict[@"stock"] intValue];
                    }
                }else if ([OrderString isEqualToString:@"10004"]){
                    
                    self.YTOrderno=dic2[@"orderno"];
                    self.YTLogo=dic2[@"logo"];
                    self.YTStorename=dic2[@"storename"];
                    
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:dic2[@"message"] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    
                }else if ([OrderString isEqualToString:@"10010"]){
                    
                    
//                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:dic2[@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    
//                    [alert show];
                }

            
            //当限购数为1时，输入框不可点击
//            if (self.stock==1) {
//                
//                countView.tf_count.enabled=NO;
//                
//            }
            
            
            countView.YTCount=[NSString stringWithFormat:@"%@",self.count];
            
            
            [hud dismiss:YES];
            
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self NoWebSeveice];
        
        NSLog(@"%@",error);
    }];
    
}

-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-200)];
    
    view.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self addSubview:view];
    
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-82)/2, 100, 82, 68)];
    
    image.image=[UIImage imageNamed:@"网络连接失败"];
    
    [view addSubview:image];
    
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(100, 180, view.frame.size.width-200, 20)];
    
    label1.text=@"网络连接失败";
    
    label1.textAlignment=NSTextAlignmentCenter;
    
    label1.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    
    label1.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label1];
    
    
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(100, 210, view.frame.size.width-200, 20)];
    
    label2.text=@"请检查你的网络";
    
    label2.textAlignment=NSTextAlignmentCenter;
    
    label2.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    label2.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    [view addSubview:label2];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(100, 250, view.frame.size.width-200, 50);
    
    [button setTitle:@"重新加载" forState:0];
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
    
    [view addSubview:button];
    
    [button addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loadData{
    
    [self getDatas];
    
}
//恢复按钮的原始状态
-(void)resumeBtn:(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i< arr.count; i++) {
        
        GoodsAttributeModel *model=arr[i];
        
        UIButton *btn =(UIButton *) [view viewWithTag:[model.mallId integerValue]+100];
        
        btn.enabled = YES;
//        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (view.seletIndex == [model.mallId integerValue]) {
//           btn.selected = YES;
            [btn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
            [btn setTitleColor:[UIColor whiteColor] forState:0];
        }
    }

    
}
//根据所选的尺码或者颜色对应库存量 确定哪些按钮不可选
-(void)reloadTypeBtn:(NSDictionary *)dic :(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i<arr.count; i++) {
        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        //库存为零 不可点击
        if (count == 0) {
            btn.enabled = NO;
            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        }else
        {
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:0];
        }
        //根据seletIndex 确定用户当前点了那个按钮
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0]];
            
        }
    }
}
#pragma mark-数量加减
-(void)add
{
    int acount =[countView.tf_count.text intValue];
    
    if ([self.count intValue]==0) {
        
        //=====TUDO=====
        if (acount < self.stock) {
            countView.bt_add.enabled = YES;
            countView.tf_count.text = [NSString stringWithFormat:@"%d",acount+1];
            
            float pay_money=[self.pay_money floatValue]*(acount+1);
            float pay_integral=[self.pay_integral floatValue]*(acount+1);
            
            lb_price.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",pay_money,pay_integral];
            
        }else{
            
            if ([self.bPandun integerValue] == 2) {
//                countView.bt_add.backgroundColor = [UIColor redColor];
//                [countView.bt_add setBackgroundImage:[UIImage imageNamed:@"add"] forState:0];
                [countView.bt_add setTitleColor:[UIColor lightGrayColor] forState:0];
                countView.bt_add.enabled = NO;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"该组商品库存为%d",self.stock] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"请先选完商品规格"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
            

        }
    
    
    }else{
        
        //判断库存数Y与限购次数的大小
        
        if ([self.count intValue] < self.stock) {
            
            if (acount < [self.count intValue]) {
                
                countView.tf_count.text = [NSString stringWithFormat:@"%d",acount+1];
                
                float pay_money=[self.pay_money floatValue]*(acount+1);
                float pay_integral=[self.pay_integral floatValue]*(acount+1);
                
                lb_price.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",pay_money,pay_integral];
                
            }else{
                
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"该商品限购%d件！",[self.count intValue]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                
//                [alert show];
                
                
                
                [JRToast showWithText:[NSString stringWithFormat:@"该商品限购%d件",[self.count intValue]] duration:3.0f];
                
                
//                XSInfoViewStyle *style = [[XSInfoViewStyle alloc] init];
//                style.info = [NSString stringWithFormat:@"该商品限购%d件",[self.count intValue]];
//                
//                style.layoutStyle = XSInfoViewLayoutStyleHorizontal;
//                
//                [XSInfoView showInfoWithStyle:style onView:self];
                
                
            }
            
        }else if ([self.count intValue] > self.stock){
            
            
            if (acount < self.stock) {
                
                countView.tf_count.text = [NSString stringWithFormat:@"%d",acount+1];
                
                float pay_money=[self.pay_money floatValue]*(acount+1);
                float pay_integral=[self.pay_integral floatValue]*(acount+1);
                
                lb_price.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",pay_money,pay_integral];
                
            }else{
                
                if ([self.bPandun integerValue] == 2) {
//                    countView.bt_add.backgroundColor = [UIColor redColor];
//                    [countView.bt_add setBackgroundImage:[UIImage imageNamed:@"add"] forState:0];
                     [countView.bt_add setTitleColor:[UIColor lightGrayColor] forState:0];
                    countView.bt_add.enabled = NO;
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"该组商品库存不足"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    
                }else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"请先选完商品规格"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
            }
            
        }else{
            
            if (acount < self.stock) {
                
                countView.tf_count.text = [NSString stringWithFormat:@"%d",acount+1];
                
                float pay_money=[self.pay_money floatValue]*(acount+1);
                float pay_integral=[self.pay_integral floatValue]*(acount+1);
                
                lb_price.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",pay_money,pay_integral];
                
            }else{
                
                if ([self.bPandun integerValue] == 2) {
//                    countView.bt_add.backgroundColor = [UIColor redColor];
//                    [countView.bt_add setBackgroundImage:[UIImage imageNamed:@"add"] forState:0];
                     [countView.bt_add setTitleColor:[UIColor grayColor] forState:0];
                    countView.bt_add.enabled = NO;
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"该组商品库存不足"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    
                }else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"请先选完商品规格"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
            }
        }
    }
}
-(void)reduce
{
    countView.bt_add.enabled = YES;
     [countView.bt_add setTitleColor:[UIColor blackColor] forState:0];
    int count =[countView.tf_count.text intValue];
    if (count > 1) {
        countView.tf_count.text = [NSString stringWithFormat:@"%d",count-1];
        
        float pay_money=[self.pay_money floatValue]*(count-1);
        float pay_integral=[self.pay_integral floatValue]*(count-1);
        
        lb_price.text=[NSString stringWithFormat:@"￥%.02f+%.02f积分",pay_money,pay_integral];
        
    }else
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        alert.tag = 100;
        //        [alert show];
    }
}
#pragma mark-tf
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    mainscrollview.contentOffset = CGPointMake(0, countView.frame.origin.y);
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
   
    
    int count =[countView.tf_count.text intValue];
    NSLog(@"%d",count);
    if (count==0) {
        countView.tf_count.text=@"0";
    }
    
    if (count > self.stock) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出库存" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag = 100;
        [alert show];
        countView.tf_count.text = [NSString stringWithFormat:@"%d",self.stock];
        [self tap];
        
    }

    if (count<0) {
        [TrainToast showWithText:@"输入数量有误" duration:2.0];
        countView.tf_count.text=@"1";
    }

    
    if ([self.count intValue]==0) {
        
        
    }else{
        
        if (count > [self.count intValue]){
            
            [JRToast showWithText:[NSString stringWithFormat:@"该商品限购%d件",[self.count intValue]] duration:3.0f];
            
            countView.tf_count.text = [NSString stringWithFormat:@"%d",[self.count intValue]];
            
        }
        
    }
    
//    else if (self.stock==1){
//        
//        
//    }
}
-(void)tap
{
    mainscrollview.contentOffset = CGPointMake(0, 0);
    [countView.tf_count resignFirstResponder];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        
        
//        JiaoYiDaiFuKuanViewController *vc=[[JiaoYiDaiFuKuanViewController alloc] init];
//        vc.sigen=[userDefaultes stringForKey:@"sigen"];
//
//        vc.logo=self.YTLogo;
//        vc.storename=self.YTStorename;
//        vc.orderno=self.YTOrderno;
//        vc.YTBackString=@"200";
//
//        self.viewController.navigationController.navigationBar.hidden=YES;
//        self.viewController.tabBarController.tabBar.hidden=YES;
//        [self.viewController.navigationController pushViewController:vc animated:NO];

        PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
        [vc selectedDingDanType:@"0" AndIndexType:0];
        PersonalShoppingDanDetailVC *vc2=[[PersonalShoppingDanDetailVC alloc] init];
        XLDingDanModel *model=[[XLDingDanModel alloc] init];
        model.order_batchid=self.YTOrderno;
        vc2.myDingDanModel=model;
        vc2.delegate=vc;
        self.viewController.navigationController.viewControllers=@[self.viewController.navigationController.viewControllers.firstObject,vc,vc2];
        [self.viewController.navigationController pushViewController:vc2 animated:NO];
    }
}

@end
