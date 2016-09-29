//
//  QBImagePickerController.m
//  QBImagePickerController
//
//  Created by Tanaka Katsuma on 2013/12/30.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "QBImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "BarButtonItem.h"
// Views
#import "QBImagePickerGroupCell.h"
#import "QBAssetsCollectionViewLayout.h"

// ViewControllers
#import "QBAssetsCollectionViewController.h"

ALAssetsFilter * ALAssetsFilterFromQBImagePickerControllerFilterType(QBImagePickerControllerFilterType type) {
    switch (type) {
        case QBImagePickerControllerFilterTypeNone:
            return [ALAssetsFilter allAssets];
            break;
            
        case QBImagePickerControllerFilterTypePhotos:
            return [ALAssetsFilter allPhotos];
            break;
            
        case QBImagePickerControllerFilterTypeVideos:
            return [ALAssetsFilter allVideos];
            break;
    }
}

@interface QBImagePickerController () <QBAssetsCollectionViewControllerDelegate,BarButtonItemDelegate>
@property (nonatomic, strong) UIButton * completeButton;
@property (nonatomic, strong, readwrite) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, copy, readwrite) NSArray *assetsGroups;
@property (nonatomic, strong, readwrite) NSMutableSet *selectedAssetURLs;
@property (nonatomic,strong)QBImagePickerGroupCell *cell;
@end

@implementation QBImagePickerController

