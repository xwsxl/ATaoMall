//
//  XLPersonalAccountSuggestVC.m
//  aTaohMall
//
//  Created by Hawky on 2018/2/26.
//  Copyright © 2018年 ysy. All rights reserved.
//

#import "XLPersonalAccountSuggestVC.h"
#import "XLNaviVIew.h"

@interface XLPersonalAccountSuggestVC ()<XLNaviViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate>
{

    UIScrollView *_scroll;

    UIView *_feedBackView;
    UILabel *_placeHodleLab;
    UITextView *_feedBackTV;
    UILabel *_stringLengthLab;

    UIView *_photoView;

    UIButton *_commitBut;


    NSMutableArray *_PhotoMArr;

    NSInteger imgcount;
     NSData *imageData;
}
@property (nonatomic,strong)NSMutableArray *imgNameArr;
@end

@implementation XLPersonalAccountSuggestVC

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

    ASIFormDataRequest * _requestUpLoad= [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@userFeedback_mob.shtml",URL_Str]]];

    NSLog(@"====_requestUpLoadh====%@",_requestUpLoad);

    _requestUpLoad.delegate = self;


    NSString *imgName = @"image.jpg";
    NSString *key=@"";

    [_requestUpLoad addPostValue:[kUserDefaults objectForKey:@"sigen"] forKey:@"sigen"];
    [_requestUpLoad addPostValue:_feedBackTV.text forKey:@"content"];
    for (int i=0; i<_imgNameArr.count; i++) {
        imgName=_imgNameArr[i];
        YLog(@"%@",imgName);
        if (i==0) {
            key=@"feedback_img1";
        }else if(i==1)
        {
            key=@"feedback_img2";
        }
        else if (i==2)
        {
            key=@"feedback_img3";
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
            [TrainToast showWithText:@"提交成功" duration:2.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:NO];
            });
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


- (void)viewDidLoad {
    [super viewDidLoad];

    _PhotoMArr=[NSMutableArray new];
    XLNaviView *navi=[[XLNaviView alloc] initWithMessage:@"反馈" ImageName:nil];
    navi.delegate=self;
    [self.view addSubview:navi];

    _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight)];
    _scroll.backgroundColor=RGB(242, 242, 242);
    [self.view addSubview:_scroll];

    _feedBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 170)];
    _feedBackView.backgroundColor=[UIColor whiteColor];

    [_scroll addSubview:_feedBackView];

    _feedBackTV=[[UITextView alloc] initWithFrame:CGRectMake(Width(15), 8, kScreen_Width-Width(30), 124)];
    _feedBackTV.delegate=self;
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.01)];
    _feedBackTV.inputAccessoryView=customView;

    _feedBackTV.font=KNSFONT(14);
    [_feedBackView addSubview:_feedBackTV];

    _placeHodleLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), 15, kScreen_Width-Width(30), 14)];
    _placeHodleLab.font=KNSFONT(14);
    _placeHodleLab.textColor=RGB(155, 155, 155);
    _placeHodleLab.text=@"请尽可能详细描述您的问题或建议，不少于10字。";
    [_feedBackView addSubview:_placeHodleLab];

    _stringLengthLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 144, kScreen_Width-Width(15), 12)];
    _stringLengthLab.text=@"0/500";
    _stringLengthLab.font=KNSFONT(11);
    _stringLengthLab.textColor=RGB(102, 102, 102);
    _stringLengthLab.textAlignment=NSTextAlignmentRight;
    [_feedBackView addSubview:_stringLengthLab];

    _photoView=[[UIView alloc] initWithFrame:CGRectMake(0, 180, kScreen_Width, 110)];
    _photoView.backgroundColor=[UIColor whiteColor];
    [_scroll addSubview:_photoView];

    [self setPhotoView];

    _commitBut =[UIButton buttonWithType:UIButtonTypeCustom];
    _commitBut.frame=CGRectMake(Width(10), 320, kScreen_Width-Width(20), 44);
    _commitBut.userInteractionEnabled=NO;
    _commitBut.backgroundColor=RGBA(243, 73, 73,0.5);

    [_commitBut setTitle:@"提交" forState:UIControlStateNormal];
    [_commitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBut.titleLabel.font=KNSFONT(17);
    [_commitBut addTarget:self action:@selector(upLoadImage) forControlEvents:UIControlEventTouchUpInside];


    CALayer *layer = [CALayer layer];

    layer.frame = CGRectMake(Width(10), 320, kScreen_Width-Width(20), 44);

    layer.backgroundColor = RGBA(0, 0, 0,0.18).CGColor;

    layer.shadowOffset = CGSizeMake(5, 5);

    layer.shadowOpacity = 0.8;

    layer.cornerRadius = 22;
    [_scroll.layer addSublayer:layer];

    _commitBut.layer.cornerRadius=22;
//    _commitBut.layer.shadowColor=[UIColor blackColor].CGColor;
//    _commitBut.layer.shadowOffset =  CGSizeMake(5, 5);
//    _commitBut.layer.shadowOpacity = 0.7;

    [_scroll addSubview:_commitBut];

}


