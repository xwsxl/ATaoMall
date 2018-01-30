//
//  HomeHotSaleVC.m
//  aTaohMall
//
//  Created by Hawky on 2017/12/28.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "HomeHotSaleVC.h"


#import "AllSingleShoppingModel.h"

#import "XLShoppingListTableViewCell.h"
#import "XLNoDataView.h"
#import "XLNaviVIew.h"
#import "XLTopSelectScroll.h"

#import "YTGoodsDetailViewController.h"


@interface HomeHotSaleVC ()<UITableViewDataSource,UITableViewDelegate,XLNaviViewDelegate,XLTopSelectScrollDelegate>
{
    UITableView *_tableView;
    XLNoDataView *nodataView;
    XLTopSelectScroll *topScroll;
    UIView *topView;

    UIView *_selecTionView;
    UIControl *_huiseControl;

    UIButton *Morebut;

    NSMutableArray *statusArr;
    NSMutableArray *topNameArr;
     NSInteger stutasIndex;

    CGFloat linecount;

}

@property (nonatomic,strong)NSMutableArray *dataSource;


@property (nonatomic,strong)UISwipeGestureRecognizer *leftSwipeGesture;
@property (nonatomic,strong)UISwipeGestureRecognizer *rightSwipeGesture;

@end

@implementation HomeHotSaleVC
static NSString * const reuseIdentifier = @"XLShoppingListTableViewCell";
/*******************************************************      控制器生命周期       ******************************************************/
//
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self getTopSelectData];
    if (@available(iOS 11.0, *)) {

    } else {
        self.automaticallyAdjustsScrollViewInsets =NO;
    }
}
//
-(void)setUI
{
    [self initNavi];
    [self initTop];
    [self initTable];

}
/*******************************************************      数据请求       ******************************************************/
//
-(void)getTopSelectData
{
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:@"" animated:YES];
    [ATHRequestManager requestforgetHotSalesHeadTypeWithParams:nil successBlock:^(NSDictionary *responseObj) {
        topNameArr=[[NSMutableArray alloc] init];
        statusArr=[[NSMutableArray alloc] init];
        [hud dismiss:YES];
        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            for (NSDictionary *dic in responseObj[@"list"]) {
                [topNameArr addObject:[NSString stringWithFormat:@"%@",dic[@"name"]]];
                [statusArr addObject:[NSString stringWithFormat:@"%@",dic[@"id"]]];
            }
            [self initTopView];
        }

    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];
    }];
}

-(void)getDataWithID:(NSString *)ID
{
    NSDictionary *params=@{@"id":ID};
    WKProgressHUD *hud=[WKProgressHUD showInView:self.view withText:@"" animated:YES];
    [self.view removeGestureRecognizer:self.leftSwipeGesture];
    [self.view removeGestureRecognizer:self.rightSwipeGesture];
    [ATHRequestManager requestforgetHotSalesGoodsListWithParams:params successBlock:^(NSDictionary *responseObj) {

        if ([responseObj[@"status"] isEqualToString:@"10000"]) {
            for (NSDictionary *dic in responseObj[@"list"]) {
                AllSingleShoppingModel *model=[[AllSingleShoppingModel alloc] init];

                 model.gid=[NSString stringWithFormat:@"%@",dic[@"gid"]];
                 model.mid=[NSString stringWithFormat:@"%@",dic[@"mid"]];
                 model.name=[NSString stringWithFormat:@"%@",dic[@"name"]];
                 model.amount=[NSString stringWithFormat:@"%@",dic[@"amount"]];
                 model.pay_integer=[NSString stringWithFormat:@"%@",dic[@"pay_integer"]];
                 model.pay_maney=[NSString stringWithFormat:@"%@",dic[@"pay_maney"]];
                 model.scopeimg=[NSString stringWithFormat:@"%@",dic[@"scopeimg"]];
                // model.status=[NSString stringWithFormat:@"%@",dic[@"status"]];
                 model.is_attribute=[NSString stringWithFormat:@"%@",dic[@"is_attribute"]];
                model.CELLTYPE=@"热销排行";
                [self.dataSource addObject:model];

            }
        }
     else
     {

         [TrainToast showWithText:responseObj[@"message"] duration:2.0];

     }
        if (self.dataSource.count==0) {
            [self initNoDataView];
        }else
        {

            if (nodataView) {
                nodataView.hidden=YES;
            }
            _tableView.hidden=NO;
            [self initTop];
            [_tableView reloadData];
        }
     [hud dismiss:YES];
     [self.view addGestureRecognizer:self.leftSwipeGesture];
     [self.view addGestureRecognizer:self.rightSwipeGesture];

    } faildBlock:^(NSError *error) {
        [hud dismiss:YES];
        [self.view addGestureRecognizer:self.leftSwipeGesture];
        [self.view addGestureRecognizer:self.rightSwipeGesture];
    }];
}

