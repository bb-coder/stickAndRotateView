//
//  BHBRotatePoint.m
//  柱状图和旋转视图demo
//
//  Created by bihongbo on 15/4/2.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//

#import "BHBRotatePoint.h"

@implementation BHBRotatePoint

+(instancetype)pointWith:(CGPoint)point andItem:(BHBRotateItem *)item
{
    BHBRotatePoint * p = [[self alloc]init];
    p.point = point;
    p.item = item;
    return p;
}

@end
