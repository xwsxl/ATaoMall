//
//  PersonalShoppingReplyRefundVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/11/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalShoppingReplyRefundVC.h"
#import "PersonalAddRefundShoppingVC.h"
#import "PersonalShoppingRefundDanDetailVC.h"
#import "PersonalRefundDanVC.h"
#import "PersonalAllDanVC.h"

#import "XLRedNaviView.h"
#import "PersonalShoppingRefundView.h"

#import "PersonalDanCheckPhotoVC.h"

@interface PersonalShoppingReplyRefundVC ()<XLRedNaviViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PersonalAddRefundShoppingVCDelegate,UITextViewDelegate>
{
    UIScrollView *_scoll;
    UILabel *selectLab;

    UIView *proofView;
    UIView *shoppingView;
    UIView *refundNumberView;
    UIButton *AddBut;

    CGFloat height;
    NSInteger imgcount;
    UIImageView *ImgView;
    NSData *imageData;
    NSString *refundstr;


    UITextView *refundDescTF;
    UIAlertController *alertVC;
    UIButton *deleteBut;
    UILabel *placeholdLab;

}
@property (nonatomic,strong)NSMutableArray *imgArr;
@property (nonatomic,strong)NSMutableArray *imgNameArr;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,assign)NSInteger refundTotalTime;

@end

@implementation PersonalShoppingReplyRefundVC

/*******************************************************      控制器生命周期       ******************************************************/

- (void)viewDidLoad {

    [super viewDidLoad];

}

/*******************************************************      数据请求       ******************************************************/
-(void)setDataModel:(XLShoppingModel *)dataModel AndRefundType:(NSString *)refundType andRefundTime:(NSInteger)refundTotalTime andQurtAllDan:(BOOL)qurtAllDan
{
    self.dataModel=dataModel;
    self.refundType=refundType;
    self.refundTotalTime=refundTotalTime;
    self.QurtAllDan=qurtAllDan;
    [self setUI];
}
/*****
 *
 *  Description 上传图片数据
 *
 ******/
- (void)upLoadImage{
    /*
     <!-- APP 申请退款,提交退款订单  -->

     /submitRefundOrder_mob.shtml

     入参数：

     sigen            // 用户信息
     status        // 退款类别    0:退款中    1:退货退款  2:仅退款
     ids            // 退款商品订单ID组  (例: 1_2_3)
     order_batchid         // 订单批次号
     reason            // 退款原因
     illustrate        // 退款说明

     uploadvoucher            // 图片1
     uploadvoucher_two        // 图片2
     uploadvoucher_three        // 图片3
     */

    ASIFormDataRequest * _requestUpLoad= [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@submitRefundOrder_mob.shtml",URL_Str]]];

    NSLog(@"====_requestUpLoadh====%@",_requestUpLoad);

    _requestUpLoad.delegate = self;


    NSString *imgName = @"image.jpg";
    NSString *key=@"";
    NSString *ids=@"";
    for (XLShoppingModel *model in _dataArr) {
        ids=[ids stringByAppendingString:model.ID];
        ids=[ids stringByAppendingString:@"_"];
    }
    if (_dataArr.count>1) {
        ids=[ids substringToIndex:ids.length-1];
    }
    [_requestUpLoad addPostValue:[kUserDefaults objectForKey:@"sigen"] forKey:@"sigen"];
    [_requestUpLoad addPostValue:self.refundType forKey:@"status"];
    [_requestUpLoad addPostValue:ids forKey:@"ids"];
    [_requestUpLoad addPostValue:self.dataModel.order_batchid forKey:@"order_batchid"];
    [_requestUpLoad addPostValue:selectLab.text forKey:@"reason"];
    [_requestUpLoad addPostValue:refundDescTF.text forKey:@"illustrate"];
    for (int i=0; i<_imgNameArr.count; i++) {
        imgName=_imgNameArr[i];
        YLog(@"%@",imgName);
        if (i==0) {
            key=@"uploadvoucher";
        }else if(i==1)
        {
            key=@"uploadvoucher_two";
        }
        else if (i==2)
        {
            key=@"uploadvoucher_three";
        }
         [_requestUpLoad addFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imgName]  forKey:key];
    }


    [_requestUpLoad startAsynchronous];




}
/*****
 *
 *  Description 上传图片成功
 *
 ******/
