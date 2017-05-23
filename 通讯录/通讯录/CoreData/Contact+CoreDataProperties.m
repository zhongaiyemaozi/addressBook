//
//  Contact+CoreDataProperties.m
//  通讯录
//
//  Created by 夜猫子 on 2017/5/23.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "Contact+CoreDataProperties.h"

@implementation Contact (CoreDataProperties)

+ (NSFetchRequest<Contact *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
}

@dynamic name;
@dynamic namePinYin;
@dynamic phoneNum;
@dynamic sectionName;

@end
