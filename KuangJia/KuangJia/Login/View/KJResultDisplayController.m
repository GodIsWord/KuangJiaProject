//
//  LZResultDisplayController.m
//  LZSearchController

//  Created by xb on 2018/10/29.
//  Copyright © 2018 yidezhang. All rights reserved.
//
#import "KJResultDisplayController.h"
#import "XBMacroDefinition.h"

@interface KJResultDisplayController ()

@property (nonatomic, strong) NSMutableArray *results;
@end

@implementation KJResultDisplayController

- (NSMutableArray *)results {
    if (_results == nil) {
        _results = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _results;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, STATUSBAR_And_NAVIGATIONBAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

#pragma mark - TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdent = @"resultCell";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    
    NSArray *arr = self.results[indexPath.row];
    cell.textLabel.text = arr[0];
    cell.detailTextLabel.text  = [arr lastObject];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(searchResult:)]) {
        [self.delegate searchResult:cell.detailTextLabel.text];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    // 获取搜索框里地字符串
    NSString *searchString = searchController.searchBar.text;
    if (searchString.length<=0) {
        return;
    }
    if (self.results!= nil) {
        [self.results removeAllObjects];
    }
    //加个多线程，否则数量量大的时候，有明显的卡顿现象
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        if (searchString!=nil && searchString.length>0) {
            
            //遍历需要搜索的所有内容，其中self.dataArray为存放总数据的数组
            for (NSArray *array in self.datas) {
                for (NSArray *model in array) {
                    NSString *tempStr = model[0];
                    
                    //----------->把所有的搜索结果转成成拼音
                    NSString *pinyin = [self transformToPinyin:tempStr];
                    NSLog(@"pinyin--%@",pinyin);
                    
                    if ([pinyin rangeOfString:searchString options:NSCaseInsensitiveSearch].length >0 ) {
                        
                        [self.results addObject:model];
                    }
                }
            }
        }
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

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


@end
