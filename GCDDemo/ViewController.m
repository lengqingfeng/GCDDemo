//
//  ViewController.m
//  GCDDemo
//
//  Created by lengshengren on 13-12-5.
//  Copyright (c) 2013年 lengshengren. All rights reserved.
//

#import "ViewController.h"
#include <dispatch/dispatch.h>

typedef struct{
    char *title;
    char *message;
    char *cancelButtonTitle;
    
    
}AlertViewData;

int x = 10;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"studen");
    
//    dispatch_get_main_queue();
//    dispatch_async 函数会将传入的block块放入指定的queue里运行。这个函数是异步的，这就意味着它会立即返回而不管block是否运行结束。因此，我们可以在block里运行各种耗时的操作（如网络请求） 而同时不会阻塞UI线程。
//    dispatch_get_global_queue 会获取一个全局队列，我们姑且理解为系统为我们开启的一些全局线程。我们用priority指定队列的优先级，而flag作为保留字段备用（一般为0）。
//    dispatch_get_main_queue 会返回主队列，也就是UI队列。它一般用于在其它队列中异步完成了一些工作后，需要在UI队列中更新界面（比如上面代码中的[self updateUIWithResult:result]）的情况。
    
    //释放
   // dispatch_release(que);
    //* 这个函数是提交一个块多少次调用调度队列，他有3个参数 * 第一个参数是指定执行的次数，第二个参数指定这个块调用的队列和这个块的本身 他需要一个单独的参数迭代索引*/
    //  void dispatch_apply(size_t iterations, dispatch_queue_t queue, void (^block)(size_t));
    
    // dispatch_async(<#dispatch_queue_t queue#>, <#^(void)block#>)  异步执行
    // dispatch_sync(<#dispatch_queue_t queue#>, <#^(void)block#>) 同步执行  不能在主队列中调用 因为无限期的阻止主线程将导致死锁 通过GCD提交主队列的任务必须是异步提交
    
    //并行队列 全局
    //  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //串行队列
   // dispatch_queue_t queuefirst = dispatch_queue_create("first_qeue", NULL);
    
    //获取主队列 全局
  //  dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    NSLog(@"block=========%d",block(3));
    stringBlock("adc","cba");
    
    blockme();
    
    char *myCharacters[3] = { "TomJohn", "George", "Charles Condomine" };
    
    //内部块
    qsort_b(myCharacters, 3, sizeof(char *), ^(const void *l, const void *r) {
        char *left = *(char **)l;
        char *right = *(char **)r;
        return strncmp(left, right, 1);
    });
    
    
    

    
    
    
    //串行队列
  //  dispatch_queue_t queuefirst = dispatch_queue_create("first_qeue", NULL);
    
    //   dispatch
    /* 更新 ui 任务必须在主线成里更新 所以只能在主队列里 */
    
    //获取主队列 全局
    // dispatch_get_main_queue();
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    //    dispatch_async(mainQueue, ^(void){
    //
    //
    //      [[[UIAlertView alloc]initWithTitle:@"GCD" message:@"GCD" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show ];
    //
    //
    //    });
    
    
    AlertViewData *countext = (AlertViewData *)malloc(sizeof(AlertViewData));
    
    if (countext != NULL )
    {
        countext->title ="Mr LENG";
        countext ->message = "GCD HELLO";
        countext ->cancelButtonTitle = "OK";
        dispatch_async_f(mainQueue, (void *)countext,displayAlertView);
    }
    
    
    
    NSArray *array = @[@"A", @"B", @"C", @"A", @"B", @"Z", @"G", @"are", @"Q"];
    NSSet *filterSet = [NSSet setWithObjects: @"A", @"Z", @"Q", nil];
    
    
    
    
    
    
    
    BOOL (^test)(id obj, NSUInteger idx, BOOL *stop);
    
    test = ^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx < 5) {
            if ([filterSet containsObject: obj]) {
                return YES;
            }
        }
        return NO;
    };
    NSIndexSet *indexes = [array indexesOfObjectsPassingTest:test];
    NSLog(@"indexes: %@\n", indexes);
    
    
    [self witchblock];
    [self witchblock1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 异步线程
-(void)asyFunction
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        int i =1;
        while (i != 0)
        {
            NSLog(@"hello ios");
        }
        
        
    });

}

#pragma 处理数据更新Ui
-(void)relatedUi
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 下载图片等 耗时的操作  
        int sum = 0;
        for (int i = 0; i < 10; i++)
        {
            sum += i;
        }
        
        NSLog(@"sum ==  %d",sum);
        if (sum == 45) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"更新UI" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            });
        }
      
    });
    
}

