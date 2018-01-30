//
//  AddMyPayCardViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/5/17.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "AddMyPayCardViewController.h"

#import "UITextField+Helper.h"
#import "TitleCell.h"
#import "TextFieldCell.h"
#import "TitleLabelCell.h"

#import "YinHangCell.h"

#import "AFNetworking.h"

#import "BankBankViewController.h"

#import "ConverUtil.h"
#import "DESUtil.h"
#import "SecretCodeTool.h"


#import "BankUserIdCell.h"
#import "BankUserNameCell.h"

#import "WKProgressHUD.h"

#import "ZHPickView.h"

#import "APNumberPad.h"
#import "APDarkPadStyle.h"
#import "APBluePadStyle.h"


@interface AddMyPayCardViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BankNameDelegate,ZHPickViewDelegate,APNumberPadDelegate>
{
    UITableView *_tableView;
    TextFieldCell *_cell;
    BankUserIdCell *_cell1;
    BankUserNameCell *_cell2;
    
    AFHTTPRequestOperationManager *manager;
    
    UIAlertController *alertCon;
    
    UITableView *_provinceTabView;
    
    UITableView *_cityTabView;
    
    UITableView *_bankTabView;
    
    UITableView *_bankAddresTabView;
    
    NSMutableArray *prvincArray;
    NSMutableArray *cityArray;
    NSMutableArray *bankArray;
    NSMutableArray *bankAddresArray;
    
    UIView *view;
    
    
    NSString *strPrvince;
    NSString *strBanks;
    NSString *strCity;
    
    NSString *bankCardnum;//卡号
    NSString *bankNames;//开户行名称
    NSString *banknum;//开户行号
    
    NSInteger indexs;
    
    NSString *banknumber;
    NSString *citynumber;
    
    BOOL prOpen;
    BOOL ciOpen;
    BOOL baOpen;
    YinHangCell *cell5;
    
    UIButton *backBtn;
    
    
    MBProgressHUD *myProgressHum;
    
    NSString *_name;
    NSString *_number;
}

@property(nonatomic,strong)ZHPickView *pickview;

@end

@implementation AddMyPayCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initTableView];
    

    self.view.frame=[UIScreen mainScreen].bounds;
    
    prOpen = NO;
    baOpen = NO;
    ciOpen = NO;
    
    
    cell5.YinHangLabel.text=@"中国工商银行";
    _number=@"102100099996";
    _name=@"中国工商银行";
    
    prvincArray = [NSMutableArray array];
    cityArray = [NSMutableArray array];
    bankArray = [NSMutableArray array];
    bankAddresArray = [NSMutableArray array];
    
    
    UIView *view1=[[UIView alloc] init];
    view1.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49-KSafeAreaBottomHeight, [UIScreen mainScreen].bounds.size.width, 49);
    [self.view addSubview:view1];
    
    UIButton *Surebutton=[UIButton buttonWithType:UIButtonTypeCustom];
    Surebutton.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49);
    
    [Surebutton setTitle:@"确认添加" forState:0];
    [Surebutton setTitleColor:[UIColor whiteColor] forState:0];
    Surebutton.backgroundColor=[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1];
    
    [Surebutton addTarget:self action:@selector(SureButtonBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view1 addSubview:Surebutton];
    
    
   
    // code1
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    // code2
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:andOtherTextField:) name:UIKeyboardWillShowNotification object:nil];
//    //监听键盘的掉下
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


//实现UITextFieldDelegate中的方法

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
    
}

//然后在MyView.m中实现touchedBegan方法

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_pickview remove];
    
    [self.view endEditing:YES];
    
    [_cell.addPayCardTF resignFirstResponder];
    [_cell2.BankUserNameTF resignFirstResponder];
    [_cell1.BankUserIdTF resignFirstResponder];
}


