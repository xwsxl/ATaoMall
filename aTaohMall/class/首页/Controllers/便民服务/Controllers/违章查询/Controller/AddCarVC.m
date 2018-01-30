//
//  AddCarVC.m
//  aTaohMall
//
//  Created by Zhending Shi on 2017/7/25.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AddCarVC.h"
#import "PeccSelectCityVC.h"
#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
@interface AddCarVC ()<UITextFieldDelegate,SelectCityDelegate>{
    UILabel *proLab;
    UITextField *plateNumTF;
    UILabel *selectCityLab;
    UITextField *carFrameTF;
    UITextField *engineTF;
    UITextField *remarkTF;
    NSString *plateCitystr;
    BOOL isChangeCity;
    UIView *provinceListView;
    UIButton *rightBut;
    UILabel *Titlelabel;
    UIButton *bottomBut;
    UIControl *huiseControl;
    UIView *plateTipsView;
}
@property(nonatomic,strong)NSArray *provinceArr;
@end

@implementation AddCarVC


/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self InitMainView];

}
/*******************************************************      初始化视图       ******************************************************/
/*****
 *
 *  Description 初始化导航栏
 *
 ******/
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
    
    Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-200, 30)];
    
    Titlelabel.text = @"添加车辆";
    
    Titlelabel.textColor = [UIColor blackColor];
    
    Titlelabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    Titlelabel.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:Titlelabel];
    
    rightBut=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame=CGRectMake(kScreen_Width-60, 25+KSafeTopHeight, 40, 30);
    [rightBut setTitle:@"删除" forState:UIControlStateNormal];
    [rightBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(deleteCar:) forControlEvents:UIControlEventTouchUpInside];
    rightBut.hidden=YES;
    [titleView addSubview:rightBut];
}
-(void)QurtBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    // self.tabBarController.tabBar.hidden=YES;
}
/*****
 *
 *  Description 初始化界面视图
 *
 ******/
