//
//  ImageView.h
//  ChangeCritical
//
//  Created by 玉文辉 on 15/9/6.
//  Copyright (c) 2015年 yuwenhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeView : NSObject

+(ChangeView *)sharedInstance;
- (void)changeImageViewObjectName:(NSArray *)objectname ImageName:(NSString *)imagename;
- (void)getClass:(id)classid ObjectName:(NSArray *)objectname;
- (void)deleteobj:(id)classid;
- (void)removeobj;
@end