-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaBottomHeight-49) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    
    //去掉分割线
    _tableView.separatorStyle=NO;
    
    
    //分割线
    
    _tableView.separatorInset = UIEdgeInsetsZero;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TitleCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TextFieldCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TitleLabelCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"YinHangCell" bundle:nil] forCellReuseIdentifier:@"cell4"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"BankUserIdCell" bundle:nil] forCellReuseIdentifier:@"cell5"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"BankUserNameCell" bundle:nil] forCellReuseIdentifier:@"cell6"];
}

-(void)setBankNameWithString:(NSString *)name andBankNumberWithString:(NSString *)number
{
    _name=name;
    _number=number;
    
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==8) {
        return 110;
    }
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        TitleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text=@"银行卡号：";
        return cell;
    }else if (indexPath.row==1){
        _cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bankcardno=_cell.addPayCardTF.text;
        
        _cell.addPayCardTF.placeholder=@"请输入您的银行卡号";
        
        _cell.addPayCardTF.delegate=self;
        return _cell;
    }else if (indexPath.row==2){
        TitleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text=@"开户行：";
        return cell;
    }else if (indexPath.row==3){
        cell5=[tableView dequeueReusableCellWithIdentifier:@"cell4"];
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        cell5.YinHangLabel.text=_name;
        cell5.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell5.backgroundColor=[UIColor whiteColor];
        return cell5;
    }else if (indexPath.row==4){
        TitleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text=@"姓名：";
        return cell;
    }else if (indexPath.row==5){
        _cell2=[tableView dequeueReusableCellWithIdentifier:@"cell6"];
        _cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        self.realname=_cell2.BankUserNameTF.text;
        
//        _cell.addPayCardTF.placeholder=@"请输入您的姓名";
        _cell2.BankUserNameTF.delegate=self;
        
        self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
        __weak AddMyPayCardViewController *weakSelf = self;
        [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
            [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:_cell2.BankUserNameTF, nil];
        }];
        
        NSLog(@"=====11111%@==%@",self.realname,_cell2.BankUserNameTF.text);
        return _cell2;
    }else if (indexPath.row==6){
        TitleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text=@"身份证号：";
        return cell;
    }else if (indexPath.row==7){
        _cell1=[tableView dequeueReusableCellWithIdentifier:@"cell5"];
        _cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        self.identity=_cell1.BankUserIdTF.text;
        
        NSLog(@"=====22222%@==%@",self.identity,_cell1.BankUserIdTF.text);
        
//        _cell1.addPayCardTF.placeholder=@"请输入您的身份证号";
//        _cell1.BankUserIdTF.delegate=self;
        
        
//        _cell1.BankUserIdTF.borderStyle = UITextBorderStyleRoundedRect;
        _cell1.BankUserIdTF.inputView = ({
            APNumberPad *numberPad = [APNumberPad numberPadWithDelegate:self];
            
            [numberPad.leftFunctionButton setTitle:@"X" forState:UIControlStateNormal];
            numberPad.leftFunctionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            numberPad;
        });
        
        
        self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
        __weak AddMyPayCardViewController *weakSelf = self;
        [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
            [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:_cell1.BankUserIdTF, nil];
        }];

        return _cell1;
    }else{
        
        TitleLabelCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}




#pragma mark - APNumberPadDelegate

- (void)numberPad:(APNumberPad *)numberPad functionButtonAction:(UIButton *)functionButton textInput:(UIResponder<UITextInput> *)textInput {
    if ([textInput isEqual:_cell1.BankUserIdTF]) {
        [functionButton setTitle:[functionButton.currentTitle stringByAppendingString:@""] forState:UIControlStateNormal];
        [textInput insertText:@"X"];
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
//        BankBankViewController *vc=[[BankBankViewController alloc] init];
//        vc.delegate=self;
//        [self.navigationController pushViewController:VC animated:NO];
//        self.navigationController.navigationBar.hidden=YES;
        
        _pickview=[[ZHPickView alloc] initPickviewWithPlistName:@"一组数据3" isHaveNavControler:NO];
        
        _pickview.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-250, [UIScreen mainScreen].bounds.size.width, 250);
        
        _pickview.delegate=self;
        
        [_pickview show];
        
        
    }else{
        
        [_pickview remove];
    }
    
    [self.view endEditing:YES];
}
//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    [_pickview remove];
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    
    
    [_cell.addPayCardTF resignFirstResponder];
    [_cell2.BankUserNameTF resignFirstResponder];
    [_cell1.BankUserIdTF resignFirstResponder];
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [manager.operationQueue cancelAllOperations];
    
    [_cell.addPayCardTF resignFirstResponder];
    [_cell2.BankUserNameTF resignFirstResponder];
    [_cell1.BankUserIdTF resignFirstResponder];
}



