//
//  WPArrayDataSource.m
//  WPPet1718
//
//  Created by tusm on 2017/7/4.
//  Copyright © 2017年 CWP. All rights reserved.
//

#import "WPDataSource.h"

@interface WPDataSource ()
@property (nonatomic,strong)NSArray *items;
@property (nonatomic,copy)NSString *cellIdentifier;
@property (nonatomic,copy)WPCellConfigureBlock configureCellBlock;
@end

@implementation WPDataSource
- (instancetype)init
{
    return nil;
}
- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(WPCellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    if (self) {
        _items = anItems;
        _cellIdentifier = aCellIdentifier;
        _configureCellBlock = aConfigureCellBlock;
    }
    return self;
}
- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier numberOfSectionBlock:(WPNumberOfSectionsBlock)aNumberOfSectionsBlock configureCellBlock:(WPCellConfigureBlock)aConfigureCellBlock
{
    self = [self initWithItems:anItems cellIdentifier:aCellIdentifier configureCellBlock:aConfigureCellBlock];
    if (self) {
        _aNumberOfSectionsBlock = aNumberOfSectionsBlock;
    }
    return self;
}
- (id)itemAtIndexPath:(NSIndexPath *)indexPaht
{
    if (self.aItemAtIndexPathBlock) {
        return self.aItemAtIndexPathBlock(indexPaht,self.items);
    }else{
        if (self.items.count < 1) {
            return nil;
        }
        return self.items[(NSInteger)indexPaht.row];
    }
}
- (id)preItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger preRow = indexPath.row-1;
    if (preRow<0) {
        return nil;
    }else{
        NSIndexPath *preIndexPath = [NSIndexPath indexPathForRow:preRow inSection:indexPath.section];
        
        return [self itemAtIndexPath:preIndexPath];
    }
}
- (void)setItems:(NSArray *)items
{
    _items = items;
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.aNumberOfSectionsBlock) {
        return self.aNumberOfSectionsBlock();
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.aNumberOfRowInSectionBlock) {
        return self.aNumberOfRowInSectionBlock(section,self.items);
    }
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifiers = [self cellIdentifierWith:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifiers forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    
    self.configureCellBlock(cell,item,indexPath);
    
    return cell;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.aSectionIndexTitles) {
        return self.aSectionIndexTitles();
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(self.aSectionForSectionTitleAtIndex){
        return self.aSectionForSectionTitleAtIndex(title,index);
    }
    return 0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.aTitleForHeaderInSection) {
        return self.aTitleForHeaderInSection(section);
    }
    return nil;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.aCanEditBlock){
        return self.aCanEditBlock(indexPath);
    }
    return NO;
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.aNumberOfSectionsBlock) {
        return self.aNumberOfSectionsBlock();
    }
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.aNumberOfRowInSectionBlock) {
        return self.aNumberOfRowInSectionBlock(section,self.items);
    }
    return self.items.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifiers = [self cellIdentifierWith:indexPath];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifiers forIndexPath:indexPath];
    
    id model = [self itemAtIndexPath:indexPath];
    
    self.configureCellBlock(cell,model,indexPath);
    
    return cell;
}

#pragma mark -- Private
- (NSString *)cellIdentifierWith:(NSIndexPath *)indexPath
{
    NSString *identifier = nil;
    
    if (self.aCellIdentifierBlock) {
        identifier = self.aCellIdentifierBlock(indexPath);
    }else{
        identifier = self.cellIdentifier;
    }
    
//    identifier = identifier.length<1?self.cellIdentifier:identifier;
    
//    DebugLog(@"=========%@===%@=========",identifier?:self.cellIdentifier,indexPath);
    
    return identifier?:self.cellIdentifier;
    
}
#pragma mark -- comm
- (NSArray *)dataSource
{
    return _items;
}
@end