-(void)setPhotoView
{
    [_photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat width=Width(15);
    for (int i=0; i<_PhotoMArr.count; i++) {
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame= CGRectMake(width, 15, 80, 80);
        [but setImage:_PhotoMArr[i] forState:UIControlStateNormal];
        [_photoView addSubview:but];
        UIButton *delete=[UIButton buttonWithType:UIButtonTypeCustom];
        delete.frame=CGRectMake(65, -5, 20, 20);
        [delete setImage:KImage(@"btnClearCopy") forState:UIControlStateNormal];
        delete.tag=i+1000;
        [delete addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [but addSubview:delete];
        width+=80+15;
    }
    if (_PhotoMArr.count<3) {
        UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(width, 15, 80, 80);
        [but setBackgroundImage:KImage(@"kuang") forState:UIControlStateNormal];
        [_photoView addSubview:but];
        [but setImage:KImage(@"copy2") forState:UIControlStateNormal];
        [but setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        [but setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 10, 0)];
        [but setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 0, 23)];
        but.titleLabel.font=KNSFONT(11);
        [but setTitle:[NSString stringWithFormat:@"%lu/3",_PhotoMArr.count] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];

    }

}

-(void)addPhoto:(UIButton *)sender
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


}

-(void)deletePhoto:(UIButton *)sender
{
    [_PhotoMArr removeObjectAtIndex:sender.tag-1000];
    [self setPhotoView];

}


-(void)textViewDidChange:(UITextView *)textView
{
    _placeHodleLab.hidden=YES;

    _stringLengthLab.text=[NSString stringWithFormat:@"%lu/500",textView.text.length];
    if (textView.text.length>=500) {
        textView.text=[textView.text substringToIndex:500];
        _stringLengthLab.text=@"500/500";
    }

    if (textView.text.length<10) {
        _commitBut.userInteractionEnabled=NO;
        _commitBut.backgroundColor=RGBA(243, 73, 73,0.5);
    }else
    {
        _commitBut.backgroundColor = RGB(243, 73, 73);
        _commitBut.userInteractionEnabled = YES;
    }

}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _placeHodleLab.hidden=YES;
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        _placeHodleLab.hidden=NO;
    }else
    {
        _placeHodleLab.hidden=YES;
    }

}


-(void)QurtBtnClick
{
    if (_feedBackTV.text.length==0&&_PhotoMArr.count==0) {
    [self.navigationController popViewControllerAnimated:YES];
    }else
    {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"马上就填写完了， 确定要离开？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"我不填了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"继续填写" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }]];

    [self presentViewController:alert animated:YES completion:nil];
    }
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
    [_PhotoMArr addObject:image];
    NSLog(@"======image======%@======%@",image,info);

    NSString *imgName=[NSString stringWithFormat:@"image%ld.png",imgcount];
    imgcount++;
    [self.imgNameArr addObject:imgName];
    [self setPhotoView];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)imgNameArr
{
    if (!_imgNameArr) {
        _imgNameArr=[NSMutableArray new];
    }
    return _imgNameArr;
}

@end
