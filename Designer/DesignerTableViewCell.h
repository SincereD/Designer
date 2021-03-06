//
//  DesignerTableViewCell.h
//  Designer
//
//  Created by Sincere on 16/5/20.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerView.h"
@interface DesignerTableViewCell : UITableViewCell

- (void)startAnimationWithDelay:(CGFloat)delayTime;

@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,strong) DesignerView * designerView;

@end
