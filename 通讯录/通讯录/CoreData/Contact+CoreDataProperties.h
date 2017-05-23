//
//  Contact+CoreDataProperties.h
//  通讯录
//
//  Created by 夜猫子 on 2017/5/23.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "Contact+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Contact (CoreDataProperties)

+ (NSFetchRequest<Contact *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *namePinYin;
@property (nullable, nonatomic, copy) NSString *phoneNum;
@property (nullable, nonatomic, copy) NSString *sectionName;

@end

NS_ASSUME_NONNULL_END