- (void)requestFinished:(ASIHTTPRequest *)request{

    NSLog(@"request.response=%@",request.responseString);
    NSString *codeKey = [SecretCodeTool getDesCodeKey:request.responseString];
    NSString *content = [SecretCodeTool getReallyDesCodeString:request.responseString];

    if (codeKey && content) {
        NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
        xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

        NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        YLog(@"dic=%@",dic);
        if ([dic[@"status"] isEqualToString:@"10000"]) {

            if (self.QurtAllDan) {
                PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];

                NSString *orderno=@"";
                for (XLShoppingModel *model in _dataArr) {
                    orderno=[orderno stringByAppendingString:model.order_no];
                    orderno=[orderno stringByAppendingString:@"_"];
                }

                orderno=[orderno substringToIndex:orderno.length-1];
                self.dataModel.order_no=orderno;
                VC.dataModel=self.dataModel;

                PersonalAllDanVC *vc=[[PersonalAllDanVC alloc] init];
                [vc selectedDingDanType:@"0" AndIndexType:0];
                self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,VC];
                [self.navigationController pushViewController:VC animated:NO];
            }else
            {
           PersonalShoppingRefundDanDetailVC *VC=[[PersonalShoppingRefundDanDetailVC alloc] init];
            NSString *orderno=@"";
            for (XLShoppingModel *model in _dataArr) {
                orderno=[orderno stringByAppendingString:model.order_no];
                orderno=[orderno stringByAppendingString:@"_"];
            }

            orderno=[orderno substringToIndex:orderno.length-1];
            self.dataModel.order_no=orderno;
            VC.dataModel=self.dataModel;

            PersonalRefundDanVC *vc=[[PersonalRefundDanVC alloc] init];

            self.navigationController.viewControllers=@[self.navigationController.viewControllers.firstObject,vc,VC];
            [self.navigationController pushViewController:VC animated:NO];
            }
        }
        else
        {
            [TrainToast showWithText:[NSString stringWithFormat:@"%@",dic[@"message"]] duration:2.0];
        }
    }
}
/*****
 *
 *  Description 开始上传图片
 *
 ******/
- (void)requestStarted:(ASIHTTPRequest *)request{

    //NSLog(@"开始上传");
}
/*****
 *
 *  Description 上传失败
 *
 ******/
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"request.response=%@",request.responseString);

    [UIAlertTools showAlertWithTitle:@"提示" message:request.responseString cancelTitle:@"确认" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {

    }];
}





/*******************************************************      初始化视图       ******************************************************/
//商品详情
-(void)setShoppingView
{
    if (!shoppingView) {
        shoppingView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreen_Width, Height(30)+70)];
        height+=shoppingView.frame.size.height;
        [_scoll addSubview:shoppingView];
    }
    [shoppingView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];




    if (self.dataArr.count==1) {

        PersonalShoppingRefundView *refundDetailView=[[PersonalShoppingRefundView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, Height(30)+70) AndShoppingName:_dataModel.name scopimgName:_dataModel.scopeimg attributeStr:_dataModel.attribute_str];
        [shoppingView addSubview:refundDetailView];
    }
    else
    {
         UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, shoppingView.frame.size.width, shoppingView.frame.size.height)];
        [shoppingView addSubview:scroll];
        for (int i=0; i<_dataArr.count; i++) {
            XLShoppingModel *model=_dataArr[i];

            UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(15)+90*i, Height(15), 70, 70)];
            [IV sd_setImageWithURL:KNSURL(model.scopeimg)];
            [scroll addSubview:IV];
        }
        scroll.showsVerticalScrollIndicator=NO;
        scroll.showsHorizontalScrollIndicator=NO;
        scroll.contentSize=CGSizeMake(Width(30)+90*_dataArr.count-20, Height(30)+30);

    }


}

