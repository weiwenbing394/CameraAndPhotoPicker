//
//  ZZPhotoListCell.m
//  ZZFramework
//
//  Created by Yuan on 15/12/17.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import "ZZPhotoListCell.h"
#import "ZZPhotoListModel.h"
@implementation ZZPhotoListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        _coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        
        _coverImage.layer.masksToBounds = YES;
        
        _coverImage.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_coverImage];
        
        CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width - 70;
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, labelWidth, 25)];
        
        _title.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_title];
        
        _subTitle = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, labelWidth, 25)];
        
        _subTitle.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_subTitle];
        
    }
    return self;
}


-(void)loadPhotoListData:(ZZPhotoListModel *)listmodel{
    if ([listmodel isKindOfClass:[ZZPhotoListModel class]]) {
        [[PHImageManager defaultManager] requestImageForAsset:listmodel.lastObject targetSize:CGSizeMake(200,200) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage *result, NSDictionary *info){
            if (result == nil) {
                self.coverImage.image = NOPhoto_Data_Pic;
            }else{
                self.coverImage.image = result;
            }
        }];
        self.title.text = listmodel.title;
        self.subTitle.text = [NSString stringWithFormat:@"%lu",(unsigned long)listmodel.count];
    }
}
@end
