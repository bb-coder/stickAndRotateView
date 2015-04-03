//
//  BHBStickPlotView.h
//  柱状图和旋转视图demo
//
//  Created by bihongbo on 15/3/31.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//
//显示一组柱状图

#import <UIKit/UIKit.h>

@interface BHBStickPlotView : UIView

/*
 纵轴最大值
 */
@property (assign, nonatomic) CGFloat     yMaxValue;

@property (assign, nonatomic) NSInteger   yLabelCount;
/*
 横轴取值@[@x1,@x2,@x3...]
 */
@property (strong, nonatomic) NSArray   *xValues;
/*
 左侧横轴单位
 */
@property (copy, nonatomic) NSString    *leftString;
/*
 中部横轴单位
 */
@property (copy, nonatomic) NSString    *centerString;
/*
 右侧横轴单位
 */
@property (copy, nonatomic) NSString    *rightString;
/*
 横纵坐标标签字体大小
 */
@property (strong, nonatomic) UIFont    *textFont;
/*
 柱状图间隔
 */
@property (assign, nonatomic) CGFloat   stickSpan;
/*
 柱颜色
 */
@property (strong, nonatomic) UIColor   *stickColor;
/*
 线颜色
 */
@property (strong, nonatomic) UIColor   *lineColor;
/*
 字颜色
 */
@property (strong, nonatomic) UIColor   *textColor;

@end
