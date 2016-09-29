//
//  AddressBook.m
//  bonjourDemo
//
//  Created by wuqitao on 16/4/20.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import "ContactModel.h"
#import "LoadingFrame.h"
@interface ContactModel()
@end
static ContactModel * _contactModel = nil;



@implementation ContactModel

+(instancetype)shareContactModel{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _contactModel = [[ContactModel alloc]init];

    });

    return _contactModel;
}
#pragma mark - iOS7~8通讯录授权
-(void)addressBookAuthorization{

    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                NSLog(@"授权成功！");
                CFRelease(addressBook);
            } else {
                NSLog(@"授权失败!");
                CFRelease(addressBook);
            }
        });
    }
}
#pragma mark - iOS9通讯录授权
-(void)contactBookAuthorization{
    // 1.获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    // 2.判断授权状态,如果是未决定请求授权
    if (status == CNAuthorizationStatusNotDetermined) {
        // 3.请求授权
        // 3.1.创建CNContactStore对象
        CNContactStore *store = [[CNContactStore alloc] init];
        
        // 3.2.请求授权
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error);
                return;
            }
            if (granted) {
                NSLog(@"授权成功");
            } else {
                NSLog(@"授权失败");
            }
        }];
    }
}

-(NSInteger)getNumberOfContacts{
    
   __block NSInteger contactsNum;
    
   if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        //创建通讯录
        //读取通讯录人员数量
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        CFIndex personCount = ABAddressBookGetPersonCount(addressBookRef);
        contactsNum = personCount;
        //xxx
        CFRelease(addressBookRef);
    } else {
       // 更新界面
       [[[UIAlertView alloc]initWithTitle:@"提示" message:@"无法获取您的联系人\n请在设置中修改" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        return 0;
    }
    return contactsNum;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"queding");
    
}
#pragma mark--iOS7~8获取联系人并转成nsdata类型
-(NSData*)getAllPerson{
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //拿到所有联系人
        CFArrayRef peopleArray = ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        CFDataRef vcards = (CFDataRef)ABPersonCreateVCardRepresentationWithPeople(peopleArray);
        
        NSData * contatcsData = (__bridge NSData *)vcards;
        
        return contatcsData;
        
    } else {
        
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"无法获取您的联系人\n请在设置中修改" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        return 0;
        
    }
   
    
}
#pragma mark--iOS9获取联系人
-(NSData*)getAllContacts{
    //获取授权状态，没授权提示设置
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status != CNAuthorizationStatusAuthorized){
        
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"无法获取您的联系人\n请在设置中修改" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
        return 0;
        
    }else{
        
        CNContactStore * contactStore = [[CNContactStore alloc]init];
        
        NSArray * keyArray = [self contactKey];
        
        CNContactFetchRequest * fetchRequet = [[CNContactFetchRequest alloc]initWithKeysToFetch:keyArray];
        fetchRequet.predicate = nil;
        NSArray * array = [contactStore unifiedContactsMatchingPredicate:fetchRequet.predicate keysToFetch:fetchRequet.keysToFetch error:nil];
        
        NSError * error = nil;
        NSData * contactData;
        if (array.count>0) {
            //采用该方法 头像会丢失
          contactData  = [CNContactVCardSerialization dataWithContacts:array error:&error];
            
        }
        if (error) {
            
             NSLog(@"error====%@",error);
            return 0;
        }
        //头像不会丢失 需要循环取值
       // contactData = [self accessToAddressBook];
        
        return contactData;
        
    }
    
}
-(NSData*)accessToAddressBook{
    CNContactStore * contactStore = [[CNContactStore alloc]init];
    
    NSArray * keyArray = [self contactKey];
    
    CNContactFetchRequest * fetchRequet = [[CNContactFetchRequest alloc]initWithKeysToFetch:keyArray];
    fetchRequet.predicate = nil;
    NSMutableArray * array = [NSMutableArray array];
    NSData * contactData;
    [contactStore enumerateContactsWithFetchRequest:fetchRequet error:nil usingBlock:^(CNContact *_Nonnull contact, BOOL *_Nonnull stop) {
        [array addObject:contact];
        NSLog(@"array==%lu",(unsigned long)array.count);
        
    }];
    NSLog(@"获取结束");
    if (array.count>0) {
         contactData = [self conversionData:array];
        return contactData;
    }else{
        
        return 0;
    }
   
    
    
    
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
#pragma mark--获取联系人所有信息数组
-(NSArray*)contactKey{
    
    NSArray *keysToFetch =@[[CNContactVCardSerialization descriptorForRequiredKeys]];
    
    return keysToFetch;
}

#pragma mark--iOS7~8写入通讯
-(void)inputAdressBook:(NSData*)data{
    
    CFDataRef vcard=(__bridge CFDataRef)data ;
    CFArrayRef person = ABPersonCreatePeopleInSourceWithVCardRepresentation(NULL,vcard);
    NSMutableArray* addressBookArray = (__bridge NSMutableArray*)person;
    //创建一个通讯录操作对象
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    __block int i=0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (; i < addressBookArray.count; i++) {
            
            ABRecordRef p = (__bridge ABRecordRef)addressBookArray[i];
            ABAddressBookAddRecord(addressBook, p, NULL);
            ABAddressBookSave(addressBook, NULL);
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                static int num = 0;
                num = num+1;
                [self.delegate beingWrittenNumber:num withTotal:addressBookArray.count];
                
                if (num==addressBookArray.count) {

                    [self.delegate completeWrite];
                    LoadingFrame * loadFrame = [LoadingFrame single];
                    num = 0;
                    [loadFrame addFinish:@"通讯录添加完成"];

                    if (addressBook) {
                        CFRelease(addressBook);
                    }
                }
                
            });

        }
 
    });
  
}


#pragma mark--iOS9添加联系人到通讯录
-(NSArray*)addContactsToAddressBook:(NSData*)personData{

    NSArray * personArray = [CNContactVCardSerialization contactsWithData:personData error:nil];
//    NSMutableArray * personArray = [self dataConversionArray:personData];
    __block int i=0;
//  初始化方法
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        for (; i < personArray.count; i++) {
           //放入自动释放池中
            @autoreleasepool {

                CNMutableContact * contact = [personArray[i] mutableCopy];
                CNSaveRequest * saveRequest = [[CNSaveRequest alloc]init];
                CNContactStore * store = [[CNContactStore alloc]init];
                //添加联系人
                [saveRequest addContact:contact toContainerWithIdentifier:nil];
                //保存请求
                [store executeSaveRequest:saveRequest error:nil];
   
            }
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                static int num = 0;
                num = num+1;
                [self.delegate beingWrittenNumber:num withTotal:personArray.count];
                if (num==personArray.count) {

                    [self.delegate completeWrite];
                    LoadingFrame * loadFrame = [LoadingFrame single];
                    num = 0;
                    [loadFrame addFinish:@"通讯录添加完成"];
                }
                
            });
 
        }

    });

    return personArray;
}

@end
