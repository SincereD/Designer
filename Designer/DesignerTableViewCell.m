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
{
    UIImageView * _gifImageView;
}
@end

@implementation DesignerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setData:(DesignerData *)data
{
    _data = data;
    [self initSences];
}

- (void)initSences
{
    [_coprightLab setText:@"版权:"];
    [_coprightLab setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:16.0f]];
    [_coprightLab setTextColor:[UIColor whiteColor]];
    [_coprightLab setFrame:CGRectMake(0, self.frame.size.height-20, _coprightLab.text.length*16, 20)];
    
    [_nameLab setText:[NSString stringWithFormat:@"原作者:%@",_data.designerName]];
    [_nameLab setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:16.0f]];
    [_nameLab setTextColor:[UIColor whiteColor]];
    [_nameLab setFrame:CGRectMake(self.frame.size.width - _nameLab.text.length*16, self.frame.size.height-20, _nameLab.text.length*16, 20)];
    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL* fileURL = [documentsDirectoryURL URLByAppendingPathComponent:_data.designerName];
    
    _gifImageView = [[UIImageView alloc] init];
    [_gifImageView setGifData:[NSData dataWithContentsOfURL:fileURL]];
    [_gifImageView setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*GIFScale)];
    [_gifImageView setUserInteractionEnabled:YES];
    [self addSubview:_gifImageView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
