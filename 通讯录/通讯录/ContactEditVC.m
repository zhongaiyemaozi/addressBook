//
//  ContactEditVC.m
//  01-九期通讯录
//
//  Created by HM09 on 2017/5/23.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "ContactEditVC.h"
#import "CommonTool.h"
#import "CLCoreDataManager.h"

@interface ContactEditVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@end

@implementation ContactEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //显示当前的模型数据
    self.nameTextField.text = self.contact.name;
    self.phoneNumTextField.text = self.contact.phoneNum;
    // Do any additional setup after loading the view.
}
- (IBAction)leftButtonClick:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)rightButtonClick:(id)sender {
    
    //1.实际开发中第一件事应该做格式判断以及非空判断
    
    //2.数据库修改模型数据
    
    
    //2.1 赋值
    self.contact.name = self.nameTextField.text;
    self.contact.phoneNum = self.phoneNumTextField.text;
    self.contact.namePinYin = [CommonTool getPinYinFromString:self.contact.name];
    self.contact.sectionName = [[self.contact.namePinYin substringToIndex:1] uppercaseString];
    
    //2.2 保存到数据库
    [kCLCoreDataManager save];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
