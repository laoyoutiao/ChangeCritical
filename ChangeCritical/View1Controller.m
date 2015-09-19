//
//  View1Controller.m
//  ChangeCritical
//
//  Created by 玉文辉 on 15/9/5.
//  Copyright (c) 2015年 yuwenhui. All rights reserved.
//

#import "View1Controller.h"
#import "ChangeView.h"
#define screensize [UIScreen mainScreen].bounds.size

@interface View1Controller ()<ChangeViewDelegate>
@property (strong, nonatomic) NSString *photoname;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (strong, nonatomic) UIImageView *imageview;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIColor *buttontextcolor;
@property (strong, nonatomic) ChangeView *image;
@end

@implementation View1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self Color];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, screensize.width, 100)];
    _photoname = [[NSUserDefaults standardUserDefaults] objectForKey:@"photoname"];
    [imageview setImage:[UIImage imageNamed:_photoname]];
    [self.view addSubview:imageview];
        
    _image = [ChangeView sharedInstance];
    [_image getClass:self];
    _image.delegate = self;
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
    random();
    [self.navigationController.navigationBar setBarTintColor:_color];
    self.view.backgroundColor = _color;
    [_changeBtn setTintColor:_buttontextcolor];
}

- (void)viewWillDisappear:(BOOL)animated{
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound){
        [_image deleteobj:self];
    }
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    [_image changeImageViewImageName:@"2.png" Color:1];
}

- (void)changedoing
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
