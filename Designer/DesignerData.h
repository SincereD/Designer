//
//  DesigerData.h
//  Designer
//
//  Created by Sincere on 16/5/14.
//  Copyright © 2016年 Sincere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesignerData : NSObject

- (instancetype)initWithFileURL:(NSURL*)URL;

@property (nonatomic,strong) NSData * gifData;
@property (nonatomic,copy)   NSString * designerName;
@property (nonatomic,retain) NSURL * fileURL;
@property (nonatomic,copy)   NSString * filePath;
@property (nonatomic,assign) BOOL canSave;
@property (nonatomic,assign) BOOL canBussiness;
@property (nonatomic,assign) BOOL canModify;

@end
