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
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)clickBtn:(id)sender {
//    pthread_t pthread;
//    pthread_create(&pthread, NULL, run, NULL);
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(runThread:) object:@"我是参数"];
//    [thread setThreadPriority:0.9];
//    [[NSThread currentThread] setThreadPriority:0.1];
//    [thread start];
//    
//    [NSThread detachNewThreadWithBlock:^{
//        NSLog(@"detachThreadBlock %@", [NSThread currentThread]);
//    }];
//
//    [self performSelectorInBackground:@selector(performSeceletorTest:) withObject:@"performTest"];
//    
//    NSLog(@"这里是主线程%@,优先级为%f", [NSThread mainThread], [NSThread currentThread].threadPriority);
//    for (int i =0; i<10; i++)
//    {
//        NSLog(@"这里是主线程");
//    }
    
    
    //多线程下载一张图片
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/img/bd_logo1.png"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [self performSelectorOnMainThread:@selector(downloadPic:) withObject:image waitUntilDone:NO];
//    self.image.image = image;

}

- (void)downloadPic:(UIImage *)image
{

    self.image.image = image;
}











- (void)performSeceletorTest:(NSString *)str
{
    NSLog(@"%@, %@",[NSThread currentThread], str);
}


- (void)runThread:(NSString *)str
{
    NSLog(@"我是线程%@. 优先级为%f", [NSThread currentThread], [NSThread currentThread].threadPriority);
    for (int i = 0; i <10; i++)
    {
        NSLog(str, nil);
    }
    
}

void *run()
{
    NSLog(@"%@", [NSThread currentThread]);
    return NULL;
    
}


@end
