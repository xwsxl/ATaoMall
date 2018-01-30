//
//  ConsultNounVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/6.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "ConsultNounVC.h"

#import "XLRedNaviView.h"

#import "PersonalDanCheckPhotoVC.h"

@interface ConsultNounVC ()<XLRedNaviViewDelegate>
{
    NSMutableArray *_dataArr;
    UIScrollView *_scoll;
}
@end

@implementation ConsultNounVC

- (void)viewDidLoad {

    [super viewDidLoad];
    [self getDatas];
    [self initNavi];
}

-(void)getDatas
{
    NSDictionary *params=@{@"orderno":self.DataModel.order_no};
    WKProgressHUD *hud=[WKProgressHUD showInView:[UIApplication sharedApplication].keyWindow withText:@"" animated:YES];
    [ATHRequestManager requestforgetRefunRecordWithParams:params successBlock:^(NSDictionary *responseObj) {


        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            NSArray *temparr=responseObj[@"resList"];
            _dataArr=[[NSMutableArray alloc] init];
            [_dataArr removeAllObjects];
            for (NSDictionary *dic in temparr) {
               // [NSObject printPropertyWithDict:dic];
                ConsultNounModel *model=[[ConsultNounModel alloc] init];
                model.ID=[NSString stringWithFormat:@"%@",dic[@"id"]];

                model.name=[NSString stringWithFormat:@"%@",dic[@"name"]];

                model.image_one=[NSString stringWithFormat:@"%@",dic[@"image_one"]];

                model.uid=[NSString stringWithFormat:@"%@",dic[@"uid"]];

                model.image_three=[NSString stringWithFormat:@"%@",dic[@"image_three"]];

                model.content=[NSString stringWithFormat:@"%@",dic[@"content"]];
                NSString *str=[model.content substringFromIndex:model.content.length-1];
                if ([str isEqualToString:@"%"]) {
                    model.content=[model.content substringToIndex:model.content.length-1];
                }

                model.state=[NSString stringWithFormat:@"%@",dic[@"state"]];

                model.image_two=[NSString stringWithFormat:@"%@",dic[@"image_two"]];

                model.logo=[NSString stringWithFormat:@"%@",dic[@"logo"]];

                model.refund_type=[NSString stringWithFormat:@"%@",dic[@"refund_type"]];

                model.order_no=[NSString stringWithFormat:@"%@",dic[@"order_no"]];

                model.sysdate=[NSString stringWithFormat:@"%@",dic[@"sysdate"]];

                model.refund_batchid=[NSString stringWithFormat:@"%@",dic[@"refund_batchid"]];

                model.user_type=[NSString stringWithFormat:@"%@",dic[@"user_type"]];

                [_dataArr addObject:model];
               // [_dataArr addObject:model];
            }
            [hud dismiss:YES];
            [self setUI];
        }

    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];

    }];
}

