//
//  MYCusIndexTableView.m
//  MYCusIndex
//
//  Created by mayu on 2017/3/3.
//  Copyright © 2017年 MY. All rights reserved.
//

#import "MYCusIndexTableView.h"
#import "MYCusIndexView.h"

#import "GameNameCell.h"
@interface MYCusIndexTableView () <MYCusIndexViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) UILabel *indexLabel;

@property(strong,nonatomic) UISearchController *searchController;
//数据源
@property (strong,nonatomic) NSMutableArray  *dataList;

@property (strong,nonatomic) NSMutableArray  *searchList;

@end

@implementation MYCusIndexTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:tableView];
        _tableView = tableView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[GameNameCell class] forCellReuseIdentifier:@"cellId"];
        
        self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        //设置代理
        self.searchController.delegate = self;
        self.searchController.searchResultsUpdater= self;
        
        [self.searchController.searchBar sizeToFit];
        
        //设置UISearchController的显示属性，以下3个属性默认为YES
        //搜索时，背景变暗色
        self.searchController.dimsBackgroundDuringPresentation = NO;
        //搜索时，背景变模糊
        self.searchController.obscuresBackgroundDuringPresentation = NO;
        //隐藏导航栏
        self.searchController.hidesNavigationBarDuringPresentation = YES;
        
        self.searchController.searchBar.frame = CGRectMake(0, 0, self.searchController.searchBar.frame.size.width, 44.0);
        
        //添加到searchBar到tableView的header
        self.tableView.tableHeaderView=self.searchController.searchBar;
        
        self.searchController.searchBar.placeholder = @"输入游戏名称搜索";
        
        [self initSubViewsWittFrame:frame];
        
    }
    return self;
}

- (void)initSubViewsWittFrame:(CGRect)frame {
    [self initIndexViewWithFrame:frame];
    _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _indexLabel.center = self.center;
    _indexLabel.layer.masksToBounds = YES;
    _indexLabel.layer.cornerRadius = 4;
    _indexLabel.backgroundColor = [UIColor lightGrayColor];
    _indexLabel.textAlignment = NSTextAlignmentCenter;
    _indexLabel.textColor = [UIColor whiteColor];
    _indexLabel.font = [UIFont systemFontOfSize:30];
    _indexLabel.alpha = 0.0;
    [self addSubview:_indexLabel];
    _indexLabel.hidden = YES;

}

- (void)setCusIndexTableViewDelegate:(id<MYCusIndexTableViewDelegate>)cusIndexTableViewDelegate {
    _cusIndexTableViewDelegate = cusIndexTableViewDelegate;
    _tableView.delegate = _cusIndexTableViewDelegate;
    _tableView.dataSource = _cusIndexTableViewDelegate;
}

- (void)initIndexViewWithFrame:(CGRect)frame {
    CGFloat topSpace = 150;
    CGFloat height = frame.size.height - 200;
    MYCusIndexView *indexView = [[MYCusIndexView alloc]initWithFrame:CGRectMake(frame.size.width-40, topSpace, 30, height)];
    indexView.cusIndexViewDelegate = self;
    indexView.textFont = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    indexView.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    indexView.backgroundColor = [UIColor clearColor];
    [self addSubview:indexView];
}

- (NSArray *)getTableViewIndexList {
    NSArray *tableViewIndexList = nil;
    if ([_cusIndexTableViewDelegate respondsToSelector:@selector(getTableViewIndexList)]) {
        tableViewIndexList = [_cusIndexTableViewDelegate getTableViewIndexList];
    } else {
        tableViewIndexList = nil;
    }
    return tableViewIndexList;
}

- (void)selectedIndex:(NSInteger)index sectionTitle:(NSString *)title {
    [self indexLabelShowWith:title];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)tableViewIndexTouchEnd {
    [UIView animateWithDuration:0.5 animations:^{
        _indexLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        _indexLabel.hidden = YES;
    }];

}

- (void)indexLabelShowWith:(NSString*)title{
    _indexLabel.hidden = NO;
    _indexLabel.text = title;
    _indexLabel.alpha = 1.0;
    
}

@end
