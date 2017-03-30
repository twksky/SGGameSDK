//
//  PayViewController.m
//  GameSDKTest
//
//  Created by twksky on 2017/3/28.
//  Copyright © 2017年 twksky. All rights reserved.
//

#import "PayViewController.h"
#import "GameSDK.h"
#import <ZWXPaySDK/ZWXPaySDK.h>

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
    _payNum = 1;
    self.zifeiLabel.text = [NSString stringWithFormat:@"%.2lf元",_payNum];
    self.yingfujineLabel.text = [NSString stringWithFormat:@"%.2lf元",_payNum];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)wxPayAction:(id)sender {
    [GameSDK gameSDK_WXPayWithBundleName:[NSString stringWithFormat:@"twk%zd",arc4random()] withUserId:[NSString stringWithFormat:@"twkID%zd",arc4random()] withGameBillId:[NSString stringWithFormat:@"twkBill%zd",arc4random()] withGameCode:6 withAmt:_payNum withSuccusBlock:^(NSString *url,NSString *prepayId) {
        
        if (![[ZWXPaySDK defaultService] isWXAppInstalled]) {
            //没有安装微信
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            
        }else{
            //安装微信
            ZWXPayReqObject *payReqObj = [[ZWXPayReqObject alloc] init];
            payReqObj.prepayUrl = url;
            payReqObj.prepayId = prepayId;
            [[ZWXPaySDK defaultService] sendPayReq:payReqObj viewController:self completeBlock:^(ZWXPayRespObject *respObject) {
                
                if (respObject.status) {
                    NSLog(@"成功");
                } else {
                    NSLog(@"失败");
                }
            }];
        }
    }withFaildBlock:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];
}

- (IBAction)aliPayAction:(id)sender {
    [GameSDK gameSDK_AliPayWithBundleName:[NSString stringWithFormat:@"twk%zd",arc4random()] withUserId:[NSString stringWithFormat:@"twkID%zd",arc4random()] withGameBillId:[NSString stringWithFormat:@"twkBill%zd",arc4random()] withGameCode:6 withAmt:_payNum withSuccusBlock:^(NSString *url) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
    } withFaildBlock:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];

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