//退款金额
-(void)setRefundMoneyView
{
    //退款金额
    CGFloat paymoney=0;
    CGFloat payIntergral=0;
    CGFloat refundMoney=0;
    CGFloat freight=0;
    for (XLShoppingModel *model in self.dataArr) {
        paymoney+=[model.paymoney floatValue];
        payIntergral+=[model.payinteger floatValue];

        if ([_refundType isEqualToString:@"0"]) {
            refundMoney+=[model.paymoney floatValue];
            freight+=[model.totalfreight floatValue];
        }else
        {
            refundMoney+=[model.paymoney floatValue]-[model.totalfreight floatValue];
        }
        YLog(@"%@,%@,%@,%.2f,%@",model.paymoney,model.payinteger,model.totalfreight,refundMoney,_refundType);
    }
    if (!refundNumberView) {
    refundNumberView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreen_Width, Height(20)+Height(20)+13)];
    [refundNumberView setBackgroundColor:[UIColor whiteColor]];
    [_scoll addSubview:refundNumberView];
    height+=refundNumberView.frame.size.height;
    height +=Height(20)+11;
    }
    [refundNumberView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *refundMoneyLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), Height(20), kScreen_Width, 13)];
    [refundMoneyLab setFont:KNSFONT(13)];
    [refundMoneyLab setTextColor:RGB(51, 51, 51)];
    NSString *payStr=[NSString stringWithFormat:@"￥%.2f+%.2f积分",refundMoney,payIntergral];
    [refundMoneyLab setText:[NSString stringWithFormat:@"退款金额: %@",payStr]];

    // 创建对象.
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:refundMoneyLab.text];
    //
    NSRange range = [refundMoneyLab.text rangeOfString:payStr];

    [mAttStri addAttribute:NSForegroundColorAttributeName value:RGB(255, 93, 94) range:range];
    refundMoneyLab.attributedText=mAttStri;


    [refundNumberView addSubview:refundMoneyLab];

   UILabel  *lab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), Height(20)+Height(20)+13+Height(10), kScreen_Width-Width(30), 11)];
    lab.font=KNSFONTM(11);
    lab.textColor=RGB(153, 153, 153);
    // lab.text=[];
    lab.text=[NSString stringWithFormat:@"最多￥%.2f+%.2f积分，含发货邮费￥%.2f",refundMoney,payIntergral,freight];
    [refundNumberView addSubview:lab];

}

//初始化视图
-(void)setUI
{
    [self initNavi];

    height=0;
//最后一次退款蓝色提示视图
    refundstr=@"";
    if ([_refundType isEqualToString:@"1"]) {
        refundstr=@"退款退货";
    }else
    {
        refundstr=@"退款";
    }
    _scoll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreen_Height-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight-49)];
    [_scoll setBackgroundColor:RGB(244, 244, 244)];
    [self.view addSubview:_scoll];

    if (self.refundTotalTime==2) {
        UIView *blueTipsView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreen_Width, 12+Height(20))];
        [blueTipsView setBackgroundColor:RGB(63, 139, 253)];
        [_scoll addSubview:blueTipsView];
        height +=blueTipsView.frame.size.height;

        UIImageView *tipsIV=[[UIImageView alloc]initWithFrame:CGRectMake(Width(15), Height(9), 14, 14)];
        [tipsIV setImage:KImage(@"icon_tip-grey-dingdan")];
        [blueTipsView addSubview:tipsIV];

        UILabel *tipsLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15)+14+Width(5), Height(10), kScreen_Width-Width(35)-14, 12)];
        [tipsLab setFont:KNSFONT(12)];
        [tipsLab setTextColor:[UIColor whiteColor]];
        [tipsLab setText:[NSString stringWithFormat:@"这是您最后一次申请%@,如果卖家还是拒绝,则无法再次操作",refundstr]];
        [blueTipsView addSubview:tipsLab];
    }

