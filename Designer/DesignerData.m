//
//  DesigerData.m
//  Designer
//
//  Created by Sincere on 16/5/14.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import "DesignerData.h"

@implementation DesignerData

- (instancetype)initWithFileURL:(NSURL*)URL
{
    if (self = [super init])
    {
        _fileURL = URL;
        _gifData = [NSData dataWithContentsOfURL:_fileURL];
        [self initDesigerName];
    }
    return self;
}

- (void)initDesigerName
{
    NSString * path = _fileURL.absoluteString;
    NSArray  * sepratedPath = [path componentsSeparatedByString:@"Documents/"];
    NSString * fileName = [sepratedPath lastObject];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsPath = [paths firstObject];
    
    _filePath = [documentsPath stringByAppendingString:[fileName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    _designerName = [fileName stringByReplacingOccurrencesOfString:@".gif" withString:@""];
    _designerName = [_designerName stringByReplacingOccurrencesOfString:@"_" withString:@""];
   _designerName = [_designerName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    _serverURL = [NSString stringWithFormat:@"http://7xtf1s.com1.z0.glb.clouddn.com/%@",fileName];
}

@end
