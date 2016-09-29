//
//  DetailsPageView.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/21.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "DetailsPageView.h"
@interface DetailsPageView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray * detailTableViewArray;
@property (nonatomic,strong) NSArray * installTableViewArray;

@property (nonatomic,strong) NSArray * cellHeightArray;
@end
@implementation DetailsPageView

-(instancetype)init{
    
    if (self = [super init]) {
        [self initCustomView];
    }
    return self;
}

-(void)initCustomView{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.detailTableViewArray = @[@"邀请安装",@"功能介绍",@"关于"];
    self.installTableViewArray = @[@"邀请安装",@"扫描二维码下载安装",@"在App Store搜索“手机克隆”下载安装",@"知道了"];
    self.cellHeightArray = @[@40,@130,@40,@50];
    self.detailTabelView = [self setTabelView:1 withTableViewHeight:SCREENHEIGHT/4];

    
    self.installTableView = [self setTabelView:2 withTableViewHeight:260];
    self.installTableView.hidden = YES;

}
//设置tableView
-(UITableView*)setTabelView:(NSInteger)tag withTableViewHeight:(CGFloat)height{
    
    UITableView * tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = tag;
    tableView.scrollEnabled = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.alpha = 0.9;
    tableView.layer.cornerRadius = 10;
    [self setSplitLine:tableView];
    
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_offset(height);
    }];
    
    return  tableView;
  
}
//设置cell分割线从边框顶端开始
-(void)setSplitLine:(UITableView*)tabelView{

    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [tabelView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [tabelView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark UITableViewDelegate,UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==1&&self.detailTableViewArray.count>0) {
        
        return self.detailTableViewArray.count;
        
    }else if(tableView.tag==2&&self.installTableViewArray.count>0){
        
        return self.installTableViewArray.count;
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    if (tableView.tag==1&&self.detailTableViewArray.count>0) {
        
        cell.textLabel.text = self.detailTableViewArray[indexPath.row];
        
        return cell;
        
        
    }else if(self.installTableViewArray.count>0){
        
        [self setCellClassCapacity:cell withIndexPath:indexPath];
        
//        cell.userInteractionEnabled = NO;
        return cell;
    }
    return nil;
}
//返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1) {
        
        return SCREENHEIGHT/12;
        
    }else{
        
        return [self.cellHeightArray[indexPath.row] floatValue];
    }
    
}
//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView.tag==1) {
        
        [self didSelectRowBtn:indexPath.row];
        
    }else{
        
        [self didSelectRowBtn:indexPath.row];
        
    }
    
}
//设置cell类容
-(void)setCellClassCapacity:(UITableViewCell*)cell withIndexPath:(NSIndexPath*)indexPath{
    
    switch (indexPath.row) {
        case 0:
            cell.userInteractionEnabled = NO;
            cell.textLabel.text = self.installTableViewArray[indexPath.row];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor blackColor];
            break;
        case 1:{
            cell.userInteractionEnabled = NO;
            UIImageView * imageView = ({
                UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qrcode_img_iphone@2x.png"]];
                imageView;
            });
            [cell addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(cell);
                make.size.mas_equalTo(CGSizeMake(90, 90));
            }];
            UILabel* label = ({
                UILabel * label = [[UILabel alloc]init];
                label.font = [UIFont systemFontOfSize:12];
                label.text = self.installTableViewArray[indexPath.row];
                label.textColor = [UIColor grayColor];
                label;
            });
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.mas_left).offset(15);
                make.top.equalTo(cell);
                make.size.mas_equalTo(CGSizeMake(200, 15));
            }];
            

        }
            break;
        case 2:
            cell.userInteractionEnabled = NO;
            cell.textLabel.textColor = [UIColor grayColor];
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.textLabel.text = self.installTableViewArray[indexPath.row];
            break;
        case 3:{
            
            UIButton * button = ({
                UIButton * button = [[UIButton alloc]init];
                button.tag = 999999;
                button.layer.borderWidth = 1;
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 192/255.0, 192/255.0, 192/255.0, 1 });
                [button.layer setBorderColor:colorref];//边框颜色
                button.layer.cornerRadius = 5;
                button.titleLabel.font = [UIFont systemFontOfSize:12];
                [button setTitle:self.installTableViewArray[indexPath.row] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buttonTriggerMethod:) forControlEvents:UIControlEventTouchUpInside];
                button;
            });
            [cell addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell).offset(10);
                make.left.equalTo(cell).offset(20);
                make.right.equalTo(cell).offset(-20);
                make.bottom.equalTo(cell).offset(-5);
            }];
        }
            break;
        default:
            break;
    }
    

    
}
//button触发代理方法
-(void)buttonTriggerMethod:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(didSelectRow:)]) {
        [self.delegate didSelectRow:sender.tag];
    }
}
//触发代理方法
-(void)didSelectRowBtn:(NSInteger)tag{
   
    if ([self.delegate respondsToSelector:@selector(didSelectRow:)]) {
        [self.delegate didSelectRow:tag];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