//退款商品
    UIView *refundTitleView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreen_Width, Height(30)+14+1)];
    [refundTitleView setBackgroundColor:[UIColor whiteColor]];
    [_scoll addSubview:refundTitleView];
    height+=refundTitleView.frame.size.height;


    UILabel *refundTitleLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), Height(15), 120, 14)];
    [refundTitleLab setTextColor:RGB(51, 51, 51)];
    [refundTitleLab setText:[NSString stringWithFormat:@"退款商品"]];
    [refundTitleLab setFont:KNSFONT(14)];
    [refundTitleView addSubview:refundTitleLab];

    AddBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [AddBut setFrame:CGRectMake(kScreen_Width-Width(15)-16, Height(15), 16, 16)];
    [AddBut setImage:KImage(@"icon_add") forState:UIControlStateNormal];
    [AddBut addTarget:self action:@selector(addShopping:) forControlEvents:UIControlEventTouchUpInside];
    AddBut.hidden=YES;
    [refundTitleView addSubview:AddBut];
    if (![_dataModel.goodsCount isEqualToString:@"1"]) {
        AddBut.hidden=NO;
    }

    UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, Height(30)+14, kScreen_Width, 1)];
    [lineView setImage:KImage(@"分割线-拷贝")];
    [refundTitleView addSubview:lineView];

//退款商品详情
    [self setShoppingView];

    height+=Height(10);

//退款原因
    UIButton *refundReasonBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [refundReasonBut setFrame:CGRectMake(0, height, kScreen_Width, Height(20)+13+Height(20))];
    [refundReasonBut setBackgroundColor:[UIColor whiteColor]];
    [_scoll addSubview:refundReasonBut];
    [refundReasonBut addTarget:self action:@selector(selectRefundReason:) forControlEvents:UIControlEventTouchUpInside];
    height+=refundReasonBut.frame.size.height;

    UILabel *refundReasonLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), Height(20), 120, 13)];
    [refundReasonLab setFont:KNSFONT(13)];
    [refundReasonLab setTextColor:RGB(51, 51, 51)];
    [refundReasonLab setText:[NSString stringWithFormat:@"%@原因",refundstr]];
    [refundReasonBut addSubview:refundReasonLab];

    selectLab=[[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width-Width(15)-8-Width(9)-120, Height(20), 120, 13)];
    [selectLab setFont:KNSFONT(13)];
    [selectLab setTextAlignment:NSTextAlignmentRight];
    [selectLab setTextColor:RGB(153, 153, 153)];
    [selectLab setText:@"请选择"];
    [refundReasonBut addSubview:selectLab];

    UIImageView *selectIV=[[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-Width(15)-8, Height(20), 8, 14)];
    [selectIV setImage:KImage(@"icon_more_dingdan")];
    [refundReasonBut addSubview:selectIV];

    UIImageView *fengeIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, Height(20)+13+Height(20)-1, kScreen_Width, 1)];
    [fengeIV setImage:KImage(@"分割线-拷贝")];
    [refundReasonBut addSubview:fengeIV];

    height+=Height(10);

//退款金额
    [self setRefundMoneyView];

//退款说明
    UIView *refundDescView=[[UIView alloc]initWithFrame:CGRectMake(0, height, kScreen_Width, Height(40)+13)];

    refundDescView.backgroundColor = [UIColor whiteColor];

    [_scoll addSubview:refundDescView];
    height+=refundDescView.frame.size.height;


    NSString *refundDescStr=[NSString stringWithFormat:@"%@说明:",refundstr];
    CGSize size=[refundDescStr sizeWithFont:KNSFONT(13) maxSize:CGSizeMake(kScreen_Width, 13)];

    UILabel * refundDescLab = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), Height(20), size.width, 13)];
    refundDescLab.font=KNSFONT(13);
    refundDescLab.textColor=RGB(51, 51, 51);
    refundDescLab.text=refundDescStr;
    [refundDescView addSubview:refundDescLab];

    refundDescTF=[[UITextView alloc] initWithFrame:CGRectMake(Width(15)+size.width+Width(5), Height(18), kScreen_Width-Width(20)-size.width-Width(15)-21, 17)];
    refundDescTF.delegate=self;
