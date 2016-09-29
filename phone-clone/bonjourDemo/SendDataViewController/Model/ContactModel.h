//
//  AddressBook.h
//  bonjourDemo
//
//  Created by wuqitao on 16/4/20.
//  Copyright © 2016年 ZYF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>

@protocol ContatctModelDelegate <NSObject>
@optional
//-(void)startWrite;
-(void)beingWrittenNumber:(NSInteger)number withTotal:(NSInteger)total;
-(void)completeWrite;

@end

@interface ContactModel : NSObject

@property (nonatomic,weak)id<ContatctModelDelegate>delegate;


+(instancetype)shareContactModel;
//ios7~8的通讯录授权
-(void)addressBookAuthorization;
//ios9通讯录授权
-(void)contactBookAuthorization;

//获取联系人个数iOS7~8
-(NSInteger)getNumberOfContacts;
//iOS7~8获取联系人
-(NSData*)getAllPerson;
//写入通讯 iOS7~8
-(void)inputAdressBook:(NSData*)data;
//获取联系人iOS9
-(NSData*)getAllContacts;
//添加联系人到通讯录ios9
-(NSArray*)addContactsToAddressBook:(NSData*)personData;
@end
