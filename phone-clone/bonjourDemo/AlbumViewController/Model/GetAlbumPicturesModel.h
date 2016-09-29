//
//  GetAlbumPictures.h
//  bonjourDemo
//
//  Created by wuqitao on 16/4/18.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
@interface GetAlbumPicturesModel : NSObject
//获取图片数量的block方法
@property(nonatomic,copy)void (^numbelOfImageModel)(NSInteger iamgeNumber);
//获取视频数量的block方法
@property(nonatomic,copy)void (^numbelOfVideoModel)(NSInteger videoNumber);
//获取所有图片的block方法
@property(nonatomic,copy)void (^albumUnderTheImage)(NSMutableArray * albunmUnderAllImage);
//获取所有视频的block方法
@property(nonatomic,copy)void (^albumUnderTheVideo)(NSMutableArray * albunmUnderAllVideo);
//创建单例
+(instancetype)shareGetAlbumPictures;
//获取相册图片和视频的数量
-(NSInteger)getNumbelOfAssets;
//获取相册下的所有图片
-(void)getThePhotoAlbumUnderThePictures;
//获取相册下的所有视频
-(void)getTheVideoAlbumUnderThePictures;
//转换成data
-(NSData*)conversionData:(NSMutableArray*)array;
//数据转换数组
-(NSMutableArray *)dataConversionArray:(NSData*)data;
//保存图片到相册
-(void)saveImageToAlbum:(NSMutableArray*)array;
-(void)saveVideoToAlbum:(NSMutableArray*)array;
@end
