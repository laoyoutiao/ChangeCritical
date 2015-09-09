//
//  ImageView.h
//  ChangeCritical
//
//  Created by 玉文辉 on 15/9/6.
//  Copyright (c) 2015年 yuwenhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeViewDelegate

@required

- (void)changedoing;

@end

@interface ChangeView : UIViewController

@property (retain, nonatomic) id<ChangeViewDelegate> delegate;

+(ChangeView *)sharedInstance;
- (void)changeImageViewImageName:(NSString *)imagename  Color:(NSInteger)color;
- (void)getClass:(id)classid;
- (void)deleteobj:(id)classid;
- (void)removeobj;
@end