/*******************************************************      初始化视图       ******************************************************/
//
-(void)initNavi
{
    XLNaviView *navi=[[XLNaviView alloc] initWithMessage:@"热销排行" ImageName:@""];
    navi.delegate=self;
    [self.view addSubview:navi];

}
//
-(void)initTopView
{
    topScroll=[[XLTopSelectScroll alloc] initWithWith:CGRectMake(0, KSafeAreaTopNaviHeight-1, kScreen_Width-45, 45) AndDataArr:[topNameArr copy] AndFont:KNSFONT(15)];
    topScroll.XLdelegate=self;
    [self.view addSubview:topScroll];

    Morebut=[UIButton buttonWithType:UIButtonTypeCustom];
    Morebut.frame=CGRectMake(kScreenWidth-45, KSafeAreaTopNaviHeight-1, 45, 44);
    [Morebut addTarget:self action:@selector(foldList:) forControlEvents:UIControlEventTouchUpInside];
    [Morebut setImage:KImage(@"xlhome-btn-more") forState:UIControlStateNormal];
    Morebut.selected=NO;
    Morebut.adjustsImageWhenHighlighted=NO;
    [self.view addSubview:Morebut];

    UIImageView *line=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-45, KSafeAreaTopNaviHeight+43, 45, 1)];
    [line setImage:KImage(@"分割线-拷贝")];
    [self.view addSubview:line];

    self.leftSwipeGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.rightSwipeGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [topScroll selectedIndexType:0];

}

//
-(void)initTop
{
    CGFloat imgWidth=(kScreen_Width-40)/3;
if (self.dataSource.count==0)
{
    return;
}
    if (!topView) {
        topView=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+44, kScreenWidth, Height(20)+Height(10)+18+Height(5)+imgWidth)];
        [self.view addSubview:topView];
    }else
    {
        [topView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [topView setBackgroundColor:RGB(242, 242, 242)];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, Height(20)+Height(10)+18+Height(5)+imgWidth)];
    view.userInteractionEnabled=YES;
    UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(0, Height(10), kScreen_Width, Height(10)+18+Height(5)+imgWidth+Height(10))];
    [backView setBackgroundColor:[UIColor whiteColor]];
    NSInteger count=self.dataSource.count;
    if (count>3) {
        count=3;
    }
    for (int i=0; i<count; i++) {
        AllSingleShoppingModel *model=self.dataSource[i];
        CGRect rect=CGRectMake(Width(10)+(imgWidth+Width(10))*i, Height(10), imgWidth, imgWidth);
        UIImageView *IV=[[UIImageView alloc] initWithFrame:rect];
        IV.userInteractionEnabled=YES;
        [IV sd_setImageWithURL:KNSURL(model.scopeimg) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        [backView addSubview:IV];



        UIImageView *rankIV=[[UIImageView alloc] initWithFrame:CGRectMake(-2.5, -11, 30, 30)];

        NSString *str=[NSString stringWithFormat:@"xlhome-ranking %d",i+1];
        [rankIV setImage:KImage(str)];
        [IV addSubview:rankIV];

        UILabel *goodsNameLab=[[UILabel alloc] initWithFrame:CGRectMake(0,imgWidth-27.5, imgWidth, 27.5)];

        goodsNameLab.textColor=[UIColor whiteColor];
        goodsNameLab.backgroundColor=RGBA(0, 0, 0, 0.5);
        goodsNameLab.text=model.name;
        goodsNameLab.font=KNSFONT(14);
        goodsNameLab.textAlignment=NSTextAlignmentCenter;
        [IV addSubview:goodsNameLab];

        UILabel *priceLab=[[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x,backView.frame.size.height-Height(10)-18, imgWidth, 18)];

        priceLab.textColor=RGB(243, 73, 73);
        priceLab.text=[NSString stringWithFormat:@"￥%@+%@积分",model.pay_maney,model.pay_integer];
        priceLab.font=KNSFONT(14);
        priceLab.textAlignment=NSTextAlignmentCenter;
        [backView addSubview:priceLab];

        UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=IV.bounds;
        but.tag=1000+i;
        [but addTarget:self action:@selector(selectShopping:) forControlEvents:UIControlEventTouchUpInside];
        [IV addSubview:but];
    }

    [view addSubview:backView];
    [topView addSubview:view];

}
//
-(void)initTable
{
     CGFloat imgWidth=(kScreen_Width-40)/3;
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+44+Height(20)+Height(10)+18+Height(5)+imgWidth, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight-44-(Height(20)+Height(10)+18+Height(5)+imgWidth)) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.showsHorizontalScrollIndicator=NO;
    _tableView.estimatedRowHeight=0;
    _tableView.estimatedSectionFooterHeight=0;
    _tableView.estimatedSectionHeaderHeight=0;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[XLShoppingListTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_tableView];

}

