//
//  ZZCameraPickerCell.m
//  ZZFramework
//
//  Created by Yuan on 15/12/18.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import "ZZCameraPickerCell.h"



@implementation ZZCameraPickerCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pics = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (ZZ_SCREEN_WIDTH - 60) / 5, (ZZ_SCREEN_WIDTH - 60) / 5)];
        _pics.userInteractionEnabled=YES;
        _pics.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_pics];
        
        CGFloat buttonSize=_pics.frame.size.width/3.0;
        _removeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(_pics.frame)-buttonSize-2, 2, buttonSize, buttonSize)];
        [_removeBtn setImage:Remove_Btn_Pic forState:UIControlStateNormal];
        [_removeBtn addTarget:self action:@selector(clickRemoveButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
        [_pics addSubview:_removeBtn];
        
    }
    return self;
    
}

//载入数据
-(void)loadPhotoDatas:(UIImage *)image
{
    _pics.image = image;

}

-(void)clickRemoveButtonMethod:(UIButton *)button
{
    self.deleteBlock();
}

@end
