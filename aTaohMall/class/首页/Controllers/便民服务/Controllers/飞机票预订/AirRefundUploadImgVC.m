//
//  AirRefundUploadImgVC.m
//  aTaohMall
//
//  Created by DingDing on 2017/8/24.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "AirRefundUploadImgVC.h"

@interface AirRefundUploadImgVC ()
{
    UIImageView *ImgView;
    
    NSData *imageData;
    UIAlertController *alertCon;
    BOOL _isFullScreen;
    UIWebView *webView;
    UIView *loadView;
}
@end

@implementation AirRefundUploadImgVC

/*******************************************************      控制器生命周期       ******************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建导航栏
    [self initNav];
    
    //上传图片
    [self initUpImgView];
    
}
/*******************************************************      视图初始化       ******************************************************/
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
    
    label.text = @"上传照片";
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:19];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:label];
    
}

-(void)initUpImgView
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 80+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 35)];
    label.text = @"提交的非自愿退票证明图片必须清晰,图片为10M以内的jpg或者png格式的图片。";
    label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    [self.view addSubview:label];
    
    UIView *ImgUpView = [[UIView alloc] initWithFrame:CGRectMake(0, 125+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width, 207)];
    
    [self.view addSubview:ImgUpView];
    
    
    UIImageView *BgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(19, 0, [UIScreen mainScreen].bounds.size.width-37, 207)];
    
    BgImgView.image = [UIImage imageNamed:@"bg_line"];
    
    [ImgUpView addSubview:BgImgView];
    
    ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(38, 13.5, [UIScreen mainScreen].bounds.size.width-75, 179)];
    [ImgView setContentMode:UIViewContentModeScaleAspectFit];
    // ImgView.image = [UIImage imageNamed:@"sq2"];
    
    [ImgUpView addSubview:ImgView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(19, 0, [UIScreen mainScreen].bounds.size.width-37, 207);
    [button setImage:[UIImage imageNamed:@"btn_Upload-photos"] forState:0];
    button.tag=2001;
    [button addTarget:self action:@selector(UpImgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [ImgUpView addSubview:button];
    
    UIView *PayView = [[UIView alloc] initWithFrame:CGRectMake(15, 370+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 38)];
    PayView.layer.cornerRadius = 3;
    PayView.layer.masksToBounds = YES;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:52/255.0 blue:90/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:93/255.0 blue:94/255.0 alpha:1.0].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    [PayView.layer addSublayer:gradientLayer];
    
    [self.view addSubview:PayView];
    
    UIButton *Pay = [UIButton buttonWithType:UIButtonTypeCustom];
    Pay.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-30, 38);
    Pay.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [Pay addTarget:self action:@selector(SureBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [Pay setTitle:@"确定" forState:0];
    Pay.layer.cornerRadius = 3;
    Pay.layer.masksToBounds = YES;
    [Pay setTitleColor:[UIColor whiteColor] forState:0];
    [PayView addSubview:Pay];
    
    
}
/*******************************************************      数据请求       ******************************************************/
/*****
 *
 *  Description 上传图片数据
 *
 ******/
- (void)upLoadImage{
    
    ASIFormDataRequest * _requestUpLoad= [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@planeUploadPictures_mob.shtml",URL_Str]]];
    
    NSLog(@"====_requestUpLoadh====%@",_requestUpLoad);
    
    _requestUpLoad.delegate = self;
    
    
    NSString *imgName = @"image.jpg";
    
    NSLog(@"====imgName====%@",imgName);
    if (!imageData) {
        [TrainToast showWithText:@"请上传10M以内的图片" duration:1.0];
        return;
    }
    NSFileManager *manager=[NSFileManager defaultManager];
    NSDictionary *dic=[manager attributesOfItemAtPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imgName] error:nil];
    NSLog(@"dic=%@",dic);
    if(([dic fileSize]*1.0/(1024*1024))>3)
    {
        [TrainToast showWithText:@"请上传3M以内的图片" duration:1.0];
        return;
    }
    
    CGRect frame = CGRectMake(0, 65+60, 80, 80);
    frame.size = [UIImage imageNamed:@"ring-alt(1).gif"].size;
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ring-alt(1)" ofType:@"gif"]];
    // view生成
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-frame.size.width)/2, ([UIScreen mainScreen].bounds.size.height-frame.size.height)/2, frame.size.width, frame.size.height)];
    
    webView.backgroundColor = [UIColor clearColor];
    [webView setOpaque:NO];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    
    loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    
    loadView.alpha = 0.2;
    
    [self.view addSubview:loadView];
    [_requestUpLoad addPostValue:[kUserDefaults objectForKey:@"sigen"] forKey:@"sigen"];
    [_requestUpLoad addPostValue:self.orderno forKey:@"orderno"];
    [_requestUpLoad addFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imgName]  forKey:@"image"];
    
    
    [_requestUpLoad startAsynchronous];
    
    
    
    
}
/*****
 *
 *  Description 上传图片成功
 *
 ******/
