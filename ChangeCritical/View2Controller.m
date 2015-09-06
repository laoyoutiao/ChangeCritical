//
//  View2Controller.m
//  ChangeCritical
//
//  Created by 玉文辉 on 15/9/5.
//  Copyright (c) 2015年 yuwenhui. All rights reserved.
//

#import "View2Controller.h"
#import "ChangeView.h"
#define screensize [UIScreen mainScreen].bounds.size

@interface View2Controller ()
@property (strong, nonatomic) NSString *photoname;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (strong, nonatomic) UIImageView *imageview;
@property (strong, nonatomic) ChangeView *image;
@end

@implementation View2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, screensize.width, 100)];
    _photoname = [[NSUserDefaults standardUserDefaults] objectForKey:@"photoname"];
    [imageview setImage:[UIImage imageNamed:_photoname]];
    [self.view addSubview:imageview];
    
    _image = [ChangeView sharedInstance];
    [_image getClass:self ObjectName:nil];
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
    NSArray *array = [[NSArray alloc] initWithObjects:_image, nil];
    [_image changeImageViewObjectName:array ImageName:@"3.png"];
    
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
