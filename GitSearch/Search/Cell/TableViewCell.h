//
//  TableViewCell.h
//  GitSearch
//
//  Created by changjian on 2017/5/9.
//  Copyright © 2017年 changjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

- (void)configCellDataWithAvatarUrl:(NSString *)urlString
                               name:(NSString *)name
                           language:(NSString *)language;

@end
