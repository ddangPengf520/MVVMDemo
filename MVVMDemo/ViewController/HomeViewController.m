//
//  HomeViewController.m
//  MVVMDemo
//
//  Created by 风外杏林香 on 2017/9/18.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewModel.h"
#import "HomeCell.h"
#import "MJRefresh.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger row;
    NSInteger fetchSize;
}
@property (nonatomic,strong) NSMutableArray *modelArray;
@property (nonatomic, strong)UITableView *dataTableView;
@end

@implementation HomeViewController

- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dataTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.dataTableView.dataSource = self;
    self.dataTableView.delegate = self;
    self.dataTableView.rowHeight = 80;
    [self.view addSubview:self.dataTableView];
    [self.dataTableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];
    
    //初始化ViewModel，设置成功（returnBlock）和失败的回调（errorBlock），getMovieData去请求数据，请求数据成功即回调上一步设置的returnBlock，请求失败则回调errorBlock
    __block HomeViewController *blockSelf = self;
    ViewModel *viewModel = [[ViewModel alloc] init];
    row = 0;
    fetchSize = 10;
    self.dataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        row = 0;
        fetchSize = 10;
        [viewModel getMovieData:self.dataTableView row:row fetchSize:fetchSize];
    }];
    [self.dataTableView.mj_header beginRefreshing];
    self.dataTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        fetchSize = fetchSize + 10;
        [blockSelf.dataTableView.mj_footer beginRefreshing];
        [viewModel getMovieData:self.dataTableView row:row fetchSize:fetchSize];
        [blockSelf.dataTableView.mj_footer endRefreshing];
    }];
    viewModel.returnBlock = ^(id returnValue){
        blockSelf.modelArray = (NSMutableArray *)returnValue;
        [self.dataTableView reloadData];
    };
    viewModel.errorBlock = ^(id errorCode){
        NSLog(@"%@",errorCode);
    };
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    cell.model = self.modelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ViewModel *movieViewModel = [[ViewModel alloc] init];
    [movieViewModel movieDetailWithPublicModel:_modelArray[indexPath.row] WithViewController:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
