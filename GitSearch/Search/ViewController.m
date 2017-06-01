//
//  ViewController.m
//  GitSearch
//
//  Created by changjian on 2017/5/9.
//  Copyright © 2017年 changjian. All rights reserved.
//

#import "ViewController.h"
#import "RequestManager.h"
#import "TableViewCell.h"
#import "TableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>

#define KLanguage   @"language"
#define KAvatar     @"avatar_url"
#define KUserName   @"login"

static NSString *identifier = @"TableViewCell";

@interface ViewController () <UITableViewDataSource, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchVC;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self layoutUI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initialize
- (void)layoutUI {
    self.tableView.rowHeight = 80;
    /**UISearchController**/
    self.searchVC = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchVC.searchResultsUpdater = self;
    self.searchVC.dimsBackgroundDuringPresentation = NO;
    self.tableView.tableHeaderView = self.searchVC.searchBar;
}

- (void)initData {
    self.tableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (self.dataArray.count > indexPath.row) {
        UserInfoModel *userInfoModel = [self.dataArray objectAtIndex:indexPath.row];
        [cell configCellDataWithAvatarUrl:userInfoModel.avatar_url name:userInfoModel.userName language:userInfoModel.language];
    }
    return cell;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *keyword = searchController.searchBar.text;
    if (keyword.length) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        WEAKSELF();
        [RequestManager userInfoWithUserName:keyword success:^(BaseResponseModel *responseData) {
            
            STRONGSELF();
            [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
            strongSelf.dataArray = responseData.items;
            [strongSelf.tableView reloadData];
            NSMutableArray *dataArray = [NSMutableArray arrayWithArray:responseData.items];
            
            for (int i = 0; i < responseData.items.count; i ++) {
                if (responseData.items.count > i) {
                    UserInfoModel *model = [responseData.items objectAtIndex:i];
                    //异步处理语言
                    [strongSelf statisticsCommonLanguageWithUserInfoModel:model success:^(UserInfoModel *userInfo) {
                        [dataArray replaceObjectAtIndex:i withObject:userInfo];
                        strongSelf.dataArray = [NSArray arrayWithArray:dataArray];
                        [strongSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    } fail:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
                    }];
                }
            }
        } failure:^(NSError *error) {
            STRONGSELF();
            [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
        }];
    }
}

#pragma mark - private methods
- (void)statisticsCommonLanguageWithUserInfoModel:(UserInfoModel *)model
                                          success:(void(^)(UserInfoModel *userInfoModel))successBlock
                                             fail:(void(^)(NSError *error))failBlock {
    [RequestManager userReponsWithUserName:model.userName success:^(NSArray *responseData) {
        NSMutableArray *languagesArray = [NSMutableArray array];
        NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < responseData.count; i ++) {
            NSDictionary *dict = [responseData objectAtIndex:i];
            NSString *language = [dict objectForKey:KLanguage];
            if (![language isKindOfClass:[NSNull class]]) {
                if (language.length) {
                    [languagesArray addObject:language];
                }
            }
        }
        //筛选使用多的语言
        NSUInteger max = 0;
        NSSet *languageSet = [NSSet setWithArray:languagesArray];
        for (NSString *string in languageSet) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",@[string]];
            NSArray * reslutFilteredArray = [languagesArray filteredArrayUsingPredicate:predicate];
            
            NSNumber *count = @((languagesArray.count-reslutFilteredArray.count));
            if (count.integerValue > max) {
                max = count.integerValue;
                [userDict setObject:string forKey:KLanguage];
            }
        }
        
        [userDict setObject:model.avatar_url forKey:KAvatar];
        [userDict setObject:model.userName forKey:KUserName];
        
        UserInfoModel *userInfo = [UserInfoModel mj_objectWithKeyValues:userDict];
        
        if (successBlock) {
            successBlock(userInfo);
        }
    } failure:^(NSError *error) {
        failBlock(error);
    }];
}

@end