//
-(void)initNoDataView
{
    _tableView.hidden=YES;
    if (nodataView) {
        nodataView.hidden=NO;
        return;
    }
    nodataView=[[XLNoDataView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+45, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight-45) AndMessage:nil ImageName:nil];
    [self.view addSubview:nodataView];

}
//
-(void)initSelectionView
{

    linecount=4.0;

    CGFloat top=Height(15);
    CGFloat left=Width(15);

    CGFloat lineHeight=top+20;

    CGFloat butWidth=(kScreenWidth-(linecount+1)*left)/linecount;

    CGFloat height=(topNameArr.count+linecount-1)/linecount*lineHeight+top;
    if (!_selecTionView) {

        _selecTionView=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight+45, kScreenWidth, height)];
        [_selecTionView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_selecTionView];

        for (int i=0; i<topNameArr.count; i++) {

            UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];

            CGFloat kwidth=(i%(int)linecount)*(butWidth+left)+left;

            CGFloat kheight=((int)(i/linecount))*lineHeight+top;

            but.frame=CGRectMake(kwidth, kheight, butWidth, 20);
            [but setTitle:topNameArr[i] forState:UIControlStateNormal];
            if (i==stutasIndex) {
                [but setTitleColor:RGB(255, 93, 94) forState:UIControlStateNormal];
            }else
            {
            [but setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
            }
            [but addTarget:self action:@selector(selectTopName:) forControlEvents:UIControlEventTouchUpInside];
            but.tag=2000+i;
            [_selecTionView addSubview:but];
        }
    }
    if (!_huiseControl) {
        _huiseControl=[[UIControl alloc] initWithFrame:CGRectMake(0,KSafeAreaTopNaviHeight+45+height, kScreenWidth, kScreenHeight-KSafeAreaTopNaviHeight-45-height)];
        [_huiseControl setBackgroundColor:RGBA(0, 0, 0, 0.5)];
        [_huiseControl addTarget:self action:@selector(huiseClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_huiseControl];
    }
}
/*******************************************************      各种button执行方法、页面间的跳转       ******************************************************/




//
-(void)huiseClick:(UIControl *)sender
{
    if (Morebut.selected) {
        [self foldList:nil];
    }else
    {
        [self foldlistAndControll];
    }


}

//
-(void)QurtBtnClick
{

    [self.navigationController popViewControllerAnimated:YES];

}
//
//手势触发事件
-(void)handleSwipe:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction==UISwipeGestureRecognizerDirectionLeft) {
        [topScroll selectedIndexType:stutasIndex+1];

    }else if (sender.direction==UISwipeGestureRecognizerDirectionRight)
    {

        [topScroll selectedIndexType:stutasIndex-1];

    }

}
//
-(void)selectTopName:(UIButton *)sender
{
    [self huiseClick:nil];
    [topScroll selectedIndexType:sender.tag-2000];


}

//
-(void)selectShopping:(UIButton *)sender
{
    NSInteger index=sender.tag-1000;

    AllSingleShoppingModel *model=self.dataSource[index];
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.good_type=model.type_name;
    vc.gid=model.gid;
    vc.type=@"1";
    vc.attribute = model.is_attribute;
    vc.ID=model.ID;
    [self.navigationController pushViewController:vc animated:NO];
    

}
//
-(void)foldList:(UIButton *)sender
{
    Morebut.selected=!Morebut.selected;

    if (Morebut.selected) {
        YLog(@"123");
        [Morebut setImage:KImage(@"xlhome-btn-close") forState:UIControlStateNormal];
        [self initSelectionView];
    }else
    {
         YLog(@"456");
        [Morebut setImage:KImage(@"xlhome-btn-more") forState:UIControlStateNormal];
        [self foldlistAndControll];
    }


}

/*******************************************************      协议方法       ******************************************************/
//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count-3>0?self.dataSource.count-3:0;
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLShoppingListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.DataModel=self.dataSource[indexPath.row+3];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105+Height(15);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (self.dataSource.count>0) {
        return Height(10);
    }else
    {
    return 0.01;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

   return [[UIView alloc] init];

}




-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllSingleShoppingModel *model=self.dataSource[indexPath.row+3];
    YTGoodsDetailViewController *vc=[[YTGoodsDetailViewController alloc] init];
    vc.good_type=model.type_name;
    //    vc.gid=gid;
    vc.gid=model.gid;
    vc.type=@"1";
    vc.attribute = model.is_attribute;
    vc.ID=model.ID;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:NO];

}


//
-(void)DidSelectTopIndex:(NSInteger)index
{

    if (Morebut.selected) {
        [self foldList:nil];
    }

    stutasIndex=index;
    [self.dataSource removeAllObjects];
    [self getDataWithID:statusArr[index]];
    // [TrainToast showWithText:topArr[index] duration:2.0];
}
/*******************************************************      代码提取(多是复用代码)       ******************************************************/
//

-(void)foldlistAndControll
{
    [UIView animateWithDuration:0.2 animations:^{
        [_selecTionView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        _selecTionView.frame=CGRectMake(kScreenWidth, KSafeAreaTopNaviHeight+45, 0, 0);
        _huiseControl.backgroundColor=RGBA(0, 0, 0, 0.0);

  //[_huiseControl removeFromSuperview];
    } completion:^(BOOL finished) {
        [_selecTionView removeFromSuperview];
        [_huiseControl removeFromSuperview];
        _huiseControl=nil;
        _selecTionView=nil;
    }];
}

//
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end
