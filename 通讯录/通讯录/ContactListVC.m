//
//  ContactListVC.m
//  01-九期通讯录
//
//  Created by HM09 on 2017/5/23.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "ContactListVC.h"
#import "CLCoreDataManager.h"
#import "Contact+CoreDataClass.h"

#import "ContactEditVC.h"

@interface ContactListVC ()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,UISearchBarDelegate>

//狂拽裤线吊炸点
@property(nonatomic,strong)NSFetchedResultsController *fetchedResultsController;

@end

@implementation ContactListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
       NSLog(@"%@", NSHomeDirectory());
    
    UISearchBar *searBar = [[UISearchBar alloc] init];
    searBar.tag = 2222;
    searBar.delegate = self;
    self.navigationItem.titleView = searBar;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark -UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //1,将搜索的文本变为小写
    searchText = [searchText lowercaseString];
    
    NSPredicate *predicate;
    
    if (searchText.length > 0) {
        predicate = [NSPredicate predicateWithFormat:@"self.name CONTAINS %@ || self.namePinYin CONTAINS %@ || self.phoneNum CONTAINS %@",searchText,searchText,searchText];
    }
    else//搜索所有数据
    {
        predicate = nil;
    }
    //2.改变查询结果控制器查询请求的谓词即可
    self.fetchedResultsController.fetchRequest.predicate = predicate;
    //3.重新执行查询请求
    [self.fetchedResultsController performFetch:nil];
    
    //4.刷新tableView
    [self.tableView reloadData];
}
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    //1.创建查询请求
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
    
    //注意:使用查询结果控制器一定要给查询请求添加一个排序否则程序会崩溃报错:An instance of NSFetchedResultsController requires a fetch request with sort descriptors
    
    //key:排序依据  ascending:是否升序
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"namePinYin" ascending:YES]];
    
    
    //2.创建查询结果控制器
    /**
     Request:查询请求
     managedObjectContext:管理对象上下文
     sectionNameKeyPath:分组依据
     cacheName:缓存的名字 一般为nil
     */
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:kCLCoreDataManager.managedObjectContext sectionNameKeyPath:@"sectionName" cacheName:nil];
    
    //3.开始执行查询请求
    [_fetchedResultsController performFetch:nil];
    
    //4.设置代理
    _fetchedResultsController.delegate = self;
    
    //刷新tableview数据
    [self.tableView reloadData];
    
    return _fetchedResultsController;
}

#pragma mark - Table view data source

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UISearchBar *bar = [self.navigationItem.titleView viewWithTag:2222];
    if ([bar isFirstResponder]) {
        [bar resignFirstResponder];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    //返回查询结果组的数量
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //获取对应组的下标的数组
    id<NSFetchedResultsSectionInfo>info = self.fetchedResultsController.sections[section];
    //返回对应组的下标的数组的数量
    return info.numberOfObjects;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactListVCCell"];
    
    //获取对应索引的内容
   
    Contact *contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.phoneNum;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //获取组标题数组对应下标的文字
    return self.fetchedResultsController.sectionIndexTitles[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

//编辑相关三个代理

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获取点击下标的对应的模型数据
    Contact *contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //2.上下文删除数据
    [kCLCoreDataManager.managedObjectContext deleteObject:contact];
    
    //3.保存到数据库
    [kCLCoreDataManager save];
}

//索引栏相关两个代理

//点击索引栏会调用
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    return index;
}

//索引栏文本

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sectionIndexTitles;
}

#pragma mark -NSFetchedResultsControllerDelegate

//监听数据库内容的变化
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath
{
    [self.tableView reloadData];
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[ContactEditVC class]]) {
        ContactEditVC *editVC = (ContactEditVC *)segue.destinationViewController;
        //获取tablView选中的下标
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //根据选中下标获取对象模型
        Contact *contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
        editVC.contact = contact;
    }
}


@end
