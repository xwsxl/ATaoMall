//
//  FilloutRefundLogisticVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/6.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "FilloutRefundLogisticVC.h"

#import "XLRedNaviView.h"


@interface FilloutRefundLogisticVC ()<XLRedNaviViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView *_scoll;
    UIView *proofView;

    UITextField *companeyTF;
    UITextField *logisticNumTF;
    UITextField *phoneNumTF;
    UITextField *refundDescTF;

    CGFloat height;
    NSInteger imgcount;
    UIImageView *ImgView;
    NSData *imageData;

    WKProgressHUD *hud;

}
@property (nonatomic,strong)NSMutableArray *imgArr;
@property (nonatomic,strong)NSMutableArray *imgNameArr;
@end

@implementation FilloutRefundLogisticVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}


/*******************************************************      控制器生命周期       ******************************************************/

/*******************************************************      数据请求       ******************************************************/
/*****
 *
 *  Description 上传图片数据
 *
 ******/
- (void)upLoadImage{
    /*
     <!-- APP 申请退款,提交退款订单  -->

     sigen            // 用户信息
     returns_batchid        // 退货退款批次号
     company            // 物流公司
     logisticnumber        // 物流单号
     phone            // 联系电话
     illustrate        // 退款说明

     user_image1        // 图片1
     user_image2        // 图片2
     user_image3        // 图片3
     */

    ASIFormDataRequest * _requestUpLoad= [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@buyersSubmitLogistics_mob.shtml",URL_Str]]];



    _requestUpLoad.delegate = self;


    NSString *imgName = @"image.jpg";
    NSString *key=@"";
  /*  String returns_batchid = request.getParameter("returns_batchid");
    // 物流公司
    String company = request.getParameter("company");
    //物流单号
    String logisticnumber = request.getParameter("logisticnumber");
    //联系电话
    String phone = request.getParameter("phone");
    //退款说明
    String illustrate = request.getParameter("illustrate");
    //图片
    DynaValidatorForm dvf = (DynaValidatorForm) form;
    FormFile image1 = (FormFile) dvf.get("user_image1");
    FormFile image2 = (FormFile) dvf.get("user_image2");
    FormFile image3 = (FormFile) dvf.get("user_image3");*/
    [_requestUpLoad addPostValue:[kUserDefaults objectForKey:@"sigen"] forKey:@"sigen"];
    [_requestUpLoad addPostValue:companeyTF.text forKey:@"company"];
    [_requestUpLoad addPostValue:logisticNumTF.text forKey:@"logisticnumber"];
    [_requestUpLoad addPostValue:self.DataModel.batchid forKey:@"returns_batchid"];
    [_requestUpLoad addPostValue:phoneNumTF.text forKey:@"phone"];
    [_requestUpLoad addPostValue:refundDescTF.text forKey:@"illustrate"];
    for (int i=0; i<_imgNameArr.count; i++) {
        imgName=_imgNameArr[i];
        if (i==0) {
            key=@"user_image1";
        }else if(i==1)
        {
            key=@"user_image2";
        }
        else if (i==2)
        {
            key=@"user_image3";
        }
        [_requestUpLoad addFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imgName]  forKey:key];
    }
    YLog(@"%@",phoneNumTF.text);
 NSLog(@"====_requestUpLoadh====%@",_requestUpLoad);
    [_requestUpLoad startAsynchronous];




}
/*****
 *
 *  Description 上传图片成功
 *
 ******/
- (void)requestFinished:(ASIHTTPRequest *)request{
    [hud dismiss:YES];
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
            [KNotificationCenter postNotificationName:@"wuliutianxie" object:nil ];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [UIAlertTools showAlertWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",dic[@"message"]] cancelTitle:@"确认" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {

            }];
        }
    }
}
/*****
 *
 *  Description 开始上传图片
 *
 ******/
- (void)requestStarted:(ASIHTTPRequest *)request{
   hud=[WKProgressHUD showInView:[UIApplication sharedApplication].keyWindow withText:@"" animated:YES];
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
    [hud dismiss:YES];
    [UIAlertTools showAlertWithTitle:@"提示" message:request.responseString cancelTitle:@"确认" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {

    }];
}

/*******************************************************      初始化视图       ******************************************************/

-(void)setUI
{
    [self initNavi];
    [self initCenterView];
    [self initbottomView];
}

