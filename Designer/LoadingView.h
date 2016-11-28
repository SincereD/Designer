//
//  LoadingView.h
//  Designer
//
//  Created by Sincere on 16/5/20.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

- (instancetype)init;

- (void)showOnView:(UIView*)baseView;

- (void)removeLoadingView;

@end
