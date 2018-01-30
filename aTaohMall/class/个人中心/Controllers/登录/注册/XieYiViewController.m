//
//  XieYiViewController.m
//  aTaohMall
//
//  Created by JMSHT on 16/7/21.
//  Copyright © 2016年 ysy. All rights reserved.
//

#import "XieYiViewController.h"
#import "XieYiCell.h"



@interface XieYiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
}
@end

CGFloat  fheight;
@implementation XieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    CGSize size = [msg sizeWithFont:justifyLabel.font constrainedToSize:CGSizeMake(justifyLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    NSLog(@"高度：%f 宽度：%f",size.height,size.width );
//    
//    NSLog(@"%ld",msg.length);
//    CGSize titleSize = [msg boundingRectWithSize:CGSizeMake(justifyLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
//    NSLog(@"文本的高%f",titleSize.height);
    
    //创建UIScrollerView
    [self initScrollerView];
}

-(void)initScrollerView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"XieYiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return fheight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XieYiCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
//    CGSize size = [cell.XieyiLabel.text sizeWithFont:cell.XieyiLabel.font constrainedToSize:CGSizeMake(cell.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    NSLog(@"高度：%f 宽度：%f",size.height,size.width );
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGSize titleSize = [cell.XieyiLabel.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    NSLog(@"文本的高%f",titleSize.height);
    fheight = titleSize.height+20;
    
//    NSLog(@"%@",cell.XieyiLabel.text);
    
    return cell;
    
}

//返回
- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
