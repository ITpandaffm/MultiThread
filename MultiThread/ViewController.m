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
@property (weak, nonatomic) IBOutlet UIImageView *image2;

@property (nonatomic, assign) int ticketCount;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ticketCount = 20;
    self.lock = [[NSLock alloc] init];
}

- (IBAction)threadNSLocl:(id)sender {
    NSThread *sellTicket1 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    NSThread *sellTicket2 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    
    [sellTicket1 start];
    [sellTicket2 start];
}

- (void)sellTicket
{
    
    while (self.ticketCount > 0)
    {
        [self.lock lock];
        if (self.ticketCount > 0) {
            self.ticketCount--;
            NSLog(@"%@卖出了一张票，还剩%d",[NSThread currentThread],self.ticketCount);
        }
        [self.lock unlock];
    }
}

- (IBAction)threadSychconized:(id)sender
{

    NSBlockOperation *sellTicket1 = [NSBlockOperation blockOperationWithBlock:^{
        while (self.ticketCount > 0) {
            @synchronized (self) {
                if (self.ticketCount>0) {
                    self.ticketCount--;
                    NSLog(@"%@卖出了一张票, 当前还剩下%d", [NSThread currentThread],self.ticketCount );
                }
               
            }
        }
    }];
    
    NSBlockOperation *sellTicket2 = [NSBlockOperation blockOperationWithBlock:^{
        while (self.ticketCount > 0)
        {
            @synchronized (self) {
                if (self.ticketCount>0) {
                    self.ticketCount--;
                    NSLog(@"%@卖出了一张票,当前还剩下%d", [NSThread currentThread], self.ticketCount);
                }
        
            }
    
        }
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:sellTicket1];
    [queue addOperation:sellTicket2];
    
}




- (IBAction)clickBtn:(id)sender {
    //GCD
    //全局并行队列
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//    dispatch_async(mainQueue, ^{
//        for (int i = 1; i <10; i++) {
//            NSLog(@"000%@", [NSThread currentThread]);
//        }
//    });
//    
//    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);


//    //全局串行队列
//    dispatch_queue_t conQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_sync(conQueue, ^{
//        NSLog(@"1%@", [NSThread currentThread]);
//    });
    
//    dispatch_async(serQueue, ^{
//        for (int i = 0; i < 1000; i ++) {
//            NSLog(@"000%@",[NSThread currentThread]);
//            
//        }
//    });
//    dispatch_async(serQueue, ^{
//        for (int i = 0; i < 10; i ++) {
//            NSLog(@"222%@",[NSThread currentThread]);
//            
//        }
//    });
//    dispatch_async(serQueue, ^{
//        for (int i = 0; i < 100; i ++) {
//            NSLog(@"111%@",[NSThread currentThread]);
//            
//        }
//    });
    
//    //多线程下载一张图片
//    dispatch_queue_t conQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(conQueue, ^{
//        NSURL *url = [NSURL URLWithString:@"http://p4.music.126.net/uqN_O0rw1lDWwo0uI29oxQ==/6634453162020009.jpg?param=180y180"];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        UIImage *image = [UIImage imageWithData:data];
//        
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            self.image.image = image;
//            
//        });
//    });
    
    
/*
 dispatch_t_group
 
    __block UIImage *image;
    __block UIImage *image2;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://kaoyan1v1.mymsgk.cn/UploadFiles/xinxi/2016/7/201607041336074106.jpg"];
                NSData *data = [NSData dataWithContentsOfURL:url];
                image = [UIImage imageWithData:data];
        
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/img/bd_logo1.png"];
                NSData *data = [NSData dataWithContentsOfURL:url];
                image2 = [UIImage imageWithData:data];
        
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.image.image = image;
        self.image2.image = image2;
    });
*/
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(runThread:) object:@"我是黄楚琦七七七七七七"];
    
//    [invocationOperation start];
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self runThread:@"blockOperation"];
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"啦啦啦拉阿拉德玛西亚%@", [NSThread currentThread]);
    }];
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        [self runThread:@"blockOperation222"];
    }];
    [invocationOperation setCompletionBlock:^{
        NSLog(@"invocationOperation已经执行完毕啦~");
    }];
//    [blockOperation start];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2;

    [queue addOperation:invocationOperation];
    [queue addOperation:blockOperation];
    [queue addOperation:blockOperation2];
}


- (void)pthreadTest
{
    //pthread
    //    pthread_t pthread;
    //    pthread_create(&pthread, NULL, run, NULL);
}

- (void)nsthreadTest
{
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
    //    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/img/bd_logo1.png"];
    //
    //    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadPic:) object:url];
    //
    //    [thread start];
    //    self.image.image = image;
    
}


- (void)downloadPic:(NSURL *)url
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [self performSelectorOnMainThread:@selector(showPic:) withObject:image waitUntilDone:NO];
    NSLog(@"downpic is here%@",[NSThread currentThread]);

}
- (void)showPic:(UIImage *)image
{

    self.image.image = image;
    NSLog(@"%@",[NSThread currentThread]);

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
