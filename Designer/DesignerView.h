//
//  DesignerView.h
//  Designer
//
//  Created by Sincere on 16/5/20.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DesignerData.h"

@interface DesignerView : UIView

- (instancetype)init;

- (void)exchangeShakeState;

- (void)startShaking;

- (void)stopShaking;

- (void)showDesignerInfo;

- (void)hideDesignerInfo;

@property (nonatomic,strong)DesignerData * data;
@property (nonatomic,strong)UIColor * bgColor;
@property (nonatomic,weak)UIViewController * keyVC;

@end
