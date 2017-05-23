//
//  ContactAddVC.m
//  01-九期通讯录
//
//  Created by HM09 on 2017/5/23.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "ContactAddVC.h"
#import "CLCoreDataManager.h"
#import "CommonTool.h"
#import "Contact+CoreDataClass.h"

@interface ContactAddVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@end

@implementation ContactAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//取消
- (IBAction)leftButtonClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//保存
- (IBAction)rightButtinClick:(id)sender {
    
    //1.实际开发中第一件事应该做格式判断以及非空判断
    
    //2.数据库新增模型数据
    
    //2.1  创建数据
    Contact *contact = [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:kCLCoreDataManager.managedObjectContext];
    //2.2 赋值
    contact.name = self.nameTextField.text;
    contact.phoneNum = self.phoneNumTextField.text;
    contact.namePinYin = [CommonTool getPinYinFromString:contact.name];
    contact.sectionName = [[contact.namePinYin substringToIndex:1] uppercaseString];
    
    //2.3 保存到数据库
    [kCLCoreDataManager save];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
