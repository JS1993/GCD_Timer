//
//  ViewController.m
//  GCD_Timer
//
//  Created by  江苏 on 16/5/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)dispatch_source_t timer;

@end

@implementation ViewController

- (void)viewDidLoad {
   
    
}


int count = 0;

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //创建队列
    dispatch_queue_t queue=dispatch_get_main_queue();
    
    //创建source
    self.timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置开始时间
    dispatch_time_t startTime=dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0*NSEC_PER_SEC));
    
    //时间间隔
    uint64_t interval=(uint64_t)(1.0*NSEC_PER_SEC);
   
    //设置定时器
    dispatch_source_set_timer(self.timer, startTime, interval, 0);
    
    //设置回掉
    dispatch_source_set_event_handler(self.timer, ^{
       
        NSLog(@"%@",[NSThread currentThread]);
        
        count++;
        
        //当完成10次调用后，取消定时器
        if (count==10) {
            
            //取消定时器
            dispatch_cancel(self.timer);
            
            self.timer=nil;
        }
        
    });
    
    //启动定时器
    dispatch_resume(self.timer);
    
}
@end
