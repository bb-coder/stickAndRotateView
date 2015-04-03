//
//  BHBRotateItem.m
//  柱状图和旋转视图demo
//
//  Created by bihongbo on 15/4/1.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//

#import "BHBRotateItem.h"

@implementation BHBRotateItem

+ (BHBRotateItem *) itemWithTitle:(NSString *)title andNomalPicture:(NSString *)nomalPicture andSelectedPicture:(NSString *)selectedPicture andSelectedAction:(SEL)action
{
    BHBRotateItem * item = [[BHBRotateItem alloc]init];
    item.title = title;
    item.nomalPicture = nomalPicture;
    item.selectedPicture = selectedPicture;
    if(action)
    item.selectedAction = action;
    return item;
}

-(UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.nomalPicture] highlightedImage:[UIImage imageNamed:self.selectedPicture]];
    }
    return _imageView;
}

@end
