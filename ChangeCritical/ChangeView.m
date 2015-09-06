//
//  ImageView.m
//  ChangeCritical
//
//  Created by 玉文辉 on 15/9/6.
//  Copyright (c) 2015年 yuwenhui. All rights reserved.
//

#import "ChangeView.h"
#import <objc/runtime.h>

@interface ChangeView ()
@property (strong, nonatomic) NSMutableArray *objectArray;
@end

@implementation ChangeView

+ (ChangeView *)sharedInstance
{
    static ChangeView *sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[ChangeView alloc] init];
    });
    
    return sharedManager;
}

- (void)getClass:(id)classid
{
    [self saveClass:classid];
}

- (void)changeImageViewImageName:(NSString *)imagename Color:(NSInteger)color
{
    [[NSUserDefaults standardUserDefaults] setObject:imagename forKey:@"photoname"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",color] forKey:@"navigationcolor"];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imagename]];
    
    for(int n = 0; n < [_objectArray count]; n++)
    {
        unsigned int count = 0;
        Ivar *members = class_copyIvarList([[_objectArray objectAtIndex:n] class], &count);
//        for (int i = 0; i < count; i++) {
//            Ivar var = members[i];
//            const char *memberName = ivar_getName(var);
//            NSLog(@"%d  %s--",i, memberName);
//        }
        Ivar m_name = members[2];  //自由属性获取
        object_setIvar([_objectArray objectAtIndex:n] ,m_name,imageview);
        
        
        Ivar m_color = members[3];
        UIColor *navicolor;
        UIColor *buttontextcolor;
        switch (color) {
            case 0:
                navicolor = [UIColor whiteColor];
                buttontextcolor = [UIColor blackColor];
                break;
                
            case 1:
                navicolor = [UIColor blackColor];
                buttontextcolor = [UIColor whiteColor];
                break;
                
            case 2:
                navicolor = [UIColor redColor];
                buttontextcolor = [UIColor blueColor];
                break;
                
            default:
                break;
        }
        object_setIvar([_objectArray objectAtIndex:n] ,m_color,navicolor);
        
        Ivar m_buttontextcolor = members[4];
        object_setIvar([_objectArray objectAtIndex:n] ,m_buttontextcolor,buttontextcolor);
        
        [[_objectArray objectAtIndex:n] viewDidLoad];
    }
}

- (void)saveClass:(id)classid 
{
    if (![_objectArray count]) {
        _objectArray = [[NSMutableArray alloc] initWithObjects:classid, nil];
    }else
    {
        BOOL hiv = NO;
        for (int i = 0; i < [_objectArray count]; i ++) {
            if (classid == [_objectArray objectAtIndex:i]) {
                hiv = YES;
            }
        }
        if (!hiv) {
            [_objectArray insertObject:classid atIndex:0];
        }
    }
//    NSLog(@"className:%@", _objectArray);
}

- (void)deleteobj:(id)classid
{
   [_objectArray removeObjectAtIndex:0];
}

- (void)removeobj
{
    _objectArray = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
