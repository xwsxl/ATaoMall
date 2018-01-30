//
//  PersonalDanCheckPhotoVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "PersonalDanCheckPhotoVC.h"
#import "XLRedNaviView.h"

@interface PersonalDanCheckPhotoVC ()<XLRedNaviViewDelegate>
{
    NSString *title;
    NSString *IMGName;
    UIImage *ImageData;

    NSArray *imageArr;

    UIButton *nextBut;
    UIButton *upBut;

    UIScrollView *scroll;
}
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,strong)UISwipeGestureRecognizer *leftSwipeGesture;
@property (nonatomic,strong)UISwipeGestureRecognizer *rightSwipeGesture;
@end

@implementation PersonalDanCheckPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftSwipeGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.rightSwipeGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.leftSwipeGesture];
    [self.view addGestureRecognizer:self.rightSwipeGesture];
    // Do any additional setup after loading the view.
}

-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setTitle:(NSString *)str andImgArr:(NSArray *)imgarr selectIndex:(NSInteger )index
{
    title=str;
    imageArr=imgarr;
    _selectIndex=index;
    [self setUI];
}


-(void)setUI
{

    XLRedNaviView *navi=[[XLRedNaviView alloc] initWithMessage:title ImageName:@""];
    navi.delegate=self;
    [self.view addSubview:navi];


    CGFloat w=0;
    CGFloat h=0;

    scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight)];
    [self.view addSubview:scroll];
    h=kScreen_Height-(Height(20)+KSafeAreaTopNaviHeight);
    w=kScreen_Width-Width(30);
    CGRect rect=CGRectMake((kScreen_Width-w)/2, Height(10), w, h);
    if ([title isEqualToString:@"协商记录"]) {

        for (int i=0; i<imageArr.count; i++) {
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(kScreen_Width*i,0, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight)];
            UIImageView *IV=[[UIImageView alloc] initWithFrame:rect];
            [IV sd_setImageWithURL:KNSURL(imageArr[i]) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            }];
            [IV setContentMode:UIViewContentModeScaleAspectFit];
            [view addSubview:IV];
             [scroll addSubview:view];
        }

        scroll.contentOffset=CGPointMake(self.selectIndex*kScreen_Width, 0);
        scroll.scrollEnabled=NO;
        scroll.contentSize=CGSizeMake(imageArr.count*kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight);
    }else
    {
        for (int i=0; i<imageArr.count; i++) {
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(kScreen_Width*i,0, kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight)];
            UIImageView *IV=[[UIImageView alloc] initWithFrame:rect];
            [IV setImage:imageArr[i]];
            [IV setContentMode:UIViewContentModeScaleAspectFit];
            [view addSubview:IV];
             [scroll addSubview:view];
        }

        scroll.scrollEnabled=NO;
        scroll.contentOffset=CGPointMake(self.selectIndex*kScreen_Width, 0);
        scroll.contentSize=CGSizeMake(imageArr.count*kScreen_Width, kScreenHeight-KSafeAreaTopNaviHeight);
    }
}


//手势触发事件
-(void)handleSwipe:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction==UISwipeGestureRecognizerDirectionLeft) {
        if (self.selectIndex+1<imageArr.count) {
            self.selectIndex++;
            [scroll setContentOffset:CGPointMake(self.selectIndex*kScreen_Width, 0) animated:YES];
        }

    }else if (sender.direction==UISwipeGestureRecognizerDirectionRight)
    {
        if (self.selectIndex-1>=0) {
            self.selectIndex--;
            [scroll setContentOffset:CGPointMake(self.selectIndex*kScreen_Width, 0) animated:YES];
        }
    }

}


-(void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex=selectIndex;

    upBut.hidden=NO;
    nextBut.hidden=NO;
    if (selectIndex==0) {
        upBut.hidden=YES;
    }
    if (selectIndex==imageArr.count-1)
    {
        nextBut.hidden=YES;
    }

}


@end
