//
//  ViewModel.h
//  MVVMDemo
//
//  Created by 风外杏林香 on 2017/9/18.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MovieModel.h"

typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
@interface ViewModel : NSObject

@property (nonatomic,copy) ReturnValueBlock returnBlock;
@property (nonatomic,copy) ErrorCodeBlock errorBlock;

//获取数据
- (void)getMovieData:(UITableView *)tableView row:(NSInteger)firstRow fetchSize:(NSInteger)fetchSize;
//跳转详情页
- (void)movieDetailWithPublicModel:(MovieModel *)movieModel WithViewController:(UIViewController *)superController;

@end
