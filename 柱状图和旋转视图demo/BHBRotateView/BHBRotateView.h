//
//  BHBRotateView.h
//  柱状图和旋转视图demo
//
//  Created by bihongbo on 15/4/1.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHBRotateItem.h"
@class BHBRotateView;

@protocol BHBRotateViewDelegate <NSObject>

@optional
/*某一个item转动到顶部的时候称为选中*/
- (void)rotateView:(BHBRotateView *)rotateView didselecedItem:(BHBRotateItem *)item andIndex:(NSInteger) index;

@end


@interface BHBRotateView : UIView

/*BHBRotateItem数组*/
@property (strong, nonatomic) NSArray * itemArr;
//圆心
@property (assign, nonatomic) CGFloat   radius;
@property (assign, nonatomic) CGFloat   circleWidth;
@property (assign, nonatomic) CGFloat   iconWidth;
//圆环颜色
@property (strong, nonatomic) UIColor * circleColor;
//标题字体
@property (strong, nonatomic) UIFont  * titleFont;
//标题颜色
@property (strong, nonatomic) UIColor * titleColor;

@property (weak, nonatomic) id<BHBRotateViewDelegate> delegate;


@end
