//
//  ViewController.m
//  Test_ReactiveCocoa
//
//  Created by lidongbo on 15/8/24.
//  Copyright (c) 2015年 lidongbo. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //申请一个每隔1s将会在主线程执行一次的信号量.
    RACSignal * repeatSignal = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] repeat];
    //为信号量添加执行代码段
    [repeatSignal subscribeNext:^(NSDate * time) {
        self.time = time;
    }];
    
    //申请一个时间属性的信号量
    RACSignal * timeSignal = [self rac_valuesForKeyPath:@"time" observer:self];
    //为信号量添加执行代码
    [timeSignal subscribeNext:^(NSDate * time) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm:ss"];
        self.label.text = [formatter stringFromDate:time];
        
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