-(void)InitMainView
{
    UILabel *TipsLabel=[[UILabel alloc]init];
    CGSize size=[@"只支持9座以下小型车查询" sizeWithFont:KNSFONT(12) maxSize:CGSizeMake(kScreen_Width, 30)];
    TipsLabel.frame=CGRectMake((kScreen_Width-size.width)/2, (40-size.height)/2+KSafeAreaTopNaviHeight, size.width, size.height);
    TipsLabel.text=@"只支持9座以下小型车查询";
    TipsLabel.font=KNSFONT(12);
    TipsLabel.textColor=RGB(63, 139, 253);
    [self.view addSubview:TipsLabel];
    
    UIImageView *imgv=[[UIImageView alloc]init];
    imgv.frame=CGRectMake((kScreen_Width-size.width)/2-21, (40-13)/2+KSafeAreaTopNaviHeight, 13, 13);
    imgv.image=[UIImage imageNamed:@"icon_prompt"];
    [self.view addSubview:imgv];
    
    UIView *CarInfoView=[[UIView alloc]init];
    CarInfoView.frame=CGRectMake(0, 50+KSafeAreaTopNaviHeight, kScreen_Width, 156);
    CarInfoView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:CarInfoView];
    
    UILabel *PlateNumLab=[[UILabel alloc]init];
    PlateNumLab.frame=CGRectMake(17, 10, 63, 14);
    PlateNumLab.textColor=RGB(51, 51, 51);
    PlateNumLab.font=KNSFONT(14);
    PlateNumLab.text=@" 车牌号码";
    [PlateNumLab showTextBadgeWithText:@"*"];
    [CarInfoView addSubview:PlateNumLab];
    
    
    
    
    UIView *ProView=[[UIView alloc]initWithFrame:CGRectMake(90, 7, 40, 20)];
    ProView.layer.borderWidth=1;
    ProView.layer.borderColor=[RGB(233, 233, 233) CGColor];
    
    proLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    proLab.font=KNSFONT(14);
    proLab.textColor=RGB(51, 51, 51);
    proLab.text=@"粤";
    proLab.textAlignment=NSTextAlignmentCenter;
    [ProView addSubview:proLab];
    
    
    UIImageView *proIV=[[UIImageView alloc]initWithFrame:CGRectMake(30, 8, 10, 5)];
    proIV.image=[UIImage imageNamed:@"btn_pull-down"];
    [ProView addSubview:proIV];
    
    UITapGestureRecognizer * singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectProvince)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [ProView addGestureRecognizer:singleRecognizer];
    
    [CarInfoView addSubview:ProView];
    
    plateNumTF=[[UITextField alloc]initWithFrame:CGRectMake(135, 10, kScreen_Width-130-30, 14)];
    plateNumTF.placeholder=@"请输入车牌号";
    plateNumTF.font=KNSFONT(13);
    [plateNumTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    plateNumTF.delegate=self;
    plateNumTF.keyboardType=UIKeyboardTypeASCIICapable;
   // plateNumTF.secureTextEntry=YES;
    plateNumTF.autocapitalizationType=UITextAutocapitalizationTypeAllCharacters;
    plateNumTF.returnKeyType=UIReturnKeyDone;
    [CarInfoView addSubview:plateNumTF];
    
    UIButton *but2=[UIButton buttonWithType:UIButtonTypeCustom];
    but2.frame=CGRectMake(kScreen_Width-40-15,10,15,15);
    [but2 setImage:[UIImage imageNamed:@"button_delete"] forState:UIControlStateNormal];
    [but2 addTarget:self action:@selector(deleteText:) forControlEvents:UIControlEventTouchUpInside];
    but2.tag=3500+1;
    but2.hidden=YES;
    [CarInfoView addSubview:but2];

    
    UIButton *plateTipsBut=[UIButton buttonWithType:UIButtonTypeCustom];
    plateTipsBut.frame=CGRectMake(kScreen_Width-30, 10, 15, 15);
    [plateTipsBut setImage:[UIImage imageNamed:@"btn_help"] forState:UIControlStateNormal];
    [plateTipsBut addTarget:self action:@selector(plateTipsButClick) forControlEvents:UIControlEventTouchUpInside];
    [CarInfoView addSubview:plateTipsBut];
    
    UIView *lineView1=[[UIView alloc]initWithFrame:CGRectMake(15, 30, kScreen_Width-30, 1)];
    lineView1.backgroundColor=RGB(226, 226, 226);
    [CarInfoView addSubview:lineView1];
    
    UIView *cityCellView=[[UIView alloc]initWithFrame:CGRectMake(0, 31, kScreen_Width, 30)];
    [CarInfoView addSubview:cityCellView];
    
    
    UITapGestureRecognizer * singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCity)];
    singleTapRecognizer.numberOfTapsRequired = 1; // 单击
    [cityCellView addGestureRecognizer:singleTapRecognizer];
    
    
    UILabel *cityLab=[[UILabel alloc]initWithFrame:CGRectMake(17, 8, 64, 14)];
    cityLab.textColor=RGB(51, 51, 51);
    cityLab.text=@" 查询城市";
    cityLab.font=KNSFONT(14);
    [cityLab showTextBadgeWithText:@"*"];
    [cityCellView addSubview:cityLab];
    
    selectCityLab=[[UILabel alloc]initWithFrame:CGRectMake(90, 8, 200, 14)];
    selectCityLab.textColor=RGB(51, 51, 51);
    selectCityLab.font=KNSFONT(14);
    isChangeCity=YES;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"city"]) {
        isChangeCity=NO;
        selectCityLab.text= [NSString stringWithFormat:@"%@ ",[[[NSUserDefaults standardUserDefaults] objectForKey:@"city"] stringByReplacingOccurrencesOfString:@"市" withString:@""]];
    }
    
    [cityCellView addSubview:selectCityLab];
    
    UIImageView *nextImg=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width-17-10, 8, 10, 15)];
    nextImg.image=[UIImage imageNamed:@"icon_Right-arrow"];
    [cityCellView addSubview:nextImg];
    
    UIView *lineView2=[[UIView alloc]initWithFrame:CGRectMake(15, 62, kScreen_Width-30, 1)];
    lineView2.backgroundColor=RGB(226, 226, 226);
    [CarInfoView addSubview:lineView2];
    
    UILabel *carFrameNumLab=[[UILabel alloc]initWithFrame:CGRectMake(17, 70, 64, 14)];
    carFrameNumLab.textColor=RGB(51, 51, 51);
    carFrameNumLab.font=KNSFONT(14);
    carFrameNumLab.text=@" 车架号码";
    [carFrameNumLab showTextBadgeWithText:@"*"];
    [CarInfoView addSubview:carFrameNumLab];
    
    carFrameTF=[[UITextField alloc]initWithFrame:CGRectMake(90,70,kScreen_Width-90-15, 14)];
    carFrameTF.placeholder=@"请输入完整的车架号";
    carFrameTF.font=KNSFONT(14);
    [carFrameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [CarInfoView addSubview:carFrameTF];
    carFrameTF.delegate=self;
    carFrameTF.keyboardType=UIKeyboardTypeASCIICapable;
    carFrameTF.returnKeyType=UIReturnKeyDone;
   carFrameTF.autocapitalizationType=UITextAutocapitalizationTypeAllCharacters;
    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame=CGRectMake(kScreen_Width-40,70,15,15);
    [but setImage:[UIImage imageNamed:@"button_delete"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(deleteText:) forControlEvents:UIControlEventTouchUpInside];
    but.hidden=YES;
    but.tag=3500+2;
    [CarInfoView addSubview:but];
    
    UIView *lineView3=[[UIView alloc]initWithFrame:CGRectMake(15, 94, kScreen_Width-30, 1)];
    lineView3.backgroundColor=RGB(226, 226, 226);
    [CarInfoView addSubview:lineView3];
    
    UILabel *engineNumLab=[[UILabel alloc]initWithFrame:CGRectMake(17, 102, 64, 14)];
    engineNumLab.textColor=RGB(51, 51, 51);
    engineNumLab.font=KNSFONT(14);
    engineNumLab.text=@" 发动机号";
    [engineNumLab showTextBadgeWithText:@"*"];
    [CarInfoView addSubview:engineNumLab];
    
    engineTF=[[UITextField alloc]initWithFrame:CGRectMake(90, 102,kScreen_Width-90-15, 14)];
    engineTF.placeholder=@"请输入完整的发动机号";
    engineTF.font=KNSFONT(14);
    engineTF.delegate=self;
    engineTF.keyboardType=UIKeyboardTypeASCIICapable;
    engineTF.returnKeyType=UIReturnKeyDone;
    engineTF.autocapitalizationType=UITextAutocapitalizationTypeAllCharacters;
    [engineTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [CarInfoView addSubview:engineTF];
    UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
    but1.frame=CGRectMake(kScreen_Width-40,102,15,15);
    [but1 setImage:[UIImage imageNamed:@"button_delete"] forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(deleteText:) forControlEvents:UIControlEventTouchUpInside];
    but1.hidden=YES;
    but1.tag=3500+3;
    [CarInfoView addSubview:but1];
    UIView *lineView4=[[UIView alloc]initWithFrame:CGRectMake(15, 126, kScreen_Width-30, 1)];
    lineView4.backgroundColor=RGB(226, 226, 226);
    [CarInfoView addSubview:lineView4];
    
    UILabel *remarkNameLab=[[UILabel alloc]initWithFrame:CGRectMake(17, 134, 64, 14)];
    remarkNameLab.textColor=RGB(51, 51, 51);
    remarkNameLab.font=KNSFONT(14);
    remarkNameLab.text=@" 备注名称";
    [CarInfoView addSubview:remarkNameLab];
    
    remarkTF=[[UITextField alloc]initWithFrame:CGRectMake(90, 134, kScreen_Width-90-15, 14)];
    remarkTF.placeholder=@"例如:公司用车";
    remarkTF.font=KNSFONT(14);
    remarkTF.delegate=self;
    remarkTF.returnKeyType=UIReturnKeyDone;
    [CarInfoView addSubview:remarkTF];
    
    UIImageView *ExampleIV=[[UIImageView alloc]initWithFrame:CGRectMake(17, 218+KSafeAreaTopNaviHeight, kScreen_Width-34, kScreen_Height-112-KSafeAreaBottomHeight-20-218-KSafeAreaTopNaviHeight)];
    ExampleIV.image=[UIImage imageNamed:@"u740"];
    ExampleIV.layer.cornerRadius=10;
    [self.view addSubview:ExampleIV];
    
    UILabel *bottomTipsLab=[[UILabel alloc]initWithFrame:CGRectMake(17, kScreen_Height-63-KSafeAreaBottomHeight, kScreen_Width-34, 30)];
    bottomTipsLab.textColor=RGB(153, 153, 153);
    bottomTipsLab.font=KNSFONT(12);
    bottomTipsLab.numberOfLines=0;
    bottomTipsLab.textAlignment=NSTextAlignmentLeft;
    bottomTipsLab.text=@"所填信息为交管所查询所必须信息，我们将对您的信息严格保密，请放心填写";
    [self.view addSubview:bottomTipsLab];
    
    bottomBut=[UIButton buttonWithType:UIButtonTypeCustom];
    bottomBut.frame=CGRectMake(15, kScreen_Height-112-KSafeAreaBottomHeight, kScreen_Width-30, 37);
    bottomBut.backgroundColor=RGB(255, 93, 94);
    [bottomBut setTitle:@"保存并查询" forState:UIControlStateNormal];
    [bottomBut addTarget:self action:@selector(saveAddCar) forControlEvents:UIControlEventTouchUpInside];
    bottomBut.layer.cornerRadius=4;
    [self.view addSubview:bottomBut];
    
    if (self.delegate&&self.CarModel) {
        Titlelabel.text=@"编辑车辆";
        proLab.text=[_CarModel.PlateNumberStr substringToIndex:1];
        plateNumTF.text=[_CarModel.PlateNumberStr substringFromIndex:1];
        if (_CarModel.CityListArr.count==1) {
            selectCityLab.text=_CarModel.CityListArr.lastObject;
        }else
        {
            selectCityLab.text=[_CarModel.CityListArr componentsJoinedByString:@" "];
        }
        carFrameTF.text=_CarModel.FrameNumberStr;
        NSLog(@"车架号%@",_CarModel.FrameNumberStr);
        engineTF.text=_CarModel.EngineNumberStr;
        remarkTF.text=_CarModel.RemarkNameStr;
        rightBut.hidden=NO;
        [bottomBut removeTarget:self action:@selector(saveAddCar) forControlEvents:UIControlEventTouchUpInside];
        [bottomBut addTarget:self action:@selector(editCar:) forControlEvents:UIControlEventTouchUpInside];
        //   });
        // });
    }
    
}
/*****
 *
 *  Description 设置成编辑车辆页面
 *
 ******/
-(void)setViewWithModel:(CarInfoModel *)CarModel
{
    self.CarModel=CarModel;
    Titlelabel.text=@"编辑车辆";
    proLab.text=[CarModel.PlateNumberStr substringToIndex:1];
    plateNumTF.text=[CarModel.PlateNumberStr substringFromIndex:1];
    if (CarModel.CityListArr.count==1) {
        selectCityLab.text=CarModel.CityListArr.lastObject;
    }else
    {
        selectCityLab.text=[CarModel.CityListArr componentsJoinedByString:@" "];
    }
    carFrameTF.text=CarModel.FrameNumberStr;
    NSLog(@"车架号%@",CarModel.FrameNumberStr);
    engineTF.text=CarModel.EngineNumberStr;
    remarkTF.text=CarModel.RemarkNameStr;
    rightBut.hidden=NO;
    [bottomBut removeTarget:self action:@selector(saveAddCar) forControlEvents:UIControlEventTouchUpInside];
    [bottomBut addTarget:self action:@selector(editCar:) forControlEvents:UIControlEventTouchUpInside];
    
}

/*******************************************************      页面跳转       ******************************************************/
/*****
 *
 *  Description 前往城市选择页面
 *
 ******/
-(void)selectCity
{
    isChangeCity=NO;
    [self hideKeyBoard];
    
    PeccSelectCityVC *VC=[[PeccSelectCityVC alloc]init];
    NSArray *arr=[selectCityLab.text componentsSeparatedByString:@" "];
    for (int i=0; i<arr.count; i++) {
        if (![arr[i] isEqualToString:@""]) {
            [VC.selectCityArr addObject:arr[i]];
        }
    }
    VC.delegate=self;
    [self.navigationController pushViewController:VC animated:NO];
    //NSLog(@"城市选择");
}

/*****
 *
 *  Description 弹出省份视图
 *
 ******/
-(void)selectProvince
{
    [self hideKeyBoard];
    if (!provinceListView) {
        provinceListView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, 254)];
        provinceListView.backgroundColor=RGB(201, 206, 214);
        for (int i=0; i<4; i++) {
            for (int j=0; j<10; j++) {
                if (j+i*10<self.provinceArr.count) {
                    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
                    but.frame=CGRectMake(5+j*(31+(kScreen_Width-310-10)/9), 15+i*60, 31, 45);
                    but.backgroundColor=[UIColor whiteColor];
                    but.layer.cornerRadius=4;
                    [but setTitle:[self.provinceArr objectAtIndex:j+i*10] forState:UIControlStateNormal];
                    [but setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
                    but.tag=10000+j+i*10;
                    [but addTarget:self action:@selector(hasSelectProvince:) forControlEvents:UIControlEventTouchUpInside];
                    [provinceListView addSubview:but];
                }
            }
        }
        
    }
    
    if (!huiseControl) {
        huiseControl=[[UIControl alloc]initWithFrame:self.view.frame];
        huiseControl.backgroundColor=RGBA(0, 0, 0, 0.74);
        [huiseControl addTarget:self action:@selector(huiseCotrolclick) forControlEvents:UIControlEventTouchUpInside];
        huiseControl.alpha=0;
    }
    huiseControl.backgroundColor=RGBA(0, 0, 0, 0.01);
    if (huiseControl.superview==nil) {
        [self.view addSubview:huiseControl];
    }
    [self.view addSubview:provinceListView];
    provinceListView.hidden=NO;
    [UIView animateWithDuration:0.2 animations:^{
        provinceListView.frame=CGRectMake(0, kScreen_Height-254-KSafeAreaBottomHeight, kScreen_Width, 254);
        huiseControl.alpha=1;
    }];
    NSLog(@"选择省份");
}

/*****
 *
 *  Description 选择了省份
 *
 ******/
-(void)hasSelectProvince:(UIButton *)sender
{
    proLab.text=[self.provinceArr objectAtIndex:sender.tag-10000];
    [UIView animateWithDuration:0.2 animations:^{
        huiseControl.alpha=0;
    }completion:^(BOOL finished) {
        provinceListView.hidden=YES;
    }];
    
    
}

/*****
 *
 *  Description 车牌号填写提示
 *
 ******/
-(void)plateTipsButClick
{
    [self hideKeyBoard];
    if (!plateTipsView) {
        plateTipsView=[[UIView alloc]initWithFrame:CGRectMake(60, (kScreen_Height-100)/2, kScreen_Width-120, 140)];
        plateTipsView.backgroundColor=[UIColor whiteColor];
        plateTipsView.layer.cornerRadius=10;
        
        UIButton *closeBut=[UIButton buttonWithType:UIButtonTypeCustom];
        closeBut.frame=CGRectMake(kScreen_Width-130,-10, 20, 20);
        [closeBut setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
        [closeBut addTarget:self action:@selector(huiseCotrolclick) forControlEvents:UIControlEventTouchUpInside];
        [plateTipsView addSubview:closeBut];
        
        UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreen_Width-120, 15)];
        titleLab.font=KNSFONT(16);
        titleLab.textColor=RGB(51, 51, 51);
        titleLab.text=@"提示";
        titleLab.textAlignment=NSTextAlignmentCenter;
        [plateTipsView addSubview:titleLab];
        
        UILabel *msgLab=[[UILabel alloc]initWithFrame:CGRectMake(30, 45,kScreen_Width-180, 110-45)];
        msgLab.font=KNSFONT(15);
        msgLab.textColor=RGB(51, 51, 51);
        msgLab.text=@"暂不支持查询粤港直通车、半挂车、挂车、教练车、军车、警车等违章信息。";
        msgLab.numberOfLines=0;
        [plateTipsView addSubview:msgLab];
    }
    if (!huiseControl) {
        huiseControl=[[UIControl alloc]initWithFrame:self.view.frame];
        huiseControl.backgroundColor=RGBA(0, 0, 0, 0.74);
        [huiseControl addTarget:self action:@selector(huiseCotrolclick) forControlEvents:UIControlEventTouchUpInside];
        huiseControl.alpha=0;
    }
    huiseControl.backgroundColor=RGBA(0, 0, 0, 0.74);
    if (huiseControl.superview==nil) {
        [self.view addSubview:huiseControl];
    }
    [self.view addSubview:plateTipsView];
    
    [UIView animateWithDuration:0.2 animations:^{
        huiseControl.alpha=1;
    }];
    
    NSLog(@"添加车辆提示信息");
}