+ (BOOL)isAccessible
{
    return ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] &&
            [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]);
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        // Property settings
        self.selectedAssetURLs = [NSMutableSet set];
        
        self.groupTypes = @[
                            @(ALAssetsGroupSavedPhotos),
                            @(ALAssetsGroupPhotoStream),
                            @(ALAssetsGroupAlbum)
                            ];
        self.filterType = QBImagePickerControllerFilterTypeNone;
        self.showsCancelButton = YES;
        
        // View settings
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // Create assets library instance
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        self.assetsLibrary = assetsLibrary;
        
        // Register cell classes
        [self.tableView registerClass:[QBImagePickerGroupCell class] forCellReuseIdentifier:@"GroupCell"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.title = @"选择图片";
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.subviews.firstObject.alpha=1;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    // View controller settings
//    self.title = NSLocalizedStringFromTable(@"title", @"1", nil);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Load assets groups
    [self loadAssetsGroupsWithTypes:self.groupTypes
                         completion:^(NSArray *assetsGroups) {
                             self.assetsGroups = assetsGroups;
                             
                             [self.tableView reloadData];
                         }];
   
    // Validation
    [self changeButtonState];
    
}
-(void)changeButtonState{
    
    if ([self validateNumberOfSelections:self.selectedAssetURLs.count]) {
        
        [self.completeButton setTitleColor:[UIColor colorWithRed:30.0/255 green:144.0/255 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        self.completeButton.enabled = [self validateNumberOfSelections:self.selectedAssetURLs.count];
        
    }else{
        
        [self.completeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.completeButton.enabled = [self validateNumberOfSelections:self.selectedAssetURLs.count];
    }
}

#pragma mark - Accessors

- (void)setShowsCancelButton:(BOOL)showsCancelButton
{
    _showsCancelButton = showsCancelButton;
    
    // Show/hide cancel button
    if (showsCancelButton) {
        BarButtonItem * leftButton = [[BarButtonItem alloc]init];
        leftButton = [leftButton initWithLeftButtonImageName:@"fanhuiBut"];
        leftButton.delegate = self;
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        [self.navigationItem setLeftBarButtonItem:cancelButton animated:NO];
    } else {
        [self.navigationItem setLeftBarButtonItem:nil animated:NO];
    }
}

- (void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection
{
    _allowsMultipleSelection = allowsMultipleSelection;
    
    // Show/hide done button
    if (allowsMultipleSelection) {
         self.completeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [self.completeButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
        [self.completeButton setTitle:@"完成" forState:UIControlStateNormal];
        self.completeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.completeButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithCustomView:self.completeButton];
        [doneButton setStyle:UIBarButtonItemStyleDone];
        [self.navigationItem setRightBarButtonItem:doneButton animated:NO];
    } else {
        [self.navigationItem setRightBarButtonItem:nil animated:NO];
    }
}


#pragma mark - Actions

- (void)done:(id)sender
{
    NSLog(@"wangcheng");
    [self passSelectedAssetsToDelegate];
}
-(void)leftBarButtonClick{
    // Delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [self.delegate imagePickerControllerDidCancel:self];
    }
}
- (void)cancel:(id)sender
{
    
}


#pragma mark - Validating Selections

- (BOOL)validateNumberOfSelections:(NSUInteger)numberOfSelections
{
    // Check the number of selected assets
    NSUInteger minimumNumberOfSelection = MAX(1, self.minimumNumberOfSelection);
    BOOL qualifiesMinimumNumberOfSelection = (numberOfSelections >= minimumNumberOfSelection);
    
    BOOL qualifiesMaximumNumberOfSelection = YES;
    if (minimumNumberOfSelection <= self.maximumNumberOfSelection) {
        qualifiesMaximumNumberOfSelection = (numberOfSelections <= self.maximumNumberOfSelection);
    }
    
    return (qualifiesMinimumNumberOfSelection && qualifiesMaximumNumberOfSelection);
}


#pragma mark - Managing Assets

- (void)loadAssetsGroupsWithTypes:(NSArray *)types completion:(void (^)(NSArray *assetsGroups))completion
{
    __block NSMutableArray *assetsGroups = [NSMutableArray array];
    __block NSUInteger numberOfFinishedTypes = 0;
    
    for (NSNumber *type in types) {
        __weak typeof(self) weakSelf = self;
        
        [self.assetsLibrary enumerateGroupsWithTypes:[type unsignedIntegerValue]
                                          usingBlock:^(ALAssetsGroup *assetsGroup, BOOL *stop) {
                                              if (assetsGroup) {
                                                  // Filter the assets group
                                                  [assetsGroup setAssetsFilter:ALAssetsFilterFromQBImagePickerControllerFilterType(weakSelf.filterType)];
                                                  
                                                  if (assetsGroup.numberOfAssets > 0) {
                                                      // Add assets group
                                                      [assetsGroups addObject:assetsGroup];
                                                  }
                                              } else {
                                                  numberOfFinishedTypes++;
                                              }
                                              
                                              // Check if the loading finished
                                              if (numberOfFinishedTypes == types.count) {
                                                  // Sort assets groups
                                                  NSArray *sortedAssetsGroups = [self sortAssetsGroups:(NSArray *)assetsGroups typesOrder:types];
                                                  
                                                  // Call completion block
                                                  if (completion) {
                                                      completion(sortedAssetsGroups);
                                                  }
                                              }
                                          } failureBlock:^(NSError *error) {
                                              NSLog(@"Error: %@", [error localizedDescription]);
                                          }];
    }
}

- (NSArray *)sortAssetsGroups:(NSArray *)assetsGroups typesOrder:(NSArray *)typesOrder
{
    NSMutableArray *sortedAssetsGroups = [NSMutableArray array];
    
    for (ALAssetsGroup *assetsGroup in assetsGroups) {
        if (sortedAssetsGroups.count == 0) {
            [sortedAssetsGroups addObject:assetsGroup];
            continue;
        }
        
        ALAssetsGroupType assetsGroupType = [[assetsGroup valueForProperty:ALAssetsGroupPropertyType] unsignedIntegerValue];
        NSUInteger indexOfAssetsGroupType = [typesOrder indexOfObject:@(assetsGroupType)];
        
        for (NSInteger i = 0; i <= sortedAssetsGroups.count; i++) {
            if (i == sortedAssetsGroups.count) {
                [sortedAssetsGroups addObject:assetsGroup];
                break;
            }
            
            ALAssetsGroup *sortedAssetsGroup = [sortedAssetsGroups objectAtIndex:i];
            ALAssetsGroupType sortedAssetsGroupType = [[sortedAssetsGroup valueForProperty:ALAssetsGroupPropertyType] unsignedIntegerValue];
            NSUInteger indexOfSortedAssetsGroupType = [typesOrder indexOfObject:@(sortedAssetsGroupType)];
            
            if (indexOfAssetsGroupType < indexOfSortedAssetsGroupType) {
                [sortedAssetsGroups insertObject:assetsGroup atIndex:i];
                break;
            }
        }
    }
    
    return [sortedAssetsGroups copy];
}

- (void)passSelectedAssetsToDelegate
{
    // Load assets from URLs
    __block NSMutableArray *assets = [NSMutableArray array];
    
    for (NSURL *selectedAssetURL in self.selectedAssetURLs) {
        __weak typeof(self) weakSelf = self;
        [self.assetsLibrary assetForURL:selectedAssetURL
                            resultBlock:^(ALAsset *asset) {
                                // Add asset
                                [assets addObject:asset];
                                
                                // Check if the loading finished
                                if (assets.count == weakSelf.selectedAssetURLs.count) {
                                    // Delegate
                                    if (self.delegate && [self.delegate respondsToSelector:@selector(imagePickerController:didSelectAssets:)]) {
                                        [self.delegate imagePickerController:self didSelectAssets:[assets copy]];
                                    }
                                }
                            } failureBlock:^(NSError *error) {
                                NSLog(@"Error: %@", [error localizedDescription]);
                            }];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.assetsGroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell" forIndexPath:indexPath];
    
    ALAssetsGroup *assetsGroup = [self.assetsGroups objectAtIndex:indexPath.row];
    self.cell.assetsGroup = assetsGroup;
    
    return self.cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    QBAssetsCollectionViewController *assetsCollectionViewController = [[QBAssetsCollectionViewController alloc] initWithCollectionViewLayout:[QBAssetsCollectionViewLayout layout]];
    assetsCollectionViewController.imagePickerController = self;
    assetsCollectionViewController.filterType = self.filterType;
    assetsCollectionViewController.allowsMultipleSelection = self.allowsMultipleSelection;
    assetsCollectionViewController.minimumNumberOfSelection = self.minimumNumberOfSelection;
    assetsCollectionViewController.maximumNumberOfSelection = self.maximumNumberOfSelection;
    
    ALAssetsGroup *assetsGroup = [self.assetsGroups objectAtIndex:indexPath.row];
    assetsCollectionViewController.delegate = self;
    assetsCollectionViewController.assetsGroup = assetsGroup;
    
    for (NSURL *assetURL in self.selectedAssetURLs) {
        [assetsCollectionViewController selectAssetHavingURL:assetURL];
    }
    
    [self.navigationController pushViewController:assetsCollectionViewController animated:YES];
}


#pragma mark - QBAssetsCollectionViewControllerDelegate

- (void)assetsCollectionViewController:(QBAssetsCollectionViewController *)assetsCollectionViewController didSelectAsset:(ALAsset *)asset
{
    if (self.allowsMultipleSelection) {
        // Add asset URL
        NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        [self.selectedAssetURLs addObject:assetURL];
        
        // Validation
        self.navigationItem.rightBarButtonItem.enabled = [self validateNumberOfSelections:self.selectedAssetURLs.count];
    }
}

- (void)assetsCollectionViewControllerDidFinishSelection:(QBAssetsCollectionViewController *)assetsCollectionViewController{

    
    [self passSelectedAssetsToDelegate];
}
//设置cell分割线从边框顶端开始
-(void)viewDidLayoutSubviews{
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
