//
//  SelectImageViewController.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/22.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "SelectImageViewController.h"
#import "BarButtonItem.h"
@interface SelectImageViewController ()<BarButtonItemDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray * imageArray;

@property (nonatomic,strong) UICollectionView * iamgeCollectionView;

@end
static NSString * identifier = @"CELLID";
@implementation SelectImageViewController
-(void)viewWillAppear:(BOOL)animated{
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.subviews.firstObject.alpha=1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.title = @"选择照片";
    self.view.backgroundColor =[UIColor whiteColor];
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                    
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareWork];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareWork{
  
    BarButtonItem * leftButton = [[BarButtonItem alloc]init];
    leftButton = [leftButton initWithLeftButtonImageName:@"arrow_left"];
    leftButton.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    [self setCollectionViewLayout];
}
-(void)setCollectionViewLayout{
    
    //I.创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    //II.设置布局属性
    
    //1.单元格大小  --> 决定 行/列 的单元格的个数
    layout.itemSize = CGSizeMake((SCREENWIDTH-40)/4.0, SCREENWIDTH/4.0);
    
    //2.设置最小间隙
    /**
     *  滑动方向垂直:水平间隙由单元格宽度和集合视图宽度决定 最小不能低于最小间隙
     垂直间隙就是最小垂直间隙
     
     水平方向滑动:垂直间隙由单元格高度和集合视图高度决定 最小不能低于最小间隙
     水平间隙就是最小水平间隙
     */
    
    //垂直方向间隙 (间隙本身是水平的)
    layout.minimumLineSpacing = 10;
    //水平方向间隙 (间隙本身是垂直的)
    layout.minimumInteritemSpacing = 1;
    
    //3.设置滚动方向（向哪滑动）
    /**
     *  UICollectionViewScrollDirectionVertical,垂直
     UICollectionViewScrollDirectionHorizontal 水平
     */
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //4.头/尾视图尺寸
    //    layout.headerReferenceSize = CGSizeMake(0, 0);
    //    layout.footerReferenceSize = CGSizeMake(0, 0);
    
    
    //2⃣️集合视图
    
    //I.同步布局类对象创建
     self.iamgeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) collectionViewLayout:layout];
    
    //II.属性
     self.iamgeCollectionView.delegate = self;
    
     self.iamgeCollectionView.dataSource = self;
     self.iamgeCollectionView.backgroundColor = [UIColor whiteColor];
     [self.view addSubview: self.iamgeCollectionView];
     [self.iamgeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
}
#pragma mark BarButtonItemDelegate
-(void)leftBarButtonClick{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //取出图片
    cell.backgroundColor = [UIColor cyanColor];
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noChooseButton"]];
    [cell addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.bottom.equalTo(cell);
        
    }];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    
}
#pragma mark --UICollectionViewDelegateFlowLayout

//边缘大小
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
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