/*****
 *
 *  Description 点击遮罩
 *
 ******/
-(void)huiseCotrolclick
{
    
    [UIView animateWithDuration:0.2 animations:^{
        huiseControl.alpha=0;
        provinceListView.frame=CGRectMake(0, kScreen_Height, kScreen_Width, 254);
    }completion:^(BOOL finished) {
        if (plateTipsView.superview!=nil) {
            [plateTipsView removeFromSuperview];
        }

    }];
}
#pragma mark-UITextFieldDelegate-输入框的协议方法
//判断能否输入所选字符
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==plateNumTF){
        
    NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    NSLog(@"string=%@,filtered=%@,plateNumTF=%@",string,filtered,plateNumTF.text);
    BOOL canChange = [string isEqualToString:filtered];
    if (!canChange) {
        [TrainToast showWithText:@"只能输入大写英文字母和数字" duration:1.0];
    }
    else if (plateNumTF.text.length>5)
    {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }else if ([plateNumTF.text isEqualToString:string])
        {
            return YES;
        }
        [TrainToast showWithText:@"车牌号最多为6位" duration:1.0];
        return NO;
    }
    return canChange;
    }else if ((textField==carFrameTF)||(textField==engineTF)) {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
        
        BOOL canChange = [string isEqualToString:filtered];
        if (!canChange) {
            [TrainToast showWithText:@"只能输入英文字母和数字" duration:1.0];
        }
        return  canChange;
    }
    else if (textField==remarkTF)
    {

        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        
        if (remarkTF.text.length>5) {
            
            if ([remarkTF.text isEqualToString:string])
            {
                return YES;
            }
            return NO;
        }else if ((remarkTF.text.length+string.length)>6)
        {
            return NO;
        }
        return YES;
    }
    else
    {
        
        return YES;
    }
}
//开始编辑切长度不为0时显示删除按钮
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==plateNumTF) {
        if (plateNumTF.text.length>0) {
            
            if (!plateCitystr) {
                plateCitystr=[NSString string];
            }
            if (![plateCitystr isEqualToString:[proLab.text stringByAppendingString:[plateNumTF.text substringToIndex:1]]]) {
                plateCitystr=[proLab.text stringByAppendingString:[plateNumTF.text substringToIndex:1]];
                if (isChangeCity) {
                    [self getPlateNumCity];
                }
            }
            [self.view viewWithTag:3501].hidden=NO;
            
        }else
        {
            [self.view viewWithTag:3501].hidden=YES;
        }
    }
    else  if (textField==carFrameTF)
    {
        if (carFrameTF.text.length>0) {
            [self.view viewWithTag:3502].hidden=NO;
        }
        else
        {
            [self.view viewWithTag:3502].hidden=YES;
        }
        NSLog(@"carFrameTF.text=%@",carFrameTF.text);
    }
    else if (textField==engineTF)
    {
        if (engineTF.text.length>0) {
            [self.view viewWithTag:3503].hidden=NO;
        }
        else
        {
            [self.view viewWithTag:3503].hidden=YES;
        }
        NSLog(@"engineTF.text=%@",engineTF.text);
    }

}
//结束编辑隐藏删除按钮
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==plateNumTF) {
        
            [self.view viewWithTag:3501].hidden=YES;
      
    }
    else  if (textField==carFrameTF)
    {
       
            [self.view viewWithTag:3502].hidden=YES;
        
    }
    else if (textField==engineTF)
    {
        
            [self.view viewWithTag:3503].hidden=YES;
       
    }
}
//点击return键时收起键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}
//输入框的文本变化时执行的方法 ps：这个是添加的监听，不是协议方法
-(void)textFieldDidChange:(UITextField *)TF
{
   // NSLog(@"TF.text=%@",TF.text);
  NSString *str=[NSStringHelper toUpper:TF.text];
    NSLog(@"str=%@",str);
    TF.text=str;
    if (TF==plateNumTF) {
        if (plateNumTF.text.length>0) {
            
            if (!plateCitystr) {
                plateCitystr=[NSString string];
            }
            if (![plateCitystr isEqualToString:[proLab.text stringByAppendingString:[plateNumTF.text substringToIndex:1]]]) {
                plateCitystr=[proLab.text stringByAppendingString:[plateNumTF.text substringToIndex:1]];
                if (isChangeCity) {
                    [self getPlateNumCity];
                }
            }
            [self.view viewWithTag:3501].hidden=NO;
            
        }else
        {
            [self.view viewWithTag:3501].hidden=YES;
        }
        NSLog(@"plateTF.text=%@",plateNumTF.text);
    }
    else  if (TF==carFrameTF)
    {
        if (carFrameTF.text.length>0) {
            [self.view viewWithTag:3502].hidden=NO;
        }
        else
        {
            [self.view viewWithTag:3502].hidden=YES;
        }
        NSLog(@"carFrameTF.text=%@",carFrameTF.text);
    }
    else if (TF==engineTF)
    {
        if (engineTF.text.length>0) {
            [self.view viewWithTag:3503].hidden=NO;
        }
        else
        {
            [self.view viewWithTag:3503].hidden=YES;
        }
        NSLog(@"engineTF.text=%@",engineTF.text);
    }
    
}
#pragma mark-SelectCityDelegate 选择了城市回传城市数组
/*****
 *
 *  Description 选择了城市
 *
 ******/
