//
//  InfoView.h
//  Designer
//
//  Created by Sincere on 16/5/12.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoData.h"

@interface InfoView : UIView

- (instancetype)initWithData:(InfoData*)data
                       frame:(CGRect)frame;

@property (nonatomic,strong) InfoData * data;
@property (nonatomic,strong) UIImageView * photo;
@property (nonatomic,strong) UILabel * subjectLab;
@property (nonatomic,strong) UILabel * mailBoxLab;

@end
