//
//  YSNewsViewController.m
//  YUSIR微博客户端2.0
//
//  Created by sq-ios40 on 16/3/16.
//  Copyright © 2016年 YUSIR. All rights reserved.
//

#import "YSNewsViewController.h"

@interface YSNewsViewController ()

@end

@implementation YSNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)cancelClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
