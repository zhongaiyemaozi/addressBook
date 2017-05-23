//
//  CLCoreDataManager.h
//  CoreDataStack封装
//
//  Created by 夜猫子 on 2017/5/22.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#define kCLCoreDataManager [CLCoreDataManager shareInstane]

#define kFileName @"cl"

@interface CLCoreDataManager : NSObject

+(CLCoreDataManager *)shareInstane;

#pragma mark CoreData Stack

//core data Stack技术栈堆容器
@property(nonatomic,strong)NSPersistentContainer *persistentContainer;

//管理对象上下文
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;

- (void)save;

- (void)deletAllEntities;

@end
