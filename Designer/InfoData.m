//
//  InfoData.m
//  Designer
//
//  Created by Sincere on 16/5/12.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "InfoData.h"

@implementation InfoData

- (instancetype)initWithPhotoName:(NSString*)photoName
                          mailBox:(NSString*)mailBox
                          subject:(NSString*)subject
{
    if (self = [super init])
    {
        _photoName = photoName;
        _mailBox = mailBox;
        _subject = subject;
    }
    return self;
}

@end
