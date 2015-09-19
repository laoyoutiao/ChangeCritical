//
//  ImageView.m
//  ChangeCritical
//
//  Created by 玉文辉 on 15/9/6.
//  Copyright (c) 2015年 yuwenhui. All rights reserved.
//

#import "ChangeView.h"
#import <objc/runtime.h>
#import "MyHeader.h"

@interface ChangeView ()
@property (strong, nonatomic) NSMutableArray *objectArray;
@property (nonatomic) BOOL changesuccess;
@property (strong, nonatomic) UILabel *titlelabel;
@property (strong, nonatomic) NSString *message;
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
//    [self saveClass:classid];
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"123" message:@"123" delegate:self cancelButtonTitle:@"1" otherButtonTitles: nil];
    unsigned int countnt = 0;
    Method *methodalt = class_copyMethodList([alt class], &countnt);
    Method me = methodalt[7];
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(youtiaotitlelabel));
//    method_exchangeImplementations(me, swizzledMethod);
    IMP imp = method_getImplementation(me);
    method_setImplementation(swizzledMethod, imp);
    [alt show];
    //        for (int k = 0; k < countnt; k++) {
    //            Method me = methodalt[k];
    //            SEL str = method_getName(me);
    //            NSLog(@"%d  %s--",k, sel_getName(str));  7
    //        }
    
    
    //        Ivar *membersalt = class_copyIvarList([alt class], &countnt);
    //                for (int i = 0; i < countnt; i++) {
    //                    Ivar var = membersalt[i];
    //                    const char *memberName = ivar_getName(var);
    //                    NSLog(@"%d  %s--",i, memberName);
    //                }
    
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
        
        NSLog(@"%@",[_objectArray objectAtIndex:n]);
        unsigned int countn = 0;
        Method *method = class_copyMethodList([[_objectArray objectAtIndex:n] class], &countn);
        for (int k = 0; k < countn; k++) {
            Method me = method[k];
//            SEL str = method_getName(me);
//            NSLog(@"%d  %s--",k, sel_getName(str));
            if (method_getName(me) == @selector(changedoing)) {
                NSLog(@"%u",_changesuccess);
                if (!_changesuccess) {
                    Method originalMethod = class_getInstanceMethod([[_objectArray objectAtIndex:n] class], @selector(changedoing));
                    Method swizzledMethod = class_getInstanceMethod([self class], @selector(changedoingsomething));
                    method_exchangeImplementations(originalMethod, swizzledMethod);
                    _changesuccess = YES;
                }
            }
        }

        
        [_delegate changedoing];
    }
}

- (void)youtiaotitlelabel
{
    NSLog(@"success");
//    _titlelabel.textAlignment = NSTextAlignmentLeft;
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
//    NSLogArray(@"%@",_objectArray);
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

- (void)changedoingsomething
{
    NSLog(@"success");
    NSLog(@"%@",self);
    [self viewDidLoad];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
