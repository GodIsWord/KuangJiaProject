//
//  KJCountryTableViewController.m
//  KuangJia
//
//  Created by xb on 2018/10/29.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "KJCountryTableViewController.h"
#import "XBMacroDefinition.h"
@interface KJCountryTableViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate>

@property(nonatomic, strong) UITableView *countryTableView;
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) NSMutableArray *indexArray; //索引数组
@property (nonatomic, strong) UISearchController * searchController;
@property (strong,nonatomic) NSMutableArray  *searchList;  //搜索结果

@end

@implementation KJCountryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择国家和地区代码";
    NSString *countryPath = [[NSBundle mainBundle]pathForResource:@"country" ofType:@"plist" ];
    NSArray *arr = [NSArray arrayWithContentsOfFile:countryPath];
    self.dataSource = arr;
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableVIew = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUSBAR_And_NAVIGATIONBAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    tableVIew.delegate = self;
    tableVIew.dataSource = self;
    [self.view addSubview:tableVIew];
    self.countryTableView = tableVIew;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.countryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    

    
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.showsCancelButton = YES;
    self.searchController.searchBar.placeholder = @"搜索";
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleDefault;
    ;
    
    
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //解决：退出时搜索框依然存在的问题
    self.definesPresentationContext = YES;
    
    //索引数组
    self.indexArray  = [[NSMutableArray alloc]init];

    for (char ch='A'; ch<='Z'; ch++) {
        if (ch=='I' || ch=='O' || ch=='U')
            continue;
        [self.indexArray addObject:[NSString stringWithFormat:@"%c",ch]];
    }
}


#pragma mark 设置组标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.indexArray objectAtIndex:section];
}

#pragma mark 右侧索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

#pragma mark -  UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active) {
        return [self.searchList count];
    }else{
        NSArray *arr= self.dataSource[section];
        return arr.count;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.searchController.active) {
        return 1;
    }else{
        return self.dataSource.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdent = @"cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    if (self.searchController.active&&self.searchList.count>0) {
        NSArray *arr = self.searchList[indexPath.row];
        cell.textLabel.text = arr[0];
        cell.detailTextLabel.text  = [arr lastObject];
    }
    else{
        NSArray *arr = self.dataSource[indexPath.section][indexPath.row];
        cell.textLabel.text = arr[0];
        cell.detailTextLabel.text = [arr lastObject];

    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(searchCountry:)]) {
        [self.delegate searchCountry:cell.detailTextLabel.text];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark UISearchResultsUpdating
// 每次更新搜索框里的文字，就会调用这个方法
// 根据输入的关键词及时响应：里面可以实现筛选逻辑  也显示可以联想词
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    // 获取搜索框里地字符串
    NSString *searchString = searchController.searchBar.text;
    if (searchString.length<=0) {
        return;
    }
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //加个多线程，否则数量量大的时候，有明显的卡顿现象
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        if (searchString!=nil && searchString.length>0) {
            
            //遍历需要搜索的所有内容，其中self.dataArray为存放总数据的数组
            for (NSArray *array in self.dataSource) {
                for (NSArray *model in array) {
                    NSString *tempStr = model[0];
                    
                    //----------->把所有的搜索结果转成成拼音
                    NSString *pinyin = [self transformToPinyin:tempStr];
                    NSLog(@"pinyin--%@",pinyin);
                    
                    if ([pinyin rangeOfString:searchString options:NSCaseInsensitiveSearch].length >0 ) {
                        
                        [self.searchList addObject:model];
                    }
                }
            }
        }else{
            self.dataSource = [NSMutableArray arrayWithArray:self.dataSource];
        }
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.countryTableView reloadData];
        });
    });

}


#pragma mark UISearchBarDelegate

- (NSString *)transformToPinyin:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
            
        }
        [allString appendString:@","];
        count ++;
        
    }
    
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    
    return allString;
}

// called when keyboard search button pressed 键盘搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%s",__func__);
    NSLog(@"searchBar.text = %@",searchBar.text);
    if (!self.searchController.active) {
        [self.tableView reloadData];
    }
    [self.searchController.searchBar resignFirstResponder];
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
    self.searchController.active = NO;
//    [self.countryTableView reloadData];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (NSMutableArray *) searchList {
    if (_searchList == nil) {
        _searchList = [NSMutableArray array];
    }
    return _searchList;
}


@end