-(void)hasSelectCity:(NSMutableArray *)array
{
    selectCityLab.text=[array componentsJoinedByString:@" "];
    NSLog(@"%@",selectCityLab.text);
}


/*****
 *
 *  Description 删除输入框信息
 *
 ******/
-(void)deleteText:(UIButton *)sender
{
    switch (sender.tag) {
        case 3501:
            plateNumTF.text=@"";
            break;
        case 3502:
            carFrameTF.text=@"";
            break;
        case 3503:
            engineTF.text=@"";
            break;
        default:
            break;
    }
    sender.hidden=YES;
}

/*****
 *
 *  Description 收起键盘
 *
 ******/
-(void)hideKeyBoard
{
    [plateNumTF resignFirstResponder];
    [carFrameTF resignFirstResponder];
    [engineTF resignFirstResponder];
    [remarkTF resignFirstResponder];
}




/*******************************************************      懒加载       ******************************************************/
-(NSArray *)provinceArr
{
    if (!_provinceArr) {
        _provinceArr=@[@"京",@"津",@"沪",@"渝",@"冀",@"晋",@"辽",@"吉",@"黑",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"琼",@"川",@"贵",@"云",@"陕",@"甘",@"青",@"桂",@"蒙",@"藏",@"宁",@"新"];
    }
    return _provinceArr;
}
/*******************************************************      数据请求       ******************************************************/
/*****
 *
 *  Description 校验填写的信息是否正确
 *
 ******/