- (void)requestFinished:(ASIHTTPRequest *)request{
    
    if (webView.superview!=nil) {
        [webView removeFromSuperview];
    }
    if (loadView.superview!=nil) {
        [loadView removeFromSuperview];
    }
    NSLog(@"request.response=%@",request.responseString);
    NSString *codeKey = [SecretCodeTool getDesCodeKey:request.responseString];
    NSString *content = [SecretCodeTool getReallyDesCodeString:request.responseString];
    
    if (codeKey && content) {
        NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
        xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        
        NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if ([dic[@"status"] isEqualToString:@"10000"]) {
            
            [self.delegate uploadImgSuccessWithUploadString:dic[@"upload"]];
            [self.navigationController popViewControllerAnimated:NO];
        }
        else if ([dic[@"status"] isEqualToString:@"100006"])
        {
            [UIAlertTools showAlertWithTitle:@"" message:dic[@"message"] cancelTitle:@"知道了" titleArray:nil viewController:self confirm:^(NSInteger buttonTag) {
                
            }];
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
    if (webView.superview!=nil) {
        [webView removeFromSuperview];
    }
    if (loadView.superview!=nil) {
        [loadView removeFromSuperview];
    }
    alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"上传失败，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertCon addAction: [UIAlertAction actionWithTitle: @"确认" style: (UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        
        [self presentViewController: alertCon animated: YES completion: nil];
    }]];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}




/*******************************************************      协议方法       ******************************************************/
#pragma mark - actionSheet代理
/*****
 *
 *  Description 选择图片的方式，0为拍照，1位从相册选取
 *
 ******/
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        //            NSLog(@"0");
        UIImagePickerController *pickerCtrl = [[UIImagePickerController alloc] init];
        pickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //设置代理
        pickerCtrl.delegate = self;
        
        //可编辑
        pickerCtrl.allowsEditing = YES;
        
        
        //切换到pikerCtr
        [self presentViewController:pickerCtrl animated:YES completion:nil];
        
    }else if (buttonIndex==1){
        
        //            NSLog(@"1");
        UIImagePickerController *pickerCtrl = [[UIImagePickerController alloc] init];
        pickerCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        //设置代理
        pickerCtrl.delegate = self;
        
        //可编辑
        pickerCtrl.allowsEditing = YES;
        
        //切换到pikerCtr
        [self presentViewController:pickerCtrl animated:YES completion:nil];
    }
    
}



#pragma mark - UIImagePickerControllerDelegate
/*****
 *
 *  Description  info中保存着选择的图片信息，拍照完成选中也走这个方法
 *
 ******/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //选择了图片则把按钮图片设为空
    UIButton *but=[self.view viewWithTag:2001];
    [but setImage:[UIImage imageNamed:@""] forState:0];
    
    //UIImagePickerControllerOriginalImage; //原图
    //UIImagePickerControllerEditedImage;//裁剪的图
    //UIImagePickerControllerCropRect;//获取图片裁剪后 剩下的图
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    // UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"======image======%@======%@",image,info);
    
    NSString *imgName=@"image.jpg";
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
    
    //    NSLog(@"======imageData======%@",imageData);
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    NSLog(@"=666===fullPath====%@",fullPath);
    
    ImgView.image = img;
    
    NSFileManager *manager=[NSFileManager defaultManager];
    
    [manager createFileAtPath:fullPath contents:imageData attributes:nil];
    //    [imageData writeToFile:fullPath atomically:NO];
    
}
/*******************************************************      Button点击方法、页面跳转等等       ******************************************************/

//确定
-(void)SureBtnCLick
{
    [self upLoadImage];
    
}
//返回
-(void)QurtBtnClick
{
    
    [self.navigationController popViewControllerAnimated:NO];
    
    
}
//上传图片
-(void)UpImgBtnClick:(UIButton *)sender
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
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    _isFullScreen = !_isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = ImgView.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +ImgView.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+ImgView.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        if (_isFullScreen) {
            // 放大尺寸
            ImgView.layer.cornerRadius=10;
            ImgView.frame = CGRectMake(37, 10, [UIScreen mainScreen].bounds.size.width-74, 180);
        }
        else {
            // 缩小尺寸
            ImgView.layer.cornerRadius=10;
        }
        
        // commit动画
        [UIView commitAnimations];
        
    }
    
    
    
}

@end
