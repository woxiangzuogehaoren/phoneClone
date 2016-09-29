//
//  Header.h
//  bonjourDemo
//
//  Created by 赵一帆 on 16/4/6.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#ifndef Header_h
#define Header_h
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define WeakSelf __weak __typeof(&*self)weakSelf =self
#define SOCKETPORT  5555

//bonjour 配置相关
static NSString * const KBonjourType = @"_bonjour._tcp.";
static NSString * const KDomainString = @"local.";
static NSString * const KBrowserDomainString = @"local";
//版本适配
#define ISIOS5 ([[[UIDevice currentDevice]sytemVersion]floatValue]>=5.0)
#define ISIOS6 ([[[UIDevice currentDevice]sytemVersion]floatValue]>=6.0)
#define ISIOS7 ([[[UIDevice currentDevice]sytemVersion]floatValue]>=7.0)
#define ISIOS8 ([[[UIDevice currentDevice]sytemVersion]floatValue]>=8.0)
#define ISIOS9 ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
//通讯录数据
#define CONTACTDATA 1
//图片数据
#define IMAGEDATA 2
//视频数据
#define VIDEODATA 3
//传输通讯的结束符
#define CONTACT @"The end character of the transmission of the address book data"

#endif /* Header_h */
