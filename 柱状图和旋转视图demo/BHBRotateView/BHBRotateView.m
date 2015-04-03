//
//  BHBRotateView.m
//  柱状图和旋转视图demo
//
//  Created by bihongbo on 15/4/1.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//

#import "BHBRotateView.h"
#import "BHBRotatePoint.h"
#import "math.h"


@interface BHBRotateView ()

//图标所有的坐标点
@property (nonatomic,strong) NSMutableArray * points;
//间隔角度
@property (nonatomic,assign) CGFloat          spanThita;
//开始位置角度
@property (nonatomic,assign) CGFloat          startAngle;
//开始拖动的位置
@property (nonatomic,assign) CGPoint          startPanPoint;
//顺逆时针
@property (nonatomic,assign) CGFloat          rotation;
@end

@implementation BHBRotateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _radius = frame.size.width/2 - 50;
        _circleWidth = 50;
        _startAngle = -M_PI_2;
        _circleColor = [UIColor colorWithRed:233/255.0 green:177/255.0 blue:173/255.0 alpha:1];
        _iconWidth = 80;
        _titleFont = [UIFont systemFontOfSize:23 weight:0.3];
        _titleColor = [UIColor blackColor];
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        [pan setMaximumNumberOfTouches:1];
        [self addGestureRecognizer:pan];
        
        
    }
    return self;
}

//计算两个点的夹角
- (CGFloat)thitaWithPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2
{
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    return atan2f(point1.y - center.y, point1.x - center.x) - atan2f(point2.y - center.y, point2.x - center.x);
}

-(void)panAction:(UIPanGestureRecognizer *)pan
{
    CGPoint location = [pan locationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.startPanPoint = location;
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        CGFloat thita = [self thitaWithPoint1:self.startPanPoint andPoint2:location];
        self.startAngle -= thita;
        self.startPanPoint = location;
    }else if (pan.state == UIGestureRecognizerStateEnded)
    {
        
    }
}

-(void)setStartAngle:(CGFloat)startAngle
{
    while (startAngle >=2 * M_PI) {
        startAngle -= 2 * M_PI;
    }
    _startAngle = startAngle;
    [self setNeedsDisplay];
}

-(void)setRadius:(CGFloat)radius
{
    _radius = radius;
    [self setNeedsDisplay];
}

-(void)setCircleWidth:(CGFloat)circleWidth
{
    _circleWidth = circleWidth;
    [self setNeedsDisplay];
}

-(NSMutableArray *)points
{
    if(!_points){
        _points = [NSMutableArray array];
    }
    return _points;
}

-(void)setItemArr:(NSArray *)itemArr
{
    _itemArr = itemArr;
    for (BHBRotateItem * item in itemArr) {
        [self addSubview:item.imageView];
    }
    [self setNeedsDisplay];
}

- (CGPoint)iconXYwithCenter:(CGPoint)center andThita:(CGFloat)thita
{
    CGPoint iconCenter;
    iconCenter.x = center.x + cosf(thita)*self.radius;
    iconCenter.y = center.y + sinf(thita)*self.radius;
    return iconCenter;
}

//求图标各点坐标
- (void)initPoints
{
    self.spanThita = 2 * M_PI / self.itemArr.count;
    for (int i = 0; i < self.itemArr.count; i ++) {
        CGFloat dpThita = self.startAngle + i * self.spanThita;
        CGPoint iconCenter = [self iconXYwithCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) andThita:dpThita];
        BHBRotatePoint * point = [BHBRotatePoint pointWith:iconCenter andItem:[self.itemArr objectAtIndex:i]];
        point.thita = dpThita;
        if(self.points.count < self.itemArr.count)
        [self.points addObject:point];
        else
            [self.points replaceObjectAtIndex:i withObject:point];
    }

}

-(void)drawRect:(CGRect)rect
{
    //求图标各点坐标
    [self initPoints];
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画圆环
    CGContextSaveGState(context);
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, self.circleWidth);
    CGContextAddArc(context,self.frame.size.width/2, self.frame.size.height/2, self.radius, 0,2*M_PI, 0);
    [self.circleColor set];
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    //画图标
    CGContextSaveGState(context);
    NSUInteger i = 0;
    for (BHBRotatePoint * p in self.points) {
        UIImageView * imageView = p.item.imageView;
        imageView.bounds = CGRectMake(0, 0, self.iconWidth, self.iconWidth);
        imageView.center = p.point;
        
        //计算当前图标是否在顶部
        CGFloat pThita = [self thitaWithPoint1:CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2 - self.radius) andPoint2:p.point];
        if(pThita < self.spanThita/2 && pThita > -self.spanThita/2)
        {
            CGRect strSize = [p.item.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:@{NSFontAttributeName:self.titleFont,NSForegroundColorAttributeName:self.titleColor} context:nil];
            [p.item.title drawAtPoint:CGPointMake(CGRectGetMidX(self.bounds) - CGRectGetMidX(strSize), CGRectGetMidY(self.bounds) - CGRectGetMidY(strSize)) withAttributes:@{NSFontAttributeName:self.titleFont,NSForegroundColorAttributeName:self.titleColor}];
            if(!imageView.highlighted)
            {
                imageView.highlighted = YES;
                if(self.delegate && [self.delegate respondsToSelector:@selector(rotateView:didselecedItem:andIndex:)])
                {
                    [self.delegate rotateView:self didselecedItem:p.item andIndex:i];
                }
            }
        }
        else
        {
            imageView.highlighted = NO;
        }
        i++;
    }
    CGContextRestoreGState(context);
    
}

@end
