//
//  ChangeSkinSwitchCell.m
//  tracelessBrowser
//
//  Created by 杜文杰 on 2021/3/1.
//

#import "ChangeSkinSwitchCell.h"

@interface ChangeSkinSwitchCell(){
    
}
@end
@implementation ChangeSkinSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth(), 44)];
        _titleLab.text = @"从相册中选择一张照片";
        [self addSubview:_titleLab];
        
        _uiswitch = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenWidth() - 70, 7, 50, 44)];
        [self.contentView addSubview:_uiswitch];
    }
    return self;
}

@end