-(BOOL)CarInfoIsCorrect
{
    
    NSString *ptr = @"^[A-Z]+[0-9]+[A-Z0-9]*|[0-9]+[A-Z]+[A-Z0-9]*$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ptr];
    
    BOOL plateNumBOOL=[carTest evaluateWithObject:plateNumTF.text];
    
    NSString *ptr2= @"^[A-Za-z0-9]*$";
    NSPredicate *carTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ptr2];
    BOOL frameNumBOOL=(![carFrameTF.text isEqualToString:@""])&&[carTest2 evaluateWithObject:carFrameTF.text];
    NSPredicate *carTest3=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",ptr2];
    BOOL engineNumBOOL=(![engineTF.text isEqualToString:@""])&&[carTest3 evaluateWithObject:engineTF.text];
    BOOL selectCityBOOL=![selectCityLab.text isEqualToString:@""];
    
    if (!plateNumBOOL) {
        [TrainToast showWithText:@"请输入正确的车牌号" duration:2.0];
    }else if (!selectCityBOOL)
    {
        [TrainToast showWithText:@"请选择查询城市" duration:2.0];
    }else if (!frameNumBOOL)
    {
        [TrainToast showWithText:@"请输入正确的车架号" duration:2.0];
    }else if (!engineNumBOOL)
    {
        [TrainToast showWithText:@"请输入正确的发动机号" duration:2.0];
    }else
    {
        return YES;
    }
    
    return NO;
    
}
/*****
 *
 *  Description 添加车辆
 *
 ******/