//确认添加
-(void)SureButtonBtnClick
{
    [_tableView reloadData];
    
    NSLog(@"_number=%@",_number);
    NSLog(@"_name=%@",_name);
    NSLog(@"self.identity=%@",_cell1.BankUserIdTF.text);
    NSLog(@"self.realname=%@",_cell2.BankUserNameTF.text);
    NSLog(@"self.bankcardno=%@",self.bankcardno);
    
//    NSString *str = @"6226820011200783033";
    
    
    NSLog(@"&&&&==_cell1.BankUserIdTF.text=%@",_cell1.BankUserIdTF.text);
    NSLog(@"&&&&==_cell2.BankUserNameTF.text=%@",_cell2.BankUserNameTF.text);
    NSLog(@"&&&&==_cell.addPayCardTF=%@",_cell.addPayCardTF);
    NSLog(@"&&&&==_name=%@",_name);
    NSLog(@"&&&&==_number.length=%@",_number);
    
    
    if (_cell1.BankUserIdTF.text.length==0 || _cell2.BankUserNameTF.text.length==0 || _cell.addPayCardTF.text.length==0 || _name.length==0 || _number.length==0) {
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:@"请完善个人信息!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertView show];
        
    }else{
        
        
        NSString *bankNo=[UITextField numberToNormalNumTextField:_cell.addPayCardTF];
        
        //验证银行卡
        BOOL isRight = [self checkCardNo:bankNo];
        
        //验证身份证
        NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
        
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
        
        BOOL ret = [identityCardPredicate evaluateWithObject:_cell1.BankUserIdTF.text];
        
        
        if (!isRight) {
            
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的银行卡号!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alertView show];
        }else{
            
            
            if (!ret) {
                
                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:@"您输入的身份证号码有误!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                
                [alertView show];
            }else{
                
                
                WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
                
                
                
               

                    //获取数据
                    
                    manager = [AFHTTPRequestOperationManager manager];
                    
                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                    
                    NSString *url = [NSString stringWithFormat:@"%@userAddBankcard_mob.shtml",URL_Str];
                    
                    NSDictionary *dic = @{@"sigen":self.sigen,@"bankno":_number,@"bank":_name,@"identity":_cell1.BankUserIdTF.text,@"realname":_cell2.BankUserNameTF.text,@"bankcardno":bankNo};
                    
                    
                    NSLog(@"%@",self.sigen);
                    NSLog(@"%@",_number);
                    NSLog(@"%@",_name);
                    NSLog(@"%@",self.identity);
                    NSLog(@"%@",self.realname);
                    NSLog(@"%@",bankNo);
                    
                    //    NSDictionary *dic=nil;
                    
                    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSString *codeKey = [SecretCodeTool getDesCodeKey:operation.responseString];
                        NSString *content = [SecretCodeTool getReallyDesCodeString:operation.responseString];
                        
                        
                        
                        
                        if (codeKey && content) {
                            NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
                            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                            xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                            
                            //NSLog(@"xmlStr%@",xmlStr);
                            [hud dismiss:YES];
                            
                            NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
                            
                            
                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                            
                            NSLog(@"%@",dic);
                            
                            view.hidden=YES;
                            
                            for (NSDictionary *dict in dic) {
                                
                                NSLog(@"===%@",dict[@"message"]);
                                
                                self.message=dict[@"message"];
                                
                                if ([dict[@"status"] isEqualToString:@"10000"]) {
                                    
                                    if (_delegate && [_delegate respondsToSelector:@selector(addCard)]) {
                                        [_delegate addCard];
                                    }
                                    
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
                                }else if ([dict[@"status"] isEqualToString:@"10002"]){
                                    
                                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:self.message message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                    
                                    [alert show];
                                }else if ([dict[@"status"] isEqualToString:@"10005"]){
                                    
                                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:self.message message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                    
                                    [alert show];
                                }else if ([dict[@"status"] isEqualToString:@"10007"]){
                                    
                                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:self.message message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                    
                                    [alert show];
                                }else if ([dict[@"status"] isEqualToString:@"10003"]){
                                    
                                    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:self.message message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                    
                                    [alert show];
                                }
                            }
                            
                        }
                        
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
//                        [WKProgressHUD popMessage:@"网络请求失败，请检查您的网络设置" inView:self.view duration:1.5 animated:YES];
                        
                        [self NoWebSeveice];
                        
                        NSLog(@"%@",error);
                    }];
                    
                               }
            
        }
    }
    
}


