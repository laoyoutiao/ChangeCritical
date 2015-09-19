//
//  ViewController.m
//  ChangeCritical
//
//  Created by 玉文辉 on 15/9/5.
//  Copyright (c) 2015年 yuwenhui. All rights reserved.
//

#import "ViewController.h"
#import "ChangeView.h"
#import "MyHeader.h"
#import <EventKit/EventKit.h>
#define screensize [UIScreen mainScreen].bounds.size

@interface ViewController ()<ChangeViewDelegate>
@property (strong, nonatomic) NSString *photoname;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (strong, nonatomic) UIImageView *imageview;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIColor *buttontextcolor;
@property (strong, nonatomic) ChangeView *image;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self Color];
//    
//    _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, screensize.width, 100)];
//    _photoname = [[NSUserDefaults standardUserDefaults] objectForKey:@"photoname"];
//    [_imageview setImage:[UIImage imageNamed:_photoname]];
//    [self.view addSubview:_imageview];
//    
//    _image = [ChangeView sharedInstance];
//    [_image getClass:self];
//    _image.delegate = self;
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        _color = [UIColor redColor];
//    });
//    
//    [self saveEvent:nil];
//    NSLog(@"%@",[NSProcessInfo processInfo].environment);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)saveEvent:(id)sender {
    
    
    
    //事件市场
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    //6.0及以上通过下面方式写入事件
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
                    //事件保存到日历
                    
                    
                    //创建事件
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title     = @"哈哈哈，我是日历事件啊";
                    event.location = @"我在佛山等你";
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    event.startDate = [[NSDate alloc]init ];
                    event.endDate   = [[NSDate alloc]init ];
                    event.allDay = YES;
                    
                    //添加提醒
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"Event Created"
                                          message:@"Yay!?"
                                          delegate:nil
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
                    [alert show];
                    
                    NSLog(@"保存成功");
                    
                }
            });
        }];
    }
    else
    {
        // this code runs in iOS 4 or iOS 5
        // ***** do the important stuff here *****
        
        //4.0和5.0通过下述方式添加
        
        //保存日历
        EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
        event.title     = @"哈哈哈，我是日历事件啊";
        event.location = @"我在佛山等你";
        
        NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
        [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        
        event.startDate = [[NSDate alloc]init ];
        event.endDate   = [[NSDate alloc]init ];
        event.allDay = YES;
        
        
        [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
        [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Event Created"
                              message:@"Yay!?"
                              delegate:nil
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        [alert show];
        
        NSLog(@"保存成功");
        
    }
}

- (void)Color
{
    NSInteger i = [[[NSUserDefaults standardUserDefaults] objectForKey:@"navigationcolor"] integerValue];
    switch (i) {
        case 0:
            _color = [UIColor whiteColor];
            _buttontextcolor = [UIColor blackColor];
            break;
            
        case 1:
            _color = [UIColor blackColor];
            _buttontextcolor = [UIColor whiteColor];
            break;
            
        case 2:
            _color = [UIColor redColor];
            _buttontextcolor = [UIColor blueColor];
            break;
            
        default:
            break;
    }
    
    [self.navigationController.navigationBar setBarTintColor:_color];
    self.view.backgroundColor = _color;
    [_changeBtn setTintColor:_buttontextcolor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    [_image changeImageViewImageName:@"1.png" Color:0];
}

- (void)changedoing //delegate
{
    NSLog(@"doing");
}


@end