-(void)setUI
{

    _scoll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight)];
    _scoll.showsVerticalScrollIndicator=NO;
    _scoll.showsHorizontalScrollIndicator=NO;
    _scoll.backgroundColor=RGB(244, 244, 244);
    [self.view addSubview:_scoll];

    CGFloat height=0;
    for (int i=0; i<_dataArr.count; i++) {
        ConsultNounModel *model=_dataArr[i];
//黑体字
        NSArray *arr=[model.content componentsSeparatedByString:@"%"];
        NSString *blackStr=arr.firstObject;
//流程
        model.content=[model.content stringByReplacingOccurrencesOfString:@"%" withString:@"\n"];

//彩色字
        NSString *colorStr=@"";
        if ([model.content containsString:@"$"]) {
            NSArray *priceArr=[model.content componentsSeparatedByString:@"$"];
            colorStr=priceArr[1];
            model.content=[model.content stringByReplacingOccurrencesOfString:@"$" withString:@""];
        }
//高度计算
/*文本高度*/
        CGSize size=[model.content sizeWithFont:KNSFONT(12) maxSize:CGSizeMake(kScreenWidth-Width(30), kScreenHeight)];
/* 凭证高度 */
        CGFloat proofHeight=0;
        if (!([model.image_one isEqualToString:@""]||[model.image_one containsString:@"null"])) {
            proofHeight+=Height(10)+70;
        }
/*开始布局*/
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, Height(10)+40+Height(10)+size.height+Height(10)+proofHeight)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [_scoll addSubview:view];
        height+=view.frame.size.height;
        height+=Height(10);

        UIImageView *HeaderIV=[[UIImageView alloc] initWithFrame:CGRectMake(Width(15), Height(10), 40, 40 )];
        [HeaderIV sd_setImageWithURL:KNSURL(model.logo) placeholderImage:KImage(@"头像")];
        [view addSubview:HeaderIV];

        UILabel *nameLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15)+40+Width(10), Height(15), kScreenWidth-Width(40)-40, 13)];
        nameLab.font=KNSFONTM(13);
        nameLab.textColor=RGB(51, 51, 51);
        nameLab.text=model.name;
        [view addSubview:nameLab];

        UILabel *timeLab=[[UILabel alloc]initWithFrame:CGRectMake(Width(15)+40+Width(10), 40-Height(5), kScreenWidth-Width(40)-40, 10)];
        timeLab.font=KNSFONTM(10);
        timeLab.textColor=RGB(153, 153, 153);
        timeLab.text=model.sysdate;
        [view addSubview:timeLab];

        UILabel *descLab=[[UILabel alloc]initWithFrame:CGRectMake(Width(15), 40+Height(20), kScreenWidth-Width(30),size.height)];
        descLab.font=KNSFONTM(12);
        descLab.textColor=RGB(102, 102, 102);
        descLab.numberOfLines=0;
        descLab.text=model.content;
        [view addSubview:descLab];

      //  self.totalPriceLab.text=[NSString stringWithFormat:@"共%@件商品    合计：￥%@+%@积分",_dataModel.total_number_goods,_dataModel.total_money,_dataModel.total_integral];

      //  NSString *colorStr=[NSString stringWithFormat:@"￥%@+%@积分",_dataModel.total_money,_dataModel.total_integral];
        NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:descLab.text];
        //
        NSRange range = [descLab.text rangeOfString:blackStr];
        //彩色字
        if (![colorStr isEqualToString:@""]) {

            NSRange range1 = [descLab.text rangeOfString:colorStr];
            [mAttStri addAttribute:NSForegroundColorAttributeName value:RGB(255, 93, 94) range:range1];
        }

        [mAttStri addAttribute:NSForegroundColorAttributeName value:RGB(51, 51, 51) range:range];

        descLab.attributedText=mAttStri;
        if (!([model.image_one isEqualToString:@""]||[model.image_one containsString:@"null"])) {

            UILabel *proofLab=[[UILabel alloc] initWithFrame:CGRectMake(Width(15), Height(10)+40+Height(10)+size.height+Height(10), Width(64), 70)];
            proofLab.font=KNSFONTM(12);
            proofLab.textColor=RGB(102, 102, 102);
            proofLab.numberOfLines=0;
            proofLab.text=@"凭证:";
            [view addSubview:proofLab];

            UIImageView *proofIV1=[[UIImageView alloc] initWithFrame:CGRectMake(Width(66), Height(10)+40+Height(10)+size.height+Height(10), 70, 70)];
            [proofIV1 sd_setImageWithURL:KNSURL(model.image_one) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
            [view addSubview:proofIV1];
            UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
            but1.frame=proofIV1.frame;
            but1.tag=i*100+1;
            [but1 addTarget:self action:@selector(checkPhotoButClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:but1];

            if (!([model.image_two isEqualToString:@""]||[model.image_two containsString:@"null"])) {
            UIImageView *proofIV2=[[UIImageView alloc] initWithFrame:CGRectMake(Width(66)+70+Width(15), Height(10)+40+Height(10)+size.height+Height(10), 70, 70)];
            [proofIV2 sd_setImageWithURL:KNSURL(model.image_two) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
            [view addSubview:proofIV2];
                UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
                but1.frame=proofIV2.frame;
                but1.tag=i*100+2;
                [but1 addTarget:self action:@selector(checkPhotoButClick:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:but1];
            }
            if (!([model.image_three isEqualToString:@""]||[model.image_three containsString:@"null"])) {
            UIImageView *proofIV3=[[UIImageView alloc] initWithFrame:CGRectMake(Width(66)+140+Width(30), Height(10)+40+Height(10)+size.height+Height(10), 70, 70)];
            [proofIV3 sd_setImageWithURL:KNSURL(model.image_three) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
            [view addSubview:proofIV3];
                UIButton *but1=[UIButton buttonWithType:UIButtonTypeCustom];
                but1.frame=proofIV3.frame;
                but1.tag=i*100+3;
                [but1 addTarget:self action:@selector(checkPhotoButClick:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:but1];
            }
        }
    }
    _scoll.contentSize=CGSizeMake(kScreenWidth, height);
}



-(void)checkPhotoButClick:(UIButton *)sender
{
    ConsultNounModel *model=_dataArr[sender.tag/100];
    PersonalDanCheckPhotoVC *vc=[[PersonalDanCheckPhotoVC alloc] init];
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    if (model.image_one&&![model.image_one isEqualToString:@""]&&![model.image_one containsString:@"null"]) {
        [arr addObject:model.image_one];
    }
    if (model.image_two&&![model.image_two isEqualToString:@""]&&![model.image_two containsString:@"null"]) {
        [arr addObject:model.image_two];
    }
    if (model.image_three&&![model.image_three isEqualToString:@""]&&![model.image_three containsString:@"null"]) {
        [arr addObject:model.image_three];
    }
    [vc setTitle:@"协商记录" andImgArr:[arr copy] selectIndex:sender.tag%100-1];
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)initNavi
{
    XLRedNaviView *navi=[[XLRedNaviView alloc] initWithMessage:@"协商记录" ImageName:@""];
    navi.delegate=self;
    [self.view addSubview:navi];
}
//返回
-(void)QurtBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