//    refundDescTF.placeholder=@"选填";
//   refundDescTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

//   [refundDescTF addTarget:self action:@selector(refundReasonTextChanged:) forControlEvents:UIControlEventEditingChanged];
    refundDescTF.font=KNSFONT(13);
    [refundDescView addSubview:refundDescTF];


    placeholdLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15)+size.width+Width(5), Height(20),30, 13)];
    placeholdLab.font=KNSFONT(13);

    placeholdLab.textColor=RGB(153, 153, 153);
    placeholdLab.text=@"选填";
    placeholdLab.hidden=NO;
    [refundDescView addSubview:placeholdLab];



    deleteBut=[UIButton buttonWithType:UIButtonTypeCustom];
    deleteBut.frame=CGRectMake(kScreenWidth-Width(20)-21, (Height(40)+13-21)/2.0, 21, 21);
    [deleteBut setImage:KImage(@"icon_delete_Dan") forState:UIControlStateNormal];
    [deleteBut addTarget:self action:@selector(deleteRefundDesc:) forControlEvents:UIControlEventTouchUpInside];
    deleteBut.hidden=YES;
    [refundDescView addSubview:deleteBut];

    UIImageView *fengeIV1=[[UIImageView alloc] initWithFrame:CGRectMake(0, Height(40)+13-1, kScreen_Width, 1)];
    [fengeIV1 setImage:KImage(@"分割线-拷贝")];
    [refundDescView addSubview:fengeIV1];

    height+=Height(10);
//上传凭证
    [self setProofView];

    [_scoll setContentSize:CGSizeMake(kScreen_Width, height)];
    UIButton *commitBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [commitBut setFrame:CGRectMake(0, kScreen_Height-49-KSafeAreaBottomHeight, kScreen_Width, 49)];
    UIImage *img=[UIImage imageWithImageView:CGRectMake(0, 0, kScreen_Width, KSafeAreaTopNaviHeight+Height(92)) StartColor:RGB(255, 52, 90) EndColor:RGB(255, 93, 94) startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, KSafeAreaTopNaviHeight+Height(92))];
    [commitBut setBackgroundImage:img forState:UIControlStateNormal];
    [commitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBut setTitle:@"提交" forState:UIControlStateNormal];

    [commitBut addTarget:self action:@selector(CommitButClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:commitBut];
}



