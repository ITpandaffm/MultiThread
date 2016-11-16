//
//  ViewController.m
//  MultiThread
//
//  Created by ffm on 16/11/16.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

void *func()
{
    for (int i = 0; i <5000; i++) {
        NSLog(@"%d\n", i);
    }
    return NULL;
}

- (IBAction)clickBtn:(id)sender {
    pthread_t thread;
    pthread_create(&thread, NULL, func, NULL);
//    for (int i = 0; i <5000; i++) {
//        NSLog(@"%d\n", i);
//    }
}
@end