-(void)NoWebSeveice
{
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    view.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self.view addSubview:view];
    
    
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

-(void)loadData
{
    WKProgressHUD *hud = [WKProgressHUD showInView:self.view withText:nil animated:YES];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [hud dismiss:YES];
    });
    
    [self SureButtonBtnClick];
    
}


//判断是否为银行卡
- (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    _name=resultString;
    
    
    NSString *BankNo;
    
    cell5.YinHangLabel.text=resultString;
    
    
    if ([resultString isEqualToString:@"中国工商银行"]) {
        
        BankNo=@"102100099996";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"中国农业银行"]){
        
        BankNo=@"103100000026";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"中国银行"]){
        
        BankNo=@"104100000004";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"中国建设银行"]){
        
        BankNo=@"105100000017";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"中国光大银行"]){
        
        BankNo=@"303100000006";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"中国民生银行"]){
        
        BankNo=@"305100000013";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"中国邮政储蓄银行"]){
        
        BankNo=@"403100000004";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"交通银行"]){
        
        BankNo=@"301290000007";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"中信银行"]){
        
        BankNo=@"302100011000";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"华夏银行"]){
        
        BankNo=@"304100040000";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"平安银行"]){
        
        BankNo=@"307584007998";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"招商银行"]){
        
        BankNo=@"308584000013";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"兴业银行"]){
        
        BankNo=@"309391000011";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"广发银行"]){
        
        BankNo=@"306581000003";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"上海浦东发展银行"]){
        
        BankNo=@"310290000013";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"北京银行"]){
        
        BankNo=@"313100000013";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"天津银行"]){
        
        BankNo=@"313110000017";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"河北银行"]){
        
        BankNo=@"313121006888";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"邢台银行"]){
        
        BankNo=@"313131000016";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"承德银行"]){
        
        BankNo=@"313141052422";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"沧州银行"]){
        
        BankNo=@"313143005157";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"晋商银行"]){
        
        BankNo=@"313161000017";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"内蒙古银行"]){
        
        BankNo=@"313191000011";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"包商银行"]){
        
        BankNo=@"313192000013";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"鄂尔多斯银行"]){
        
        BankNo=@"313205057830";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"大连银行"]){
        
        BankNo=@"313222080002";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"锦州银行"]){
        
        BankNo=@"313227000012";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"葫芦岛银行"]){
        
        BankNo=@"313227600018";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"营口银行"]){
        
        BankNo=@"313228000276";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"阜新银行"]){
        
        BankNo=@"313229000008";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"吉林银行"]){
        
        BankNo=@"313241066661";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"哈尔滨银行"]){
        
        BankNo=@"313261000018";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"龙江银行"]){
        
        BankNo=@"313261099913";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"上海银行"]){
        
        BankNo=@"313290000017";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"南京银行"]){
        
        BankNo=@"313301008887";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"江苏银行"]){
        
        BankNo=@"313301099999";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"苏州银行"]){
        
        BankNo=@"313305066661";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"杭州银行"]){
        
        BankNo=@"313331000014";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"宁波银行"]){
        
        BankNo=@"313332082914";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"温州银行"]){
        
        BankNo=@"313333007331";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"湖州银行"]){
        
        BankNo=@"313336071575";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"绍兴银行"]){
        
        BankNo=@"313337009004";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"台州银行"]){
        
        BankNo=@"313345001665";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"福建海峡银行"]){
        
        BankNo=@"313391080007";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"厦门银行"]){
        
        BankNo=@"313393080005";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"南昌银行"]){
        
        BankNo=@"313421087506";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"赣州银行"]){
        
        BankNo=@"313428076517";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"上饶银行"]){
        
        BankNo=@"313433076801";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"青岛银行"]){
        
        BankNo=@"313452060150";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"齐商银行"]){
        
        BankNo=@"313453001017";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"烟台银行"]){
        
        BankNo=@"313456000108";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"潍坊银行"]){
        
        BankNo=@"313458000013";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"济宁银行"]){
        
        BankNo=@"313461000012";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"莱商银行"]){
        
        BankNo=@"313463400019";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"德州银行"]){
        
        BankNo=@"313468000015";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"临商银行"]){
        
        BankNo=@"313473070018";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"日照银行"]){
        
        BankNo=@"313473200011";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"郑州银行"]){
        
        BankNo=@"313491000232";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"洛阳银行"]){
        
        BankNo=@"313493080539";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"汉口银行"]){
        
        BankNo=@"313521000011";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"长沙银行"]){
        
        BankNo=@"313851000018";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"广州银行"]){
        
        BankNo=@"313581003284";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"东莞银行"]){
        
        BankNo=@"313602088017";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"广西北部湾银行"]){
        
        BankNo=@"313611001018";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"柳州银行"]){
        
        BankNo=@"313614000012";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"重庆银行"]){
        
        BankNo=@"313653000013";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"德阳银行"]){
        
        BankNo=@"313658000014";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"富滇银行"]){
        
        BankNo=@"313731010015";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"兰州银行"]){
        
        BankNo=@"313821001016";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"青海银行"]){
        
        BankNo=@"313851000018";
        
        _number=BankNo;
    }
    else if ([resultString isEqualToString:@"宁夏银行"]){
        
        BankNo=@"313871000007";
        
        _number=BankNo;
    }
    else if ([resultString isEqualToString:@"昆仑银行"]){
        
        BankNo=@"313882000012";
        
        _number=BankNo;
    }
    else if ([resultString isEqualToString:@"恒丰银行"]){
        
        BankNo=@"315456000105";
        
        _number=BankNo;
    }
    else if ([resultString isEqualToString:@"浙商银行"]){
        
        BankNo=@"316331000018";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"渤海银行"]){
        
        BankNo=@"318110000014";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"徽商银行"]){
        
        BankNo=@"319361000013";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"企业银行"]){
        
        BankNo=@"595100000007";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"青海银行"]){
        
        BankNo=@"597100000014";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"韩亚银行"]){
        
        BankNo=@"313851000018";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"宁波鄞州农村合作银行"]){
        
        BankNo=@"402332010004";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"福建省农村信用社"]){
        
        BankNo=@"402391000068";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"湖北省农村信用社"]){
        
        BankNo=@"402521000032";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"海南省农村信用社"]){
        
        BankNo=@"402641000014";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"张家口市商业银行"]){
        
        BankNo=@"313338707013";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"浙江泰隆商业银行"]){
        
        BankNo=@"313345010019";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"浙江民泰商业银行"]){
        
        BankNo=@"313345400010";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"泰安市商业银行"]){
        
        BankNo=@"313463000993";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"威海市商业银行"]){
        
        BankNo=@"313465000010";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"开封市商业银行"]){
        
        BankNo=@"313492070005";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"南阳市商业银行"]){
        
        BankNo=@"313513080408";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"攀枝花市商业银行"]){
        
        BankNo=@"313656000019";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"绵阳市商业银行"]){
        
        BankNo=@"313659000016";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"乌鲁木齐市商业银行"]){
        
        BankNo=@"313881000002";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"吴江农村商业银行"]){
        
        BankNo=@"314305400015";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"江苏常熟农村商业银行"]){
        
        BankNo=@"314305506621";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"广州农村商业银行"]){
        
        BankNo=@"314581000011";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"重庆农村商业银行"]){
        
        BankNo=@"314653000011";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"北京农村商业银行"]){
        
        BankNo=@"402100000018";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"深圳农村商业银行"]){
        
        BankNo=@"402584009991";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"东莞农村商业银行"]){
        
        BankNo=@"402602000018";
        
        _number=BankNo;
    }else if ([resultString isEqualToString:@"宁夏黄河农村商业银行"]){
        
        BankNo=@"402871099996";
        
        _number=BankNo;
    }
    
    
    
    
}
#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_cell.addPayCardTF == textField)
    {
        
        return [UITextField bankNumberFormatTextField:_cell.addPayCardTF shouldChangeCharactersInRange:range replacementString:string];
        
    }else{
        
        
        return YES;
    }
}

