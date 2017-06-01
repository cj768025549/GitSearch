//
//  TableViewCell.m
//  GitSearch
//
//  Created by changjian on 2017/5/9.
//  Copyright © 2017年 changjian. All rights reserved.
//

#import "TableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;


@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellDataWithAvatarUrl:(NSString *)urlString
                               name:(NSString *)name
                           language:(NSString *)language {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@%@",@"姓名:",name];
    NSString *languageString = @"";
    if (language.length) {
        languageString = language;
    }
    self.languageLabel.text = [NSString stringWithFormat:@"%@%@",@"偏好语言:",languageString];
}

@end