-(void)setProofView
{
    if (!proofView) {
        proofView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreen_Width, 150)];
        [proofView setBackgroundColor:[UIColor whiteColor]];
        [_scoll addSubview:proofView];
        height+=proofView.frame.size.height;
    }else
    {
        [proofView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    UILabel *uploadProofLab= [[UILabel alloc]initWithFrame:CGRectMake(Width(15), Height(20), kScreen_Width, 13)];
    uploadProofLab.font=KNSFONT(13);
    uploadProofLab.textColor=RGB(51, 51, 51);
    uploadProofLab.text=@"上传凭证";
    [proofView addSubview:uploadProofLab];

    for (int i=0; i<self.imgArr.count; i++) {

        UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(15)+i*(50+Width(20)), Height(20)+Height(10)+13, 50, 50)];
        [IV setImage:KImage(@"kuang")];
        IV.userInteractionEnabled=YES;
        [proofView addSubview:IV];

        UIImageView *IV2=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        [IV2 setImage:self.imgArr[i]];
        [IV addSubview:IV2];

        UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame=CGRectMake(5, 5, 40, 40);
        but1.tag=100+i;
        [but1 addTarget:self action:@selector(checkPhotoButClick:) forControlEvents:UIControlEventTouchUpInside];
        [IV addSubview:but1];

        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake(42.5, -7.5, 15, 15)];
        [but setImage:KImage(@"button_delete") forState:UIControlStateNormal];
        [but addTarget:self action:@selector(deleteImg:) forControlEvents:UIControlEventTouchUpInside];
        but.tag=1000+i;
        [IV addSubview:but];
    }

    if (self.imgArr.count<3) {
        UIButton * uploadBut=[UIButton buttonWithType:UIButtonTypeCustom];
        uploadBut.frame=CGRectMake(Width(15)+self.imgArr.count*(50+Width(20)), Height(20)+Height(10)+13, 50, 50);
        [uploadBut setImage:KImage(@"kuang") forState:UIControlStateNormal];
        [uploadBut addTarget:self action:@selector(uploadPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [proofView addSubview:uploadBut];
        UIImageView *camaraIV=[[UIImageView alloc]initWithFrame:CGRectMake(19, 13, 14, 12)];
        camaraIV.image=[UIImage imageNamed:@"icon_photo"];
        [uploadBut addSubview:camaraIV];

        UILabel * photoNumberLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 29, 50, 11)];
        photoNumberLab.font=KNSFONT(11);
        photoNumberLab.textAlignment=NSTextAlignmentCenter;
        photoNumberLab.textColor=RGB(153, 153, 153);
        photoNumberLab.text=@"(最多3张)";
        [uploadBut addSubview:photoNumberLab];
    }

}

//导航栏
-(void)initNavi
{
    NSString *title=@"";
    if ([_refundType isEqualToString:@"1"]) {
        title=@"申请退款退货";
    }
    else if ([_refundType isEqualToString:@"2"])
    {
        title=@"申请仅退款";
    }else if([_refundType isEqualToString:@"0"])
    {
        title=@"申请退款";
    }
    XLRedNaviView *view=[[XLRedNaviView alloc] initWithMessage:title ImageName:@""];
    view.delegate=self;
    [self.view addSubview:view];

}
//

/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    placeholdLab.hidden=YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        placeholdLab.hidden=NO;
    }
}


-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length!=0) {
        deleteBut.hidden=NO;

    }else
    {
        deleteBut.hidden=YES;

    }
    NSSet *set=[NSSet setWithObjects:@"%",@"@",@"&",@"*",@"{",@"}",@"[",@"]",@"\n",@"(",@")",nil];
    for (int i=0; i<textView.text.length; i++) {
        NSString *str=[textView.text substringWithRange:NSMakeRange(i, 1)];
        if ([set containsObject:str]) {
            [TrainToast showWithText:[NSString stringWithFormat:@"不能包含特殊字符%@",str] duration:2.0];
            textView.text=[textView.text stringByReplacingOccurrencesOfString:str withString:@""];
        }
    }

}

-(void)deleteRefundDesc:(UIButton *)sender
{
    refundDescTF.text=@"";
    deleteBut.hidden=YES;
}

//
-(void)DidSelectShoppings:(NSArray *)shoppingArr andHiddenAddBut:(BOOL )ishide
{
    [AddBut setImage:KImage(@"xl-编辑") forState:UIControlStateNormal];
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:shoppingArr];
    [self setShoppingView];
    [self setRefundMoneyView];
}

//
-(void)addShopping:(UIButton *)sender
{
    PersonalAddRefundShoppingVC *VC=[[PersonalAddRefundShoppingVC alloc] init];
    NSString *ids=@"";
    for (XLShoppingModel *model in _dataArr) {
        ids=[ids stringByAppendingString:model.ID];
        ids=[ids stringByAppendingString:@"_"];
    }
    if (_dataArr.count>1) {
        ids=[ids substringToIndex:ids.length-1];
    }
    YLog(@"%@",self.dataModel.order_batchid);
    [VC setOrderBatchid:self.dataModel.order_batchid Status:self.refundType andIds:ids];
    VC.delegate=self;
    [self.navigationController pushViewController:VC animated:NO];
    YLog(@"添加商品");

}

