//
//  DesignerTableViewCell.h
//  Designer
//
//  Created by Sincere on 16/5/20.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerData.h"
@interface DesignerTableViewCell : UITableViewCell

@property (nonatomic,strong)DesignerData * data;
@property (weak, nonatomic) IBOutlet UILabel *coprightLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (nonatomic,strong)UIImageView * gifImageView;

@end