////键盘显示事件
//- (void) keyboardWillShow:(NSNotification *)notification andOtherTextField:(UITextField *)textField{
//      NSLog(@"kkkkkk==%@",notification.userInfo );
//    
//    //获取键盘高度，在不同设备上，以及中英文下是不同的
//    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
//    
//    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
//    CGFloat offset = (self.view.frame.origin.y+self.view.frame.size.height) - (self.view.frame.size.height - kbHeight);
//    
//    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
//    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    
//    if(offset > 0) {
//        [UIView animateWithDuration:duration animations:^{
//            self.view.frame = CGRectMake(0.0f, -80, self.view.frame.size.width, self.view.frame.size.height);
//        }];
//    }
//    
//    
//    
//}
//
/////键盘消失事件
//- (void) keyboardWillHide:(NSNotification *)notify {
//    // 键盘动画时间
//    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    //视图下沉恢复原状
//    [UIView animateWithDuration:duration animations:^{
//        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    }];
//    
//   
//}

- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    __weak AddMyPayCardViewController *weakSelf = self;
#pragma explain - 全自动键盘弹出/收起处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
#pragma explain - use animateWhenKeyboardAppearBlock, animateWhenKeyboardAppearAutomaticAnimBlock will be invalid.
//    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
//        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.inputViewBorderView, weakSelf.secondTextField, weakSelf.thirdTextField, nil];
//    }];
    /*  or
     [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
     [keyboardUtil adaptiveViewHandleWithAdaptiveView:weakSelf.inputViewBorderView, weakSelf.secondTextField, weakSelf.thirdTextField, nil];
     }];
     */
    
    
#pragma explain - 自定义键盘弹出处理(如配置，全自动键盘处理则失效)
#pragma explain - use animateWhenKeyboardAppearAutomaticAnimBlock, animateWhenKeyboardAppearBlock must be nil.
    /*
     [_keyboardUtil setAnimateWhenKeyboardAppearBlock:^(int appearPostIndex, CGRect keyboardRect, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement) {
     NSLog(@"\n\n键盘弹出来第 %d 次了~  高度比上一次增加了%0.f  当前高度是:%0.f"  , appearPostIndex, keyboardHeightIncrement, keyboardHeight);
     //do something
     }];
     */
    
#pragma explain - 自定义键盘收起处理(如不配置，则默认启动自动收起处理)
#pragma explain - if not configure this Block, automatically itself.
    /*
     [_keyboardUtil setAnimateWhenKeyboardDisappearBlock:^(CGFloat keyboardHeight) {
     NSLog(@"\n\n键盘在收起来~  上次高度为:+%f", keyboardHeight);
     //do something
     }];
     */
    
#pragma explain - 获取键盘信息
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
        NSLog(@"\n\n拿到键盘信息 和 ZYKeyboardUtil对象");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