-(void)saveAddCar
{
    if (![self CarInfoIsCorrect]) {
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@addVehicle_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    NSDictionary *param=@{@"sigen":[[NSUserDefaults standardUserDefaults] stringForKey:@"sigen"],@"carNo":[proLab.text stringByAppendingString:plateNumTF.text],@"frameNo":carFrameTF.text,@"enginNo":engineTF.text,@"city_name":[selectCityLab.text stringByReplacingOccurrencesOfString:@" " withString:@","],@"remark_name":remarkTF.text};
    
    
    NSLog(@"param=%@,%@",param,[[NSUserDefaults standardUserDefaults] stringForKey:@"sigen"]);
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic=%@",dic);
            
            if ([dic[@"status"] isEqualToString:@"10000"])
            {
                
                [TrainToast showWithText:@"添加成功" duration:2.0];
                [self.delegate refreshData];
                [self.navigationController popViewControllerAnimated:NO];
            }
            else{
                [TrainToast showWithText:dic[@"message"] duration:1.0];
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [TrainToast showWithText:@"网络请求出错" duration:1.0];
    }];
    
    
}
/*****
 *
 *  Description 编辑车辆
 *
 ******/
-(void)editCar:(UIButton *)sender
{
    if (![self CarInfoIsCorrect]) {
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSString *url = [NSString stringWithFormat:@"%@editorVehicle_mob.shtml",URL_Str];
    //saveUserExchange_mob.shtml
    NSDictionary *param=@{@"sigen":[[NSUserDefaults standardUserDefaults] stringForKey:@"sigen"],@"carNo":[proLab.text stringByAppendingString:plateNumTF.text],@"frameNo":carFrameTF.text,@"enginNo":engineTF.text,@"city_name":[NSString stringWithFormat:@"%@",[selectCityLab.text stringByReplacingOccurrencesOfString:@" " withString:@","]],@"remark_name":remarkTF.text,@"carNo_former":_CarModel.PlateNumberStr};
    NSLog(@"param=%@,%@",param,[[NSUserDefaults standardUserDefaults] stringForKey:@"sigen"]);
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic=%@",dic);
            
            if ([dic[@"status"] isEqualToString:@"10000"])
            {
                
                [TrainToast showWithText:@"修改成功" duration:2.0];
                [self.delegate refreshData];
                [self.navigationController popViewControllerAnimated:NO];
            }
            else{
                [TrainToast showWithText:dic[@"message"] duration:1.0];
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [TrainToast showWithText:@"网络请求出错" duration:1.0];
    }];
}
/*****
 *
 *  Description 删除车辆
 *
 ******/