-(void)initbottomView
{
    UIButton *commitBut=[UIButton buttonWithType:UIButtonTypeCustom];
    commitBut.frame=CGRectMake(0, kScreenHeight-Height(49)-KSafeAreaBottomHeight, kScreenWidth, Height(49));
    [commitBut setTitle:@"提交" forState:UIControlStateNormal];
    [commitBut setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [commitBut setBackgroundColor:RGB(255, 52, 90)];
    commitBut.titleLabel.font=KNSFONTM(15);
    [commitBut addTarget:self action:@selector(commitButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBut];
}

-(void)initCenterView
{

    _scoll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight-Height(49)-KSafeAreaBottomHeight)];
    _scoll.backgroundColor=RGB(244, 244, 244);
    _scoll.showsVerticalScrollIndicator=NO;
    _scoll.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:_scoll];

    UIView *companyView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (13+Height(40))*2)];
    companyView.backgroundColor=[UIColor whiteColor];
    [_scoll addSubview:companyView];
    height+=companyView.frame.size.height;
    height+=Height(10);

    UILabel *companyLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), Height(20), 65, 13)];
    companyLab.font=KNSFONT(13);
    companyLab.textColor=RGB(51, 51, 51);
    companyLab.text=@"物流公司:";
    [companyView addSubview:companyLab];

    companeyTF =[[UITextField alloc] initWithFrame:CGRectMake(Width(23)+65, Height(20), kScreenWidth-Width(38)-65, 13)];
    companeyTF.placeholder=@"请填写物流公司";
    companeyTF.font=KNSFONT(13);
    [companyView addSubview:companeyTF];

    UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 12+Height(40), kScreenWidth, 1)];
    [lineView setImage:KImage(@"分割线-拷贝")];
    [companyView addSubview:lineView];

    UILabel *logisticNumLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), 13+Height(40)+Height(20), 65, 13)];
    logisticNumLab.font=KNSFONT(13);
    logisticNumLab.textColor=RGB(51, 51, 51);
    logisticNumLab.text=@"物流单号:";
    [companyView addSubview:logisticNumLab];

    logisticNumTF =[[UITextField alloc] initWithFrame:CGRectMake(Width(23)+65, 13+Height(40)+Height(20), kScreenWidth-Width(38)-65, 13)];
    logisticNumTF.placeholder=@"请填写物流单号";
    logisticNumTF.font=KNSFONT(13);
    [companyView addSubview:logisticNumTF];



    UIView *phoneView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, 13+Height(40))];
    phoneView.backgroundColor=[UIColor whiteColor];
    [_scoll addSubview:phoneView];
    height+=phoneView.frame.size.height;
    height+=Height(10);

    UILabel *phoneLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), Height(20), 65, 13)];
    phoneLab.font=KNSFONT(13);
    phoneLab.textColor=RGB(51, 51, 51);
    phoneLab.text=@"联系电话:";
    [phoneView addSubview:phoneLab];

    phoneNumTF =[[UITextField alloc] initWithFrame:CGRectMake(Width(23)+65, Height(20), kScreenWidth-Width(38)-65, 13)];
    phoneNumTF.placeholder=@"请填写联系电话";
    phoneNumTF.font=KNSFONT(13);
    [phoneView addSubview:phoneNumTF];



    UIView *refundDescView=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, 13+Height(40))];
    refundDescView.backgroundColor=[UIColor whiteColor];
    [_scoll addSubview:refundDescView];
    height+=refundDescView.frame.size.height;
    height+=Height(10);

    UILabel *refundDescLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), Height(20), 65, 13)];
    refundDescLab.font=KNSFONT(13);
    refundDescLab.textColor=RGB(51, 51, 51);
    refundDescLab.text=@"退款说明:";
    [refundDescView addSubview:refundDescLab];

    refundDescTF =[[UITextField alloc] initWithFrame:CGRectMake(Width(23)+65, Height(20), kScreenWidth-Width(38)-65, 13)];
    refundDescTF.placeholder=@"选填";
    refundDescTF.font=KNSFONT(13);
    [refundDescView addSubview:refundDescTF];

    [self setProofView];
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
        [proofView addSubview:IV];

        UIImageView *IV2=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        [IV2 setImage:self.imgArr[i]];
        [IV addSubview:IV2];

        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        [but setFrame:CGRectMake(40, 0, 10, 10)];
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


-(void)initNavi
{
    XLRedNaviView *navi=[[XLRedNaviView alloc] initWithMessage:@"填写退货物流" ImageName:@""];
    navi.delegate=self;
    [self.view addSubview:navi];
}

-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/

//提交
-(void)commitButClick:(UIButton *)sender
{
    if ([companeyTF.text isEqualToString:@""]) {
        [UIAlertTools showAlertWithTitle:@"" message:@"请填写物流公司信息" cancelTitle:@"确认" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {

        }];
    }else if ([logisticNumTF.text isEqualToString:@""])
    {
        [UIAlertTools showAlertWithTitle:@"" message:@"请填写物流单号信息" cancelTitle:@"确认" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {

    }];

    }else if ([phoneNumTF.text isEqualToString:@""])
    {
        [UIAlertTools showAlertWithTitle:@"" message:@"请填写联系方式信息" cancelTitle:@"确认" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {

        }];
    }else if(![phoneNumTF.text phoneNumberIsCorrect])
    {
        [UIAlertTools showAlertWithTitle:@"" message:@"请填写正确的联系号码" cancelTitle:@"确认" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {

        }];
    }
    else
    {
        [self upLoadImage];
    }
}
//删除凭证
-(void)deleteImg:(UIButton *)sender
{
    [_imgArr removeObjectAtIndex:sender.tag-1000];
     [_imgNameArr removeObjectAtIndex:sender.tag-1000];
    [self setProofView];
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

@end
