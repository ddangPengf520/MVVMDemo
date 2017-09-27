//
//  ViewModel.m
//  MVVMDemo
//
//  Created by 风外杏林香 on 2017/9/18.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import "ViewModel.h"
#import "ViewController.h"
#import "SARequestData.h"
#import "JSONKit.h"
#import "MovieModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
@implementation ViewModel

- (void)getMovieData:(UITableView *)tableView row:(NSInteger)firstRow fetchSize:(NSInteger)fetchSize
{
    /*
     * 获取数据、Block传递
     */
    NSLog(@"请求数据");
    
    NSString *urlString = [NSString stringWithFormat:@"lottery/my_scheme.htm?status=0&clientUserSession=1403523_623708a476f9da2d1bf0f54cf1dd07b3&appVersion=1&fetchSize=%ld&type=0&version=1.0.0&firstRow=%ld&requestType=1", fetchSize, firstRow];
    [SARequestData postWithUrlString:urlString parameters:nil success:^(id data) {
        NSMutableArray *array = (NSMutableArray *)[data objectFromJSONData];
//        NSLog(@"dict -- %@", array);
        NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dict in array) {
            MovieModel *model = [MovieModel mj_objectWithKeyValues:dict];
            [modelArr addObject:model];
        }
        _returnBlock(modelArr);
        [tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"error");
        _errorBlock(error);
        [tableView.mj_header endRefreshing];
    } showView:nil];
}



- (void)movieDetailWithPublicModel:(MovieModel *)movieModel WithViewController:(UIViewController *)superController
{
    ViewController *movieVC = [[ViewController alloc] init];
    movieVC.url = movieModel.initiateTime;
    [superController.navigationController pushViewController:movieVC animated:YES];
}



@end
