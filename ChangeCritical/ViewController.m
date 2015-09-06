//
//  ViewController.m
//  ChangeCritical
//
//  Created by 玉文辉 on 15/9/5.
//  Copyright (c) 2015年 yuwenhui. All rights reserved.
//

#import "ViewController.h"
#import "ChangeView.h"
#define screensize [UIScreen mainScreen].bounds.size

@interface ViewController ()
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
    
    [self Color];
    
    _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, screensize.width, 100)];
    _photoname = [[NSUserDefaults standardUserDefaults] objectForKey:@"photoname"];
    [_imageview setImage:[UIImage imageNamed:_photoname]];
    [self.view addSubview:_imageview];
    
    _image = [ChangeView sharedInstance];
    [_image getClass:self];
    
    // Do any additional setup after loading the view, typically from a nib.
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

@end
