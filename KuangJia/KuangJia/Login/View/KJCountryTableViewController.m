//
//  KJtableViewController.m
//  KuangJia
//
//  Created by xb on 2018/10/29.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "KJCountryTableViewController.h"
#import "XBMacroDefinition.h"
#import "KJResultDisplayController.h"
#import "UIColor+KJHEX.h"
@interface KJCountryTableViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,KJResultDisplayControllerDelegate>

@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) NSMutableArray *indexArray; //索引数组
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation KJCountryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择国家和地区代码";
    NSString *countryPath = [[NSBundle mainBundle]pathForResource:@"country" ofType:@"plist" ];
    NSArray *arr = [NSArray arrayWithContentsOfFile:countryPath];
    self.dataSource = arr;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUSBAR_And_NAVIGATIONBAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    // 创建用于展示搜索结果的控制器
    KJResultDisplayController *result = [[KJResultDisplayController alloc]init];
    result.datas = [self.dataSource copy];
    result.delegate = self;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:result];
    self.searchController.searchResultsUpdater = result;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.showsCancelButton = YES;
    self.searchController.searchBar.placeholder = @"搜索";
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleDefault;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //解决：退出时搜索框依然存在的问题
    self.definesPresentationContext = YES;
    
    //索引数组
    self.indexArray  = [[NSMutableArray alloc]init];
    
    for (char ch='A'; ch<='Z'; ch++) {
        if (ch=='I' || ch=='O' || ch=='Q'|| ch=='U'||ch=='V')
        continue;
        [self.indexArray addObject:[NSString stringWithFormat:@"%c",ch]];
    }
}

#pragma mark 右侧索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

#pragma mark -  UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr= self.dataSource[section];
    return arr.count;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent = @"cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    
    NSArray *arr = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = arr[0];
    cell.detailTextLabel.text = [arr lastObject];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    
    view.backgroundColor = [UIColor kj_colorFromString:@"#F7F6F8"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 30)];
    label.text = [self.indexArray objectAtIndex:section];
    label.textColor = [UIColor grayColor];
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(searchCountry:)]) {
        [self.delegate searchCountry:cell.detailTextLabel.text];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

// called when keyboard search button pressed 键盘搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //    NSLog(@"%s",__func__);
    //    NSLog(@"searchBar.text = %@",searchBar.text);
    [self.tableView reloadData];
    [self.searchController.searchBar resignFirstResponder];
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
    //    self.searchController.active = NO;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)searchResult:(NSString *)country{
    if ([self.delegate respondsToSelector:@selector(searchCountry:)]) {
        [self.delegate searchCountry:country];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