//退款原因
-(void)selectRefundReason:(UIButton *)sender
{
    if ([_refundType isEqualToString:@"1"]) {

       alertVC=[UIAlertTools showAlertCntrollerWithViewController:self alertControllerStyle:UIAlertControllerStyleActionSheet title:nil message:nil CallBackBlock:^(NSInteger btnIndex) {
            NSArray *titleArr=@[@"商品质量问题",@"商家发错货",@"商品漏发/错发",@"收到商品破损",@"未按约定时间发货",@"其他"];
            [selectLab setText:titleArr[btnIndex]];
            [selectLab setNeedsUpdateConstraints];
            YLog(@"%ld",btnIndex);
        } cancelButtonTitle:@"" destructiveButtonTitle:@"" otherButtonTitles:@"商品质量问题",@"商家发错货",@"商品漏发/错发",@"收到商品破损",@"未按约定时间发货",@"其他", nil];
    }

    else if ([_refundType isEqualToString:@"2"]||[_refundType isEqualToString:@"0"])
    {
    alertVC =[UIAlertTools showAlertCntrollerWithViewController:self alertControllerStyle:UIAlertControllerStyleActionSheet title:nil message:nil CallBackBlock:^(NSInteger btnIndex) {
            NSArray *titleArr=@[@"协商一致退款",@"错拍/多拍/不想要",@"未按约定时间发货",@"其他"];
            [selectLab setText:titleArr[btnIndex]];
            [selectLab setNeedsUpdateConstraints];
            YLog(@"%ld",btnIndex);
        } cancelButtonTitle:@"" destructiveButtonTitle:@"" otherButtonTitles:@"协商一致退款",@"错拍/多拍/不想要",@"未按约定时间发货",@"其他", nil];
    }



    UIWindow *backView = alertVC.view.window;
    UIView *huiseView=[[UIView alloc] initWithFrame:kScreen_Bounds];
    huiseView.userInteractionEnabled=YES;
    [backView addSubview:huiseView];
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAlert)];
    [tap setNumberOfTapsRequired:1];
    tap.cancelsTouchesInView=NO;
    [huiseView addGestureRecognizer:tap];
    YLog(@"退款原因选择");


}

-(void)hideAlert
{

    YLog(@"hahahahah");

    [alertVC dismissViewControllerAnimated:YES completion:nil];


    UIWindow *backView = (UIWindow *)[UIApplication sharedApplication].windows.lastObject;

}


//删除凭证
-(void)deleteImg:(UIButton *)sender
{
    [_imgArr removeObjectAtIndex:sender.tag-1000];
    [_imgNameArr removeObjectAtIndex:sender.tag-1000];
    [self setProofView];
}

//确定提交
-(void)CommitButClick:(UIButton *)sender
{
    /*
    <!-- APP 申请退款,提交退款订单  -->

    /submitRefundOrder_mob.shtml

    入参数：

    sigen            // 用户信息
    status        // 退款类别    0:退款中    1:退货退款  2:仅退款
    ids            // 退款商品订单ID组  (例: 1_2_3)
    order_batchid         // 订单批次号
    reason            // 退款原因
    illustrate        // 退款说明

    uploadvoucher            // 图片1
    uploadvoucher_two        // 图片2
    uploadvoucher_three        // 图片3
  */
//判断数据
    if ([selectLab.text isEqualToString:@"请选择"]) {
        [UIAlertTools showAlertWithTitle:@"" message:@"请选择退款原因" cancelTitle:@"确定" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {

        }];
    }else
    {
    [self upLoadImage];
    }
    YLog(@"确定");
}

