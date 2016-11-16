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
//    pthread_t thread;
//    pthread_create(&thread, NULL, func, NULL);
    
//    for (int i = 0; i <5000; i++) {
//        NSLog(@"%d\n", i);
//    }
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object:@"helloThread"];
    [thread start];
    if ([NSThread currentThread].isMainThread)
    {
        NSLog(@"我就是主线程啊哈哈哈哈");
    } else
    {
        NSLog(@"我才不是主线程呢");
    }
}

- (void)run:(NSString *)prarmater
{
    NSLog(@"roger the prarmater: %@", prarmater);
    if ([NSThread currentThread].isMainThread)
    {
        NSLog(@"我在run方法 我是主线程");
    } else
    {
        NSLog(@"我在run方法 我不是主线程");
    }
}

@end
