//
//  ViewController.m
//  柱状图和旋转视图demo
//
//  Created by bihongbo on 15/3/31.
//  Copyright (c) 2015年 毕洪博. All rights reserved.
//

#import "ViewController.h"
#import "BHBStickPlotView.h"
#import "BHBRotateItem.h"
#import "BHBRotateView.h"

@interface ViewController ()<BHBRotateViewDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    BHBStickPlotView * spView = [[BHBStickPlotView alloc]initWithFrame:CGRectMake(5, 100, self.view.frame.size.width - 10, 350)];
    [self.view addSubview:spView];
    spView.yMaxValue = 100.0;
    spView.yLabelCount = 5;
    spView.xValues = @[@11,@11,@90,@11,@11,@80,@11,@80,@11,@11,@11,@11,@11,@11,@80,@11,@80,@11,@11,@111,@11,@11,@11,@11];
    
    //旋转
    BHBRotateView * rtView = [[BHBRotateView alloc]initWithFrame:CGRectMake(100,100 + 350 + 20,350, 350)];
    rtView.backgroundColor = [UIColor whiteColor];
    rtView.delegate = self;
    BHBRotateItem * item1 = [BHBRotateItem itemWithTitle:@"行走步数" andNomalPicture:@"行走步数" andSelectedPicture:@"行走步数2" andSelectedAction:nil];
    BHBRotateItem * item2 = [BHBRotateItem itemWithTitle:@"活动时长" andNomalPicture:@"活动时长" andSelectedPicture:@"活动时长3" andSelectedAction:nil];
    BHBRotateItem * item3 = [BHBRotateItem itemWithTitle:@"活动消耗热量" andNomalPicture:@"活动消耗热量" andSelectedPicture:@"活动消耗热量3" andSelectedAction:nil];
    BHBRotateItem * item4 = [BHBRotateItem itemWithTitle:@"行走距离" andNomalPicture:@"行走距离" andSelectedPicture:@"行走距离2" andSelectedAction:nil];
    BHBRotateItem * item5 = [BHBRotateItem itemWithTitle:@"运动时长" andNomalPicture:@"运动时长" andSelectedPicture:@"运动时长2" andSelectedAction:nil];
    BHBRotateItem * item6 = [BHBRotateItem itemWithTitle:@"运动消耗热量" andNomalPicture:@"运动消耗热量" andSelectedPicture:@"运动消耗热量2" andSelectedAction:nil];
    rtView.itemArr = @[item1,item2,item3,item4,item5,item6];
    [self.view addSubview:rtView];
    
    
    
    
}

#pragma mark -
#pragma mark rotateview delegate
-(void)rotateView:(BHBRotateView *)rotateView didselecedItem:(BHBRotateItem *)item andIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
}

@end
