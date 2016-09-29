//
//  AlbumViewController.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/19.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "AlbumViewController.h"
#import "BarButtonItem.h"
#import "GetAlbumPicturesModel.h"
#import "CustomAlbumTableViewCell.h"
#import "bonjourHeader.h"
#import "BottomView.h"
#import "SelectImageViewController.h"

@interface AlbumViewController ()<BarButtonItemDelegate,CustomAlbumTableViewCellDelegate,BottomViewDelegate>
@property (nonatomic,strong) GetAlbumPicturesModel * albumPicture;
@property (nonatomic,strong) CustomAlbumTableViewCell * cell;

@property (nonatomic,strong) BottomView * bottomView;

@property (nonatomic,strong) UITableView * albumTableView;

@property (nonatomic,strong) NSMutableArray * imageNameArray;
@property (nonatomic,strong) NSMutableArray * selectStateArray;



@end

static NSString * identifier = @"cell";


@implementation AlbumViewController
-(void)viewWillAppear:(BOOL)animated{
    self.title = @"选择图片";
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.subviews.firstObject.alpha=1;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareWork];
    // Do any additional setup after loading the view.
}
-(void)prepareWork{
    
//    self.albumTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-124)];
//    self.albumTableView.delegate = self;
//    self.albumTableView.dataSource = self;
//    self.albumTableView.tableFooterView = [[UIView alloc]init];
//    [self.view addSubview:self.albumTableView];
//
//    self.imageNameArray = [NSMutableArray arrayWithCapacity:1];
//    self.selectStateArray = [NSMutableArray arrayWithCapacity:1];
//
//    BarButtonItem * leftButton = [[BarButtonItem alloc]init];
//    leftButton = [leftButton initWithLeftButtonImageName:@"fanhuiBut"];
//    leftButton.delegate = self;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
//
//    self.bottomView = [[BottomView alloc]init];
//    [self.view addSubview:self.bottomView];
//    self.bottomView.delegate = self;
//    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.bottom.equalTo(self.view.mas_bottom);
//        make.centerX.equalTo(self.view);
//        make.width.equalTo(@320);
//        make.height.equalTo(@60);
//        
//    }];
//    
//    self.albumPicture = [GetAlbumPicturesModel shareGetAlbumPictures];
//    [self.albumPicture getThePhotoAlbumUnderThePictures];
////    __weak AlbumViewController * weakSelf = self;
//    self.albumPicture.albumUnderTheImage = ^(NSMutableDictionary * albunmUnderTheImageDic){
//        
//        NSLog(@"%@",albunmUnderTheImageDic);
//        
//    };
//    
//    [self addImageNameArray];
}
//-(void)addImageNameArray{
//    
//    for (int i = 0; i<self.albumNameArray.count; i++) {
//        
//        [self.imageNameArray addObject:@"feiquanxuan"];
//        [self.selectStateArray addObject:@1];
//    }
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource,UITableViewDelegate
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return self.albumNameArray.count;
//    
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    self.cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    
//    if (!self.cell) {
//        
//        self.cell = [[CustomAlbumTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//        self.cell.delegate = self;
//    }
//    self.cell.selectButton.tag = indexPath.row;
//    
//    if (self.imageNameArray.count>0) {
//       
//        [self.cell setSelectButtonBackgroundImage:self.imageNameArray[indexPath.row]];
//    }
//    
//    if (self.posterImageArray.count>0) {
//        [self.cell modifyPosterImage:self.posterImageArray[indexPath.row]];
//    }
//    
//    if (self.albumNameArray.count>0) {
//        
//        [self.cell modifyAlbumName:self.albumNameArray[indexPath.row]];
//        
//    }
//    if (self.imageNumberArray.count) {
//        
//        NSString * string = [NSString stringWithFormat:@"0/%@",self.imageNumberArray[indexPath.row]];
//        [self.cell modifyDetailTextLabel:string];
//
//    }
//    
//    return self.cell;
//    
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 60;
//    
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    SelectImageViewController * selectImageView = [[SelectImageViewController alloc]init];
//    [self.navigationController pushViewController:selectImageView animated:YES];
//
//    NSLog(@"%@",self.albumNameArray[indexPath.row]);
//    
//}
//设置cell分割线从边框顶端开始
//-(void)viewDidLayoutSubviews
//{    [super viewDidLayoutSubviews];
//    if ([self.albumTableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.albumTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//    }
//    
//    if ([self.albumTableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.albumTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
//    }
//}
//
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}

#pragma mark BarButtonItemDelegate
-(void)leftBarButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark CustomAlbumTableViewCellDelegate
-(void)selectButtonImage:(UIButton*)sender{
    //获取点击的cell的indexPath
    UITableViewCell *cell = (UITableViewCell *)[sender superview];
    NSIndexPath *indexPath = [self.albumTableView indexPathForCell:cell];
    //根据indexPath.row获取具体的cell
    NSIndexPath *index1 =  [NSIndexPath indexPathForItem:indexPath.row inSection:0];
    self.cell  =  [self.albumTableView cellForRowAtIndexPath:index1];
    
    if (self.selectStateArray.count&&[self.selectStateArray[indexPath.row]intValue]) {
        
        [self.cell.selectButton setBackgroundImage:[UIImage imageNamed:@"quanxuan"] forState:UIControlStateNormal];
        [self.imageNameArray replaceObjectAtIndex:indexPath.row withObject:@"quanxuan"];
        [self.selectStateArray replaceObjectAtIndex:indexPath.row  withObject:@0];
        
    }else{
        
        [self.cell.selectButton setBackgroundImage:[UIImage imageNamed:@"feiquanxuan"] forState:UIControlStateNormal];
        [self.imageNameArray replaceObjectAtIndex:indexPath.row withObject:@"feiquanxuan"];
        [self.selectStateArray replaceObjectAtIndex:indexPath.row  withObject:@1];
        
    }
    
    
}
//判断是否全选
-(void)toDetermineWhetherAll{
    
    for (int i=0; i<self.selectStateArray.count; i++) {
        if ([self.selectStateArray[i]isEqualToString:@"1"]) {
            NSLog(@"已经不是全选");
        }
    }
    
}
#pragma mark BottomViewDelegate
-(void)selctButton:(NSInteger)tag{
    
    switch (tag) {
        case 1:
            [self.bottomView modifySelectButtonBackGroundImage:@""];
            [self refreshTheView];
            break;
        case 2:
            [self.bottomView modifyConfirmButtonBackGroundImage:@""];
            break;
        default:
            break;
    }
    
}
//刷新视图
-(void)refreshTheView{
    static BOOL state = YES;
    if (state) {
        state = NO;
        [self selectThePicture:@"quanxuan" withSate:@"0"];
    }else{
        state = YES;
        [self selectThePicture:@"feiquanxuan" withSate:@"1"];
    }
}
//更改数组
-(void)selectThePicture:(NSString*)imageName withSate:(NSString*)state{
    
    for (int i = 0; i<self.albumNameArray.count; i++) {
        
        [self.imageNameArray replaceObjectAtIndex:i withObject:imageName];
        [self.selectStateArray replaceObjectAtIndex:i withObject:state];
        
    }

    [self.albumTableView reloadData];
 
    
    
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
