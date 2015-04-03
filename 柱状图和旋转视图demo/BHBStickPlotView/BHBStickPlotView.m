//
//  BHBStickPlotView.m
//  柱状图和旋转视图demo
//
//  Created by bihongbo on 15/3/31.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//

#import "BHBStickPlotView.h"
#define topMargin 20
#define bottomMargin 5
#define leftMargin 5
#define rightMargin 5
#define bottomLabelHeight 50
#define plotHeight (self.frame.size.height - bottomLabelHeight - topMargin - bottomMargin)

@interface BHBStickPlotView ()

//纵轴x坐标
@property (nonatomic,assign) CGFloat xVertical;
//横轴y坐标
@property (nonatomic,assign) CGFloat yHorizontal;

@end

@implementation BHBStickPlotView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 15;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.masksToBounds = YES;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //创建纵轴标签和横线
    [self drawYwithContext:context];
    //创建横坐标和柱状图
    [self drawXwithContext:context];
}

-(CGFloat)yMaxValue
{
    if(_yMaxValue <= 0) _yMaxValue = 100;
    return _yMaxValue;
}

-(NSInteger)yLabelCount
{
    if (_yLabelCount <= 1) _yLabelCount = 1;
    return _yLabelCount;
}

-(UIFont *)textFont
{
    if(!_textFont){
        _textFont = [UIFont systemFontOfSize:18 weight:0.3];
    }
    return _textFont;
}

-(CGFloat)stickSpan
{
    if (_stickSpan <= 0 || !_stickSpan) {
        _stickSpan = 6;
    }
    return _stickSpan;
}

-(UIColor *)stickColor
{
    if(!_stickColor){
        _stickColor = [UIColor colorWithRed:233/255.0 green:177/255.0 blue:173/255.0 alpha:1];
    }
    return _stickColor;
}

-(UIColor *)textColor
{
    if(!_textColor){
        _textColor = [UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1];
    }
    return _textColor;
}

-(UIColor *)lineColor
{
    if(!_lineColor){
        _lineColor = [UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1];
    }
    return _lineColor;
}

/*
 创建纵轴标签和横线
 */
- (void)drawYwithContext:(CGContextRef)context
{
    CGContextSaveGState(context);
    NSMutableArray * ysArr = [NSMutableArray array];
    for (int i = 0; i < self.yLabelCount + 1; i ++) {
        NSString * str = [NSString stringWithFormat:@"%.1f",self.yMaxValue / self.yLabelCount * i];
        CGFloat x = leftMargin;
        CGFloat y = topMargin + (self.yLabelCount - i) * plotHeight / self.yLabelCount;
        [ysArr addObject:@(y)];
        CGRect strRect = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:@{NSFontAttributeName:self.textFont,NSForegroundColorAttributeName:self.textColor} context:nil];
        strRect.origin.x = x;
        strRect.origin.y = y;
        [str drawInRect:strRect withAttributes:@{NSFontAttributeName:self.textFont,NSForegroundColorAttributeName:self.textColor}];
        self.xVertical = self.xVertical < (strRect.size.width + leftMargin)?(strRect.size.width + leftMargin):self.xVertical;
    }
    
    for (int i = 0; i < self.yLabelCount + 1; i++) {
        CGContextSaveGState(context);
        CGFloat y = [[ysArr objectAtIndex:i] floatValue];
        CGContextBeginPath(context);
        [self.lineColor set];
        CGContextMoveToPoint(context, self.xVertical + 5, y);
        CGContextAddLineToPoint(context, self.frame.size.width - rightMargin, y);
        CGContextStrokePath(context);
        if(i == self.yLabelCount) self.yHorizontal = y;
        CGContextRestoreGState(context);
    }
    CGContextRestoreGState(context);
}

- (void)drawXwithContext:(CGContextRef)context
{
    CGContextSaveGState(context);
    
    CGFloat y = self.frame.size.height - bottomLabelHeight - bottomMargin;
    CGFloat span = (self.frame.size.width - self.xVertical - 20)/self.xValues.count;
    for (int i = 0; i < self.xValues.count; i++) {

        CGFloat x = self.xVertical + 20 + i * span;
        NSString * str = [NSString stringWithFormat:@"%d",i];
        CGRect strRect = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:@{NSFontAttributeName:self.textFont,NSForegroundColorAttributeName:self.textColor} context:nil];
        [str drawAtPoint:CGPointMake(x - strRect.size.width/2, y) withAttributes:@{NSFontAttributeName:self.textFont,NSForegroundColorAttributeName:self.textColor}];
        
        CGFloat yValue = plotHeight / self.yMaxValue * [self.xValues[i]floatValue];
        
        CGContextSaveGState(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, x, y);
        CGContextSetLineWidth(context, span - self.stickSpan);
        CGContextAddLineToPoint(context, x, y - yValue);
        [self.stickColor set];
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
        
    }
    CGContextRestoreGState(context);
}

@end

