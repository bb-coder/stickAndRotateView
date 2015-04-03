//
//  BHBRotatePoint.h
//  柱状图和旋转视图demo
//
//  Created by bihongbo on 15/4/2.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BHBRotateItem.h"

@interface BHBRotatePoint : NSObject

@property (assign, nonatomic) CGPoint point;
@property (weak, nonatomic) BHBRotateItem *item;
@property (assign, nonatomic) CGFloat thita;

+(instancetype)pointWith:(CGPoint)point andItem:(BHBRotateItem *)item;

@end
