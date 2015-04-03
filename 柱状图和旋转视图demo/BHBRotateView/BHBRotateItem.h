//
//  BHBRotateItem.h
//  柱状图和旋转视图demo
//
//  Created by bihongbo on 15/4/1.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BHBRotateItem : NSObject
/*标题*/
@property (copy, nonatomic) NSString    *title;
/*普通图片*/
@property (copy, nonatomic) NSString    *nomalPicture;
/*选中图片*/
@property (copy, nonatomic) NSString    *selectedPicture;
/*响应事件*/
@property (assign, nonatomic) SEL       selectedAction;
/*图标图片*/
@property (strong, nonatomic) UIImageView *imageView;

//快速返回一个item实例
+ (BHBRotateItem *) itemWithTitle:(NSString *)title andNomalPicture:(NSString *)nomalPicture andSelectedPicture:(NSString *)selectedPicture andSelectedAction:(SEL)action;

@end
