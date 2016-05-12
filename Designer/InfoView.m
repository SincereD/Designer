//
//  InfoView.m
//  Designer
//
//  Created by Sincere on 16/5/12.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "InfoView.h"

@interface InfoView ()
{
    CGFloat _height;
}
@end

@implementation InfoView

- (instancetype)initWithData:(InfoData*)data
                       frame:(CGRect)frame
{
    if (self = [super init])
    {
        [self setFrame:frame];
         _data = data;
        _height = (self.frame.size.height - 125)/2.0f;
        [self addSubview:[self photo]];
        [self addSubview:[self subjectLab]];
        [self addSubview:[self mailBoxLab]];
    }
    return self;
}

- (UIFont*)mainSubjectFont
{
    return [UIFont fontWithName:@"DFWaWaSC-W5" size:15.0f];
}

- (UIFont*)font
{
    return [UIFont fontWithName:@"DFWaWaSC-W5" size:14.0f];
}

- (UILabel*)subjectLab
{
    if (!_subjectLab)
    {
        _subjectLab = [[UILabel alloc] init];
        [_subjectLab setFont:[self font]];
        [_subjectLab setFrame:CGRectMake(0, CGRectGetMaxY(_photo.frame), kScreenWidth, 20)];
        [_subjectLab setTextAlignment:NSTextAlignmentCenter];
        [_subjectLab setText:_data.subject];
    }
    return _subjectLab;
}

- (UILabel*)mailBoxLab
{
    if (!_mailBoxLab)
    {
        _mailBoxLab = [[UILabel alloc] init];
        [_mailBoxLab setFont:[self font]];
        [_mailBoxLab setFrame:CGRectMake(0, CGRectGetMaxY(_subjectLab.frame), kScreenWidth, 20)];
        [_mailBoxLab setTextAlignment:NSTextAlignmentCenter];
        [_mailBoxLab setText:_data.mailBox];

    }
    return _mailBoxLab;
}

- (UIImageView*)photo
{
    if (!_photo)
    {
        _photo = [[UIImageView alloc] init];
        [_photo setImage:[UIImage imageNamed:_data.photoName]];
        [_photo setFrame:CGRectMake(kScreenWidth/2.0f - 45.0f, _height, 85, 85)];
    }
    return _photo;
}

@end
