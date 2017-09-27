//
//  HomeCell.m
//  MVVMDemo
//
//  Created by 风外杏林香 on 2017/9/18.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import "HomeCell.h"
@interface HomeCell ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *yearLabel;

@end

@implementation HomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 20)];
        [self.contentView addSubview:_nameLabel];
        
        _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 50, 100, 20)];
        _yearLabel.textColor = [UIColor lightGrayColor];
        _yearLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_yearLabel];
    }
    return self;
}
- (void)setModel:(MovieModel *)model
{
    _model = model;
    _nameLabel.text = _model.lotteryName;
    _yearLabel.text = _model.initiateTime;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
