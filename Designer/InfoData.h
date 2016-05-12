//
//  InfoData.h
//  Designer
//
//  Created by Sincere on 16/5/12.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoData : NSObject

- (instancetype)initWithPhotoName:(NSString*)photoName
                          mailBox:(NSString*)mailBox
                          subject:(NSString*)subject;

@property (nonatomic,copy) NSString * photoName;
@property (nonatomic,copy) NSString * mailBox;
@property (nonatomic,copy) NSString * subject;

@end
