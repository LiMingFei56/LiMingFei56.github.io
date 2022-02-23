---
layout: post
title: "iOS UICollectionView"
categories: ios
tags: [ios]
date: 2022-02-23
---

## iOS UICollectionView

UICollectionView
UICollectionReusableView
UICollectionViewCell

	[_myCollection registerNib:[UINib nibWithNibName:@"XPDMainMyHeaderCRV" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XPDMainMyHeaderCRV"];
	[_myCollection registerNib:[UINib nibWithNibName:@"XPDMainMyCell" bundle:nil] forCellWithReuseIdentifier:@"XPDMainMyCell"];
	
	_myCollection.delegate = self;
	_myCollection.dataSource = self;
	
	_myCollection.showsVerticalScrollIndicator = NO;

### UICollectionView 注册

> Cell 和 ReusableView 先需要设置ReuseIdentifier

	// 注册cell
	registerNib:forCellWithReuseIdentifier: // 有Nib
	registerClass:forCellWithReuseIdentifier: // 无Nib
	// 通过id获取注册cell
	dequeueReusableCellWithReuseIdentifier:forIndexPath:
	// 获取可配置cell
	dequeueConfiguredReusableCellWithRegistration:forIndexPath:item:

	// 注册ReusableView
	registerNib:forSupplementaryViewOfKind:withReuseIdentifier:
	registerClass:forSupplementaryViewOfKind:withReuseIdentifier:
	// 通过id获取注册ReusableView
	dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
	// 获取可配置ReusableView
	dequeueConfiguredReusableSupplementaryViewWithRegistration:forIndexPath:

### UICollectionView - UICollectionViewDataSource 接口

	// section下item的数量
	collectionView:numberOfItemsInSection:
	// section数量
	numberOfSectionsInCollectionView:
	// 创建cell
	collectionView:cellForItemAtIndexPath:
	// 创建ReusableView
	collectionView:viewForSupplementaryElementOfKind:atIndexPath:

### UICollectionView - UICollectionViewDelegate 接口

	// cell点击
	collectionView:didSelectItemAtIndexPath:


### 自定义布局

> UICollectionViewFlowLayout 继承 UICollectionViewLayout, 如果是简单布局, 可以使用
> UICollectionViewFlowLayout实现. 使用UICollectionViewLayout 需要实现很多方法.

	UICollectionViewFlowLayout.itemSize - cell大小
	UICollectionViewFlowLayout.scrollDirection - 滑动方向
	UICollectionViewFlowLayout.sectionInset - section块的距离
	UICollectionViewFlowLayout.headerReferenceSize - ReusableViewHeader的大小

	CGFloat availableWidth = _myCollection.bounds.size.width;
	CGFloat cellWidth = availableWidth / 4.0 - 30;
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.itemSize = CGSizeMake(cellWidth, 80);
	layout.scrollDirection = UICollectionViewScrollDirectionVertical;
	layout.sectionInset = UIEdgeInsetsMake(3, 16, 10, 16);
	layout.headerReferenceSize = CGSizeMake(availableWidth, 60);
	_myCollection.collectionViewLayout = layout;

### Reference

