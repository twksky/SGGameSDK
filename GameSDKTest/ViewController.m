//
//  ViewController.m
//  GameSDKTest
//
//  Created by twksky on 2017/3/23.
//  Copyright © 2017年 twksky. All rights reserved.
//

#import "ViewController.h"
#import "GameSDK.h"
#import <ZWXPaySDK/ZWXPaySDK.h>

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tabview = [UITableView new];
    tabview.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
    tabview.delegate = self;
    tabview.dataSource = self;
    //    tabview.backgroundColor = [UIColor redColor];
    [self.view addSubview: tabview];

}


#pragma mark T
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"微信支付";
            return cell;
        }
            break;
            
        case 1:
        {
            cell.textLabel.text = @"支付宝支付";
            return cell;
        }
            
            break;
            
            
        default:
            cell.textLabel.text = @"未知";
            return cell;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [GameSDK gameSDK_WXPayWithBundleName:[NSString stringWithFormat:@"twk%zd",arc4random()] withUserId:[NSString stringWithFormat:@"twkID%zd",arc4random()] withGameBillId:[NSString stringWithFormat:@"twkBill%zd",arc4random()] withGameCode:6 withAmt:1.1 withSuccusBlock:^(NSString *url,NSString *prepayId) {
                
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
                
            } withFaildBlock:^(NSString *errorMsg) {
                NSLog(@"%@",errorMsg);
            }];
        }
            break;
            
        case 1:
        {
            [GameSDK gameSDK_AliPayWithBundleName:[NSString stringWithFormat:@"twk%zd",arc4random()] withUserId:[NSString stringWithFormat:@"twkID%zd",arc4random()] withGameBillId:[NSString stringWithFormat:@"twkBill%zd",arc4random()] withGameCode:6 withAmt:1.1 withSuccusBlock:^(NSString *url) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                
            } withFaildBlock:^(NSString *errorMsg) {
                NSLog(@"%@",errorMsg);
            }];
        }
            break;
            
        
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
