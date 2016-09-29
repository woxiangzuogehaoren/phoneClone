//
//  DetailsPageView.h
//  bonjourDemo
//
//  Created by wuqitao on 16/4/21.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailPageViewDelegate <NSObject>

-(void)didSelectRow:(NSInteger)tag;

@end

@interface DetailsPageView : UIView

@property (nonatomic,strong)id<DetailPageViewDelegate>delegate;

@property (nonatomic,strong)UITableView * detailTabelView;
@property (nonatomic,strong)UITableView * installTableView;
@end