//上传凭证
-(void)uploadPhoto:(UIButton *)sender
{
    //创建UIAlertController是为了让用户去选择照片来源,拍照或者相册.
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:0];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;


        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];

    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {

        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;

        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action)
                                   {
                                       //这里可以不写代码
                                   }];
    [self presentViewController:alertController animated:YES completion:nil];

    //用来判断来源 Xcode中的模拟器是没有拍摄功能的,当用模拟器的时候我们不需要把拍照功能加速
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])

    {

        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        [alertController addAction:photoAction];

    }

    else
    {
        [alertController addAction:photoAction];
        [alertController addAction:cancelAction];
    }

    YLog(@"上传凭证");
}


-(void)refundReasonTextChanged:(UITextField *)TF
{

    if (TF.text.length!=0) {
        deleteBut.hidden=NO;
    }else
    {
        deleteBut.hidden=YES;
    }
    NSSet *set=[NSSet setWithObjects:@"%",@"@",@"&",@"*",@"{",@"}",@"[",@"]",@"\n",@"(",@")",nil];
    for (int i=0; i<TF.text.length; i++) {
        NSString *str=[TF.text substringWithRange:NSMakeRange(i, 1)];
        if ([set containsObject:str]) {
            [TrainToast showWithText:[NSString stringWithFormat:@"不能包含特殊字符%@",str] duration:2.0];
            TF.text=[TF.text stringByReplacingOccurrencesOfString:str withString:@""];
        }
    }

}

-(void)checkPhotoButClick:(UIButton *)sender
{


    NSString *title=@"";
    if ([_refundType isEqualToString:@"1"]) {
        title=@"申请退款退货";
    }
    else if ([_refundType isEqualToString:@"2"])
    {
        title=@"申请仅退款";
    }else if([_refundType isEqualToString:@"0"])
    {
        title=@"申请退款";
    }

    PersonalDanCheckPhotoVC *vc=[[PersonalDanCheckPhotoVC alloc] init];
    [vc setTitle:title andImgArr:self.imgArr selectIndex:sender.tag-100];
    [self.navigationController pushViewController:vc animated:NO];
}

/*******************************************************      协议方法       ******************************************************/
/*****
 *
 *  Description  info中保存着选择的图片信息，拍照完成选中也走这个方法
 *
 ******/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //UIImagePickerControllerOriginalImage; //原图
    //UIImagePickerControllerEditedImage;//裁剪的图
    //UIImagePickerControllerCropRect;//获取图片裁剪后 剩下的图
    if (!imgcount) {
        imgcount=0;
    }
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.imgArr addObject:image];
    NSLog(@"======image======%@======%@",image,info);

    NSString *imgName=[NSString stringWithFormat:@"image%ld.png",imgcount];
    imgcount++;
    [self.imgNameArr addObject:imgName];
    [self setProofView];

    [self saveImage:image withName:imgName];

    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imgName];


    NSLog(@"====fullPath====%@",fullPath);
    [picker dismissViewControllerAnimated:YES completion:^{

    }];




}
/*****
 *
 *  Description 没有选择图片直接取消走的这个方法
 *
 ******/
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消");
    [self dismissViewControllerAnimated:YES completion:^{}];
}
/*****
 *
 *  Description 把选择的图片数据保存到本地
 *
 ******/
- (void)saveImage:(UIImage *)img withName:(NSString *)imageName{

    imageData = UIImageJPEGRepresentation(img, 0.5);

    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];

    NSLog(@"=666===fullPath====%@",fullPath);
    NSFileManager *manager=[NSFileManager defaultManager];

    [manager createFileAtPath:fullPath contents:imageData attributes:nil];

}

//
-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:NO];
}
/*******************************************************      代码提取(多是复用代码)       ******************************************************/
-(NSMutableArray *)imgArr
{
    if (!_imgArr) {
        _imgArr=[NSMutableArray new];
    }
    return  _imgArr;
}

-(NSMutableArray *)imgNameArr
{
    if (!_imgNameArr) {
        _imgNameArr=[NSMutableArray new];
    }
    return _imgNameArr;
}
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr=[NSMutableArray new];
        [_dataArr addObject:self.dataModel];
    }
    return _dataArr;
}

@end