#pragma mark 同步并发
// 在主线程中
-(void)queueFunciton
{
    dispatch_queue_t conncurrenQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_sync(conncurrenQueue, ^{
        
        int sum = 0;
        for (int i = 10; i <= 100 ; i++)
        {
            sum = sum + i;
            NSLog(@"sum2 =  %d",sum);
        }
        
        
    });
    
    dispatch_sync(conncurrenQueue, ^{
        
        int sum = 0;
        for (int i = 1; i <= 100 ; i++)
        {
            sum = sum + i;
            NSLog(@"sum3 =  %d",sum);
        }
        
        
    });
}

#pragma mark--
#pragma mark 延时执行
-(void)delayDoSomething
{
     double delaySeconds = 4;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delaySeconds*NSEC_PER_SEC);
   dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // code to be executed on the main queue after delay
       
       
       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"延时执行的" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
       [alert show];
       
    });

}

#pragma 在程序的生命周期中只执行一次 在单例模式下应用
-(void)ontToKen
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _titleLabel.text = @" hello ios ";
        
    });
}

#pragma mark 一段程序执行多次
-(void)moreDoOneThing
{
    int times = 10;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_apply(times, queue, ^(size_t index) {
        // do sth. 10 times
        
        NSLog(@"hello gcd");
    });
}
#pragma mark--
#pragma mark 分组更新ui
-(void)taskGroupGcd
{
    dispatch_group_t taskGroup = dispatch_group_create();
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    /* reload the button title */
    dispatch_group_async(taskGroup, mainQueue, ^{
    
        [self changeButtonTitle ];
    
    });
    
    //reload  the view titile
    dispatch_group_async(taskGroup, mainQueue, ^{
        
        [self changeTitle];
        
    });
    
    // show alertview
    dispatch_group_async(taskGroup, mainQueue, ^{
        
        [self alertShowFuction];
        
    });
}



-(void)changeTitle
{
    _titleLabel.text = @"hello GCD";
}


-(void)alertShowFuction
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"task ok" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
-(void)changeButtonTitle
{
    [_taskGroupButton setTitle:@"hello" forState:UIControlStateNormal];
}

- (IBAction)relatedUiAction:(id)sender
{
    [self relatedUi];
}

- (IBAction)sycQueueAction:(id)sender
{
    [self queueFunciton];
}

- (IBAction)delayEventAction:(id)sender
{
    [self  delayDoSomething];
}

- (IBAction)taskGroupAction:(id)sender
{
    [self taskGroupGcd];
}

- (IBAction)timesDoSomething:(id)sender
{
    
    [self moreDoOneThing];
}

- (IBAction)ontTaskAction:(id)sender
{
    [self  ontToKen];
}

- (IBAction)asyQueueAction:(id)sender
{
    [self asyFunction];
}


//////////////////////black /////////////////////////////////
void displayAlertView(void * paramContext)
{
    
    AlertViewData *alertData= (AlertViewData *)paramContext;
    
    NSString *title = [NSString stringWithUTF8String:alertData->title];
    NSString *cancelButtonTitle = [NSString stringWithUTF8String:alertData->cancelButtonTitle];
    NSString *message = [NSString stringWithUTF8String:alertData->message];
    
    [[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil]show ];
    
    free(alertData);
    
}



//没有参数
void(^blockme)(void) = ^
{
    
    printf("good\n");
    
};
//一个参数
int(^ block)(int) = ^(int  number)
{
    return number*x;
    
};


//多个参数
void(^stringBlock)(char*,char*) = ^(char* a, char *b)
{
    
    printf("a ==== %s\n",a);
    printf("b ===== %s\n",b);
    
    
};


-(void)witchblock
{
    
    int value1 = 1;
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"obj1",@"obj2",nil];
    
    [array sortUsingComparator:^NSComparisonResult(id obj, id obj1){
        
        int value2 = 2;
        //在块里只能读value1 但不能写， 这时我们可以增加 __block前缀 来共享变量value1  例子见 witchblock1
        NSLog(@"valude1 = %d valude2 = %d",value1,value2 );
        
        return NSOrderedSame;
    }];
}


-(void)witchblock1
{
    
    __block int value1 = 1;
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"obj1",@"obj2",nil];
    
    [array sortUsingComparator:^NSComparisonResult(id obj, id obj1){
        
        int value2 = 2;
        value1 = 10;
        //在块里只能读value1 但不能写， 这时我们可以增加 _block前缀 来共享变量value1  例子见 witchblock1
        NSLog(@"valude1 = %d valude2 = %d",value1,value2 );
        
        return NSOrderedSame;
    }];
}



@end
