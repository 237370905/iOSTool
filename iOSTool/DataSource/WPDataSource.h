//
//  WPArrayDataSource.h
//  WPPet1718
//
//  Created by tusm on 2017/7/4.
//  Copyright © 2017年 CWP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NSInteger(^WPNumberOfSectionsBlock)(void);//返回section數量

typedef NSInteger(^WPNumberOfRowInSections)(NSInteger section,NSArray *models);//每個section中有多少cell

typedef NSString *(^WPCellIdentifierBlock)(NSIndexPath *indexPath);//cell标识,多个样式的cell实现该block

typedef void(^WPCellConfigureBlock)(id cell, id obj, NSIndexPath *indexPath); //設置Cell

typedef id(^WPItemAtIndexPathBlock)(NSIndexPath *indexPath,NSArray *models);//返回一個Model


//sectionIndexTitles
typedef NSArray<NSString *>*(^WPSectionIndexTitles)(void);//索引数组

typedef NSInteger(^WPSectionForSectionTitleAtIndex)(NSString *title,NSInteger index);

typedef NSString*(^WPTitleForHeaderInSection)(NSInteger section);


//edit
typedef BOOL(^WPCanEditRowAtIndexPath)(NSIndexPath *indexPath);

@interface WPDataSource : NSObject<UITableViewDataSource,UICollectionViewDataSource>

@property (nonatomic,copy)WPItemAtIndexPathBlock aItemAtIndexPathBlock;
@property (nonatomic,copy)WPNumberOfSectionsBlock aNumberOfSectionsBlock;
@property (nonatomic,copy)WPNumberOfRowInSections aNumberOfRowInSectionBlock;
@property (nonatomic,copy)WPCellIdentifierBlock aCellIdentifierBlock;

@property (nonatomic,copy)WPSectionIndexTitles aSectionIndexTitles;
@property (nonatomic,copy)WPSectionForSectionTitleAtIndex aSectionForSectionTitleAtIndex;
@property (nonatomic,copy)WPTitleForHeaderInSection aTitleForHeaderInSection;

@property (nonatomic,copy)WPCanEditRowAtIndexPath aCanEditBlock;

- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(WPCellConfigureBlock) aConfigureCellBlock;

- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier numberOfSectionBlock:(WPNumberOfSectionsBlock) aNumberOfSectionsBlock configureCellBlock:(WPCellConfigureBlock) aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (id)preItemAtIndexPath:(NSIndexPath *)indexPath; //前一个model

- (void)setItems:(NSArray *)items;//更新数据

@property (nonatomic,strong,readonly)NSArray *dataSource;
@end