-(void)deleteCar:(UIButton *)sender
{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"确定要删除该车辆？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *url = [NSString stringWithFormat:@"%@deleteVehicle_mob.shtml",URL_Str];
        
        NSDictionary *params=@{@"sigen":[[NSUserDefaults standardUserDefaults] objectForKey:@"sigen"],@"carNo":_CarModel.PlateNumberStr};
        [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
            NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
            
            
            if (codeKey && content) {
                NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                
                NSLog(@"xmlStr==%@",xmlStr);
                
                
                NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"dic=%@",dic);
                
                if ([dic[@"status"] isEqualToString:@"10000"])
                {
                    
                    [TrainToast showWithText:@"删除成功" duration:2.0];
                    [self.delegate refreshData];
                    [self.navigationController popViewControllerAnimated:NO];
                }
                else{
                    [TrainToast showWithText:dic[@"message"] duration:1.0];
                }
            }
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
        }];
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
}
/*****
 *
 *  Description 获取车牌号城市，在定位不到位置和没有选择城市之前执行
 *
 ******/
-(void)getPlateNumCity
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@getLicensePlateCity_omb.shtml",URL_Str];
    
    NSDictionary *param=@{@"license_plate":plateCitystr};
    
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
        
        
        if (codeKey && content) {
            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            
            NSLog(@"xmlStr==%@",xmlStr);
            
            
            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic=%@",dic);
            
            if ([dic[@"status"] isEqualToString:@"10000"])
            {
                selectCityLab.text=dic[@"city"];
            }
            else{
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
}





@end
