//
//  PayViewController.m
//  GameSDKTest
//
//  Created by twksky on 2017/3/28.
//  Copyright © 2017年 twksky. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *zifeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *yingfujineLabel;
@property (weak, nonatomic) IBOutlet UIButton *wxPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *aliPayBtn;
@property (nonatomic, assign) CGFloat payNum;

@end

@implementation PayViewController

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;//左右横屏
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _payNum = 0.1;
    self.zifeiLabel.text = [NSString stringWithFormat:@"%.2lf元",_payNum];
    self.yingfujineLabel.text = [NSString stringWithFormat:@"%.2lf元",_payNum];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)wxPayAction:(id)sender {
    
}
- (IBAction)aliPayAction:(id)sender {
    
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
