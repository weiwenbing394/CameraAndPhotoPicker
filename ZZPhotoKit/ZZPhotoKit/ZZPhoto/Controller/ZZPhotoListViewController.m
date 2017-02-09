//
//  ZZPhotoListViewController.m
//  ZZFramework
//
//  Created by Yuan on 15/12/17.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import "ZZPhotoListViewController.h"
#import "ZZPhotoDatas.h"
#import "ZZPhotoListCell.h"
#import "ZZPhotoPickerViewController.h"
#import <Photos/Photos.h>
#import "ZZPhotoListModel.h"

@interface ZZPhotoListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView      *alumbTable;
@property (nonatomic, strong) PHPhotoLibrary   *assetsLibrary;
@property (nonatomic,   copy) NSArray          *alubms;
@property (nonatomic, strong) ZZPhotoDatas     *datas;
@end

@implementation ZZPhotoListViewController


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.navigationItem.title = @"相册";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self makeAlumListUI];
    self.alubms = [self.datas GetPhotoListDatas];
}

//取消选中行
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.alumbTable deselectRowAtIndexPath:[self.alumbTable indexPathForSelectedRow] animated:YES];
}

//关闭
-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//初始化tableview
-(void) makeAlumListUI{
    _alumbTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _alumbTable.delegate = self;
    _alumbTable.dataSource = self;
    _alumbTable.separatorColor = [UIColor colorWithRed:231/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    _alumbTable.tableFooterView=[UIView new];
    _alumbTable.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_alumbTable];
    
    NSLayoutConstraint *list_top = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_alumbTable attribute:NSLayoutAttributeTop multiplier:1 constant:0.0f];
    
    NSLayoutConstraint *list_bottom = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_alumbTable attribute:NSLayoutAttributeBottom multiplier:1 constant:0.0f];
    
    NSLayoutConstraint *list_left = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_alumbTable attribute:NSLayoutAttributeLeft multiplier:1 constant:0.0f];
    
    NSLayoutConstraint *list_right = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_alumbTable attribute:NSLayoutAttributeRight multiplier:1 constant:0.0f];
    
    [self.view addConstraints:@[list_top,list_bottom,list_left,list_right]];
}

#pragma mark --- UITableView协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.alubms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZPhotoListCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"ZZPhotoListCell"];
    if (!cell) {
        cell = [[ZZPhotoListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ZZPhotoListCell"];
    }
    [cell loadPhotoListData:[self.alubms objectAtIndex:indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZPhotoPickerViewController *photoPickerController = [[ZZPhotoPickerViewController alloc]initWithNibName:nil bundle:nil];
    photoPickerController.PhotoResult          = self.photoResult;
    photoPickerController.selectNum            = self.selectNum;
    ZZPhotoListModel *listmodel                = [self.alubms objectAtIndex:indexPath.row];
    photoPickerController.fetch                = [self.datas GetFetchResult:listmodel.assetCollection];
    photoPickerController.navigationItem.title = listmodel.title;
    photoPickerController.isAlubSeclect        = YES;
    [self.navigationController pushViewController:photoPickerController animated:YES];
}

#pragma mark --- 懒加载
-(ZZPhotoDatas *)datas{
    if (!_datas) {
        _datas = [[ZZPhotoDatas alloc]init];
    }
    return _datas;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
