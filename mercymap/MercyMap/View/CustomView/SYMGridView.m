//
//  SYMGridView.m
//  MercyMap
//
//  Created by zhangshupeng on 16/7/9.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "SYMGridView.h"
#import "UIButton+WebCache.h"
#import "CreateLightImageCell.h"
@implementation SYMGridView

-(instancetype)init{
    if (self) {
    }
    return self;
}

-(int)typeElement:(id)obj{
    int type = 2;
    if ([obj isKindOfClass:[NSString class]]) {
        type=1;
        if ([obj rangeOfString:@"http"].length>0) {
            type = 0;
        }
    }else if ([obj isKindOfClass:[UIImage class]]){
        type = 3;
    }
    return type;
}


-(void)addElement:(NSArray*)elements {
   [self removeAllSubView];
    NSUInteger count=0;
    for (NSObject *obj in elements) {
        int type = [self typeElement:obj];
        CGFloat x = 0.0;
        CGFloat y = 0.0;
        x = count*(self.elementSize.width+self.rowElementDistance)+self.elementEdgeInsets.left+self.elementSize.width/2;
//      y=self.bounds.size.height/2;
        y =((kSCREENWIDTH - 40 - 4*10)/5)/2;
        switch (type) {
            case 3:
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
                btn.bounds = CGRectMake(0, 0, self.elementSize.width, self.elementSize.height);
                btn.center = CGPointMake(x, y);
                btn.tag = count ;
                [btn setBackgroundImage:(UIImage *)obj forState:UIControlStateNormal];
                [self addSubview:btn];
            }
                break;
            case 1:
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
                btn.bounds = CGRectMake(0, 0, self.elementSize.width, self.elementSize.height);
                btn.center = CGPointMake(x, y);
                btn.tag = count ;
                [btn setBackgroundImage:[UIImage imageNamed:(NSString *)obj] forState:UIControlStateNormal];
                [self addSubview:btn];
            }
                break;
            case 0:{
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
                btn.bounds = CGRectMake(0, 0, self.elementSize.width, self.elementSize.height);
                btn.center = CGPointMake(x, y);
                btn.tag = count ;
                [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:(NSString *)obj] forState:UIControlStateNormal placeholderImage:nil];
                [self addSubview:btn];
            }
                break;
            case 2:{
                UIView *view = (UIView *)obj;
                view.bounds = CGRectMake(0, 0, self.elementSize.width, self.elementSize.height);
                view.center = CGPointMake(x, y);
                view.tag = count;
                [self addSubview:view];
            }
                break;
            default:
                break;
        }
        count++;
    }
    [self clipSubview];
}

- (void)clickView:(UIButton *)button{
    if (self.ClickView) {
        self.ClickView(button.tag);
    }
}




- (void)clipSubview{
    if (self.clipSubViews) {
        for (UIView * sub in self.subviews) {
            sub.clipsToBounds = YES;
            sub.layer.cornerRadius = sub.bounds.size.width/2;
        }
    }
}

///移除所有子视图
-(void)removeAllSubView{
    for (UIView *view  in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
