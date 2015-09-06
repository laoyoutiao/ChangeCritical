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
@property (strong, nonatomic) ChangeView *image;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, screensize.width, 100)];
    _photoname = [[NSUserDefaults standardUserDefaults] objectForKey:@"photoname"];
    [_imageview setImage:[UIImage imageNamed:_photoname]];
    [self.view addSubview:_imageview];
    
    _image = [ChangeView sharedInstance];
    [_image getClass:self ObjectName:nil];
    
    []
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)ReviseNavigation
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    self.title = @"去哪里";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {

    NSArray *array = [[NSArray alloc] initWithObjects:_image, nil];
    [_image changeImageViewObjectName:array ImageName:@"1.png"];
}

@end
