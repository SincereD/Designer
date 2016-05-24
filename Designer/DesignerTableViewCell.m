//
//  DesignerTableViewCell.m
//  Designer
//
//  Created by Sincere on 16/5/20.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "DesignerTableViewCell.h"
#import <UIImageView+PlayGIF.h>

@interface DesignerTableViewCell ()

@property (nonatomic,assign) BOOL aniamted;

@end

@implementation DesignerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)initSences
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)startAnimationWithDelay:(CGFloat)delayTime
{
    if (!_aniamted)
    {
        _designerView.transform =  CGAffineTransformMakeTranslation(-kScreenWidth, 0);
    }
    else
    {
        _designerView.transform =  CGAffineTransformMakeTranslation(kScreenWidth, 0);
    }
    _aniamted = !_aniamted;
    [UIView animateWithDuration:1.0f delay:delayTime usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        _designerView.transform = CGAffineTransformIdentity;
    } completion:NULL];
}

@end
