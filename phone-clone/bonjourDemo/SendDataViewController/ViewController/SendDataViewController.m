//
//  SendDataViewController.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/15.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "SendDataViewController.h"
#import "BarButtonItem.h"
#import "SendDataView.h"
#import "ContactModel.h"
#import "GetAlbumPicturesModel.h"
#import "AlbumViewController.h"
//#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>
#import "QBImagePickerController.h"
@interface SendDataViewController ()<BarButtonItemDelegate,SendDataViewDelegate,QBImagePickerControllerDelegate,GCDAsyncSocketDelegate>
@property (nonatomic,strong)SendDataView * sendData ;
@property (nonatomic,strong)GetAlbumPicturesModel * getAlbumPictures;
@property (nonatomic,strong)ContactModel * contactModel;

@property (nonatomic,strong)CNContact * contact;
//所有联系人的data数据
@property (nonatomic,strong) NSData * allContactData;
//所有图片的data数据
@property (nonatomic,strong) NSData * allImageData;
//所有视频的data数据
@property (nonatomic,strong) NSData * allVideoData;

@property (nonatomic,strong) NSData * endSymbolData;

@property (nonatomic,strong) ConnectionService * connectionService;
@end

static BOOL whetherAll = NO;

@implementation SendDataViewController
-(void)viewWillAppear:(BOOL)animated{
    
    self.title = @"选择数据";
    self.navigationController.navigationBar.subviews.firstObject.alpha=0;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                    
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
    self.view.backgroundColor = [UIColor whiteColor];
    
    BarButtonItem * leftButton = [[BarButtonItem alloc]init];
    leftButton = [leftButton initWithLeftButtonImageName:@"arrow_left"];
    leftButton.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareWork];
    [self getTheNumberOfBackupData];

}
//加载View
-(void)prepareWork{
    
    self.sendData = [[SendDataView alloc]init];
    self.sendData.delegate = self;
    [self.view addSubview:self.sendData];
    [self.sendData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.view.height-64);
    }];
    
    
}
//获取备份数据的数量
-(void)getTheNumberOfBackupData{
    
    self.allContactData = [NSData data];
    self.allImageData = [NSData data];
    self.allVideoData = [NSData data];
    self.endSymbolData = [NSData data];
    //加上结束符
    self.endSymbolData = [CONTACT dataUsingEncoding:NSUTF8StringEncoding];
    [self.sendData displayPhotoNumber:0];
    [self.sendData displayVideoNumber:0];
    
    //获取通讯录中的联系人个数
    self.contactModel = [ContactModel shareContactModel];
    [self.sendData displayContactNumber:self.personCount];
    
}

#pragma mark - BarButtonItemDelegate
-(void)leftBarButtonClick{
    whetherAll = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - SendDataViewDelegate
-(void)selectButtonTag:(NSInteger)tag{
 //1:通讯录,2:照片,3:视频,4:发送,5:全选
    switch (tag) {
        case 1:
            [self getContactInformation];
            break;
        case 2:
            [self enterTheAlbumListPage];

            break;
        case 3:{

            [self.getAlbumPictures getTheVideoAlbumUnderThePictures];
            self.getAlbumPictures.albumUnderTheVideo = ^(NSMutableArray * albunmUnderAllVideo){
                
            };
        }
            break;
        case 4:
            [self sendContactData];
        
            break;
        case 5:
            [self changeButtonIcon];
            break;
        default:
            break;
    }
    
}
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    
    NSLog(@"消息发送成功");
    
}
//发送数据
-(void)sendContactData{
    
    NSMutableData * data = [[NSMutableData alloc]init];
    [data appendData:self.allContactData];
    [data appendData:self.endSymbolData];
    
    
    if ([data length]>[self.endSymbolData length]) {
        self.socket.delegate = self;
       [self.socket writeData:data withTimeout:-1 tag:CONTACTDATA];
    }
    
    
    
}
//全选Button的图片状态
-(void)changeButtonIcon{
    
    if (whetherAll) {
        
       [self.sendData.selectButton setBackgroundImage:[UIImage imageNamed:@"feiquanxuan"] forState:UIControlStateNormal];
        whetherAll = NO;
        self.sendData.transmitDataInfoLabel.hidden = YES;
    }else{
        
        NSString * data = [NSString stringWithFormat:@"18KB"];
        NSString * time = [NSString stringWithFormat:@"少于1分"];
       
       [self.sendData labelTextColorDataSize:data withTransmissionTime:time];
       [self.sendData.selectButton setBackgroundImage:[UIImage imageNamed:@"quanxuan"] forState:UIControlStateNormal];
        
        whetherAll = YES;
    }
    
    
}
//获取所有备份的数据
-(void)selectAllBackupData{
    
    __weak SendDataViewController * weakSelf = self;
    //获取视频的data数据
    [self.getAlbumPictures getTheVideoAlbumUnderThePictures];
    self.getAlbumPictures.albumUnderTheVideo = ^(NSMutableArray * albunmUnderAllVideo){
        
      weakSelf.allVideoData =  [weakSelf.getAlbumPictures conversionData:albunmUnderAllVideo];
    };
    //获取图片data数据
    [self.getAlbumPictures getThePhotoAlbumUnderThePictures];
    self.getAlbumPictures.albumUnderTheImage = ^(NSMutableArray * albunmUnderAllImage){
        
       weakSelf.allImageData = [weakSelf.getAlbumPictures conversionData:albunmUnderAllImage];
    };
}
//进入图片列表页面
-(void)enterTheAlbumListPage{
    
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = (YES);
    [self.navigationController pushViewController:imagePickerController animated:YES];
    
}
#pragma mark - QBImagePickerControllerDelegate
//导航栏返回
- (void)dismissImagePickerController{

    [self.navigationController popViewControllerAnimated:YES];

}
//返回选的图片数组回调方法
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets{
    NSLog(@"选择的图片");
    [self dismissImagePickerController];
}
//导航栏返回按钮的代理
- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{

    [self dismissImagePickerController];
}




#pragma mark - 实现CNContactPickerViewController的代理方法
//测试=========调出系统的通讯录
-(void)getContactInformation{
    
    if (ISIOS9) {
        NSLog(@"9999999");
      self.allContactData = [self.contactModel getAllContacts];
        
    }else{
        NSLog(@"7~~~~~~~~8");
      self.allContactData = [self.contactModel getAllPerson];
    }
    
//    // 1. 创建控制器
//    CNContactPickerViewController * picker = [CNContactPickerViewController new];
//    // 2. 设置代理
//    picker.delegate = self;
//    // 4. 弹出
//    [self presentViewController: picker  animated:YES completion:nil];
    
    
}
////详情
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
//    
//    NSLog(@"获取一个人的通讯录信息");
//    
//    self.contact = [[CNContact alloc]init];
//    self.contact = contactProperty.contact;
//    NSArray * contactArray = [NSArray arrayWithObject:self.contact];
//    self.allContactData = [CNContactVCardSerialization dataWithContacts:contactArray error:nil];
//    NSLog(@"%ld",contactArray.count);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
