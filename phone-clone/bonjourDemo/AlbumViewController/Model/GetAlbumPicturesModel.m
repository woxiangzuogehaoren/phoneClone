//
//  GetAlbumPictures.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/18.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "GetAlbumPicturesModel.h"
static GetAlbumPicturesModel * _getAlbumPictures = nil;
@interface GetAlbumPicturesModel()

@property (nonatomic,strong) ALAssetsLibrary * assetsLibrary;
@property (nonatomic,strong) ALAssetsGroup * assetsGroup;

@property (nonatomic,strong) PHFetchResult * fetchResult;

@property (nonatomic,strong) NSMutableArray * videoArray ;
@property (nonatomic,strong) NSMutableArray * imageArray;

@end


@implementation GetAlbumPicturesModel
//单例
+(instancetype)shareGetAlbumPictures{
    
  
        
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _getAlbumPictures = [[GetAlbumPicturesModel alloc]init];
        _getAlbumPictures.assetsLibrary = [[ALAssetsLibrary alloc]init];
        _getAlbumPictures.assetsGroup = [[ALAssetsGroup alloc]init];
        _getAlbumPictures.videoArray = [NSMutableArray arrayWithCapacity:1];
        _getAlbumPictures.imageArray= [NSMutableArray arrayWithCapacity:1];
    });
   
    return _getAlbumPictures;
}

//获取相册下的所有图片~全选
-(void)getThePhotoAlbumUnderThePictures{

    [_getAlbumPictures.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        if (group) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
               
                if (result) {
                    //获取源数据
                   ALAssetRepresentation* representation = [result defaultRepresentation];
//                    [_getAlbumPictures.imageArray addObject:[representation metadata]];
                   UIImage * image = [UIImage imageWithCGImage:[representation fullScreenImage]];
                   
                    [_getAlbumPictures.imageArray addObject:image];
                }
                
            }];
            
        }else{
            NSMutableArray * array = [_getAlbumPictures.imageArray copy];
            _getAlbumPictures.albumUnderTheImage(array);
            [_getAlbumPictures.imageArray removeAllObjects];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
}
//获取相册下的所有视频~全选
-(void)getTheVideoAlbumUnderThePictures{

    [_getAlbumPictures.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group setAssetsFilter:[ALAssetsFilter allVideos]];
        if (group) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                if (result) {
                    //获取源数据
                     ALAssetRepresentation* representation = [result defaultRepresentation];
                    NSUInteger size = (NSUInteger)representation.size;
                    NSMutableData* data = [[NSMutableData alloc] initWithCapacity:size];
                    void* buffer = [data mutableBytes];
                    [representation getBytes:buffer fromOffset:0 length:size error:nil];
                    NSData *fileData = [[NSData alloc] initWithBytes:buffer length:size];
                    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObject:fileData forKey:representation.filename];
                    [_getAlbumPictures.videoArray addObject:dic];

                }
                
            }];
            
        }else{
            NSMutableArray * array = [_getAlbumPictures.videoArray copy];
            _getAlbumPictures.albumUnderTheVideo(array);
            [_getAlbumPictures.videoArray removeAllObjects];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
}
//获取相册图片和视屏数量
-(NSInteger)getNumbelOfAssets{

   __block NSMutableArray * imageArray = [NSMutableArray arrayWithCapacity:1];
    
    __block NSMutableArray * videoArray = [NSMutableArray arrayWithCapacity:1];

    [_getAlbumPictures.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                //图片
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {

                    [imageArray addObject:result];
     
                //视频
                }else if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]){
                    [videoArray addObject:result];

                }
                
            }];
            
        }else{
            //拷贝
            NSArray * video = [videoArray copy];
            NSArray * image = [imageArray copy];
            //视频数量
            _getAlbumPictures.numbelOfVideoModel(video.count);
            //照片数量
            _getAlbumPictures.numbelOfImageModel(image.count);
            //每次传完后移除数组
            [videoArray removeAllObjects];
            [imageArray removeAllObjects];
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"not found group:%@",error);
       
    }];
    return imageArray.count;
    
}
//转成data
-(NSData*)conversionData:(NSMutableArray*)array{

    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];

    return data;
}
//data转成array
-(NSMutableArray *)dataConversionArray:(NSData*)data{

   
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
    array = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    return array;
}
//保存照片到系统默认相册
-(void)saveImageToAlbum:(NSMutableArray*)array{
    
    for (int i=0; i<array.count; i++) {

         UIImageWriteToSavedPhotosAlbum(array[i], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
   
}
//保存视频到系统默认相册
-(void)saveVideoToAlbum:(NSMutableArray*)array{
    
    NSString *savePath;
    for (int i=0; i<array.count; i++) {
        NSArray * keyArray = [array[i] allKeys];
        for (int i=0;i<keyArray.count ; i++) {
            //先保存到本机的沙盒路径下
            savePath = [NSString stringWithFormat:@"%@%@", [NSHomeDirectory() stringByAppendingString:@"/video/"], keyArray[i]];
            [array[i] writeToFile:savePath atomically:NO];
        }
        //在导入相册中
        UISaveVideoAtPathToSavedPhotosAlbum(savePath, self, @selector(video:didFinishSavingWithError:contextInfo:), NULL);
    }

}
//每一张照片导入相册后回调此方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *) error contextInfo:(void *) contextInfo{
    
    if (!error) {
        NSLog(@"照片导入相册成功");
    }
    
}
//每一个视频导入相册后回调此方法
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (!error) {
        //每次导入相册后 将沙盒路径下的视频移除
        [[NSFileManager defaultManager] removeItemAtPath:videoPath error:nil];
        NSLog(@"视频导入相册成功");
    }
}
@end
