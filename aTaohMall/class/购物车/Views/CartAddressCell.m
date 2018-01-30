//
//  CartAddressCell.m
//  aTaohMall
//
//  Created by JMSHT on 2017/1/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "CartAddressCell.h"

@implementation CartAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadMyCell];
    }
    return self;
}

-(void)loadMyCell
{
    
    
    NSLog(@"&&&&&&&&&&&=收货地址");
    
    self.ShuoMingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (114-20)/2, 180, 20)];
    self.ShuoMingLabel.text = @"请先添加收货地址";
    self.ShuoMingLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    self.ShuoMingLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.ShuoMingLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.ShuoMingLabel];
    
    
    //收货人
    self.Name = [[UILabel alloc] initWithFrame:CGRectMake(15, 21, [UIScreen mainScreen].bounds.size.width-100, 30)];
    
    self.Name.textAlignment = NSTextAlignmentLeft;
    
    self.Name.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.Name.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    self.Name.text = @"收货人：李晓明    13651239889";
    
    [self addSubview:self.Name];
    
    //电话
    self.Phone = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-140, 21,100, 30)];
    
    self.Phone.textAlignment = NSTextAlignmentLeft;
    
    self.Phone.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.Phone.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    self.Phone.text = @"13651239889";
    
    [self addSubview:self.Phone];
    
    
    self.Address = [[UILabel alloc] initWithFrame:CGRectMake(15, 63, [UIScreen mainScreen].bounds.size.width-100, 30)];

    self.Address.textAlignment = NSTextAlignmentLeft;
    
    self.Address.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    self.Address.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    
    self.Address.text = @"收货地址：广东省深圳市南山区方达大厦805";
    
    [self addSubview:self.Address];
    
    
    self.ImgView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-34, 104/2, 6, 10)];
    
    self.ImgView.image = [UIImage imageNamed:@"右键进入"];
    
    [self addSubview:self.ImgView];
    
    
    self.RedView = [[UIView alloc] initWithFrame:CGRectMake(0, 114, [UIScreen mainScreen].bounds.size.width, 15)];
    self.RedView.backgroundColor = [UIColor colorWithRed:255/255.0 green:95/255.0 blue:95/255.0 alpha:1.0];
    
    [self addSubview:self.RedView];
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 129, [UIScreen mainScreen].bounds.size.width, 10)];
    
    blackView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [self addSubview:blackView];
    
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 129, [UIScreen mainScreen].bounds.size.width, 10)];
//    view.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
//    
//    [self addSubview:view];
}

-(void)setAddressArray:(NSArray *)AddressArray
{
    
    _AddressArray = AddressArray;
    
    if (_AddressArray.count==0) {
        
        
        self.ShuoMingLabel.hidden=NO;
        self.Name.hidden=YES;
        self.Address.hidden=YES;
        self.Phone.hidden=YES;
        
        
    }else{
        
        self.ShuoMingLabel.hidden=YES;
        self.Name.hidden=NO;
        self.Address.hidden=NO;
        self.Phone.hidden = NO;
        
    }
}

-(void)setUserType:(NSString *)UserType
{
    _UserType = UserType;
    
    if ([_UserType isEqualToString:@"888"]) {
        
        self.ShuoMingLabel.hidden=YES;
        self.Name.hidden=NO;
        self.Address.hidden=NO;
        self.Phone.hidden=NO;
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
