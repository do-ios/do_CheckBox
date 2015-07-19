//
//  ViewController.m
//  Do_Test
//
//  Created by linliyuan on 15/4/27.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "ViewController.h"
#import "doPage.h"
#import "doService.h"
#import "doModuleFactory.h"

@interface ViewController ()
{
@private
    NSString *Type;
    doModule* model;
}
@end
@implementation CallBackEvnet

-(void)eventCallBack:(NSString *)_data
{
    NSLog(@"异步方法回调数据:%@",_data);
}

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitInstance];
    [self ConfigUI];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cb_green_off" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    NSData *data = UIImagePNGRepresentation(image);
//    NSString *_encode = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    NSLog(@"_encode = %@",_encode);
    
//    return;
    
    NSString *img = @"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";
    
    
    NSString *img_off = @"iVBORw0KGgoAAAANSUhEUgAAABYAAAAWCAYAAADEtGw7AAAAAXNSR0IArs4c6QAAABxpRE9UAAAAAgAAAAAAAAALAAAAKAAAAAsAAAALAAACB9dQ++IAAAHTSURBVEgNlFLJTgJBEJ2D/pbLWRQUEDf0AzQhKho1xMDBizFGoxBlG2DUuKEDA56MRA/ggsvX6LGsVz1tDIkHDy/VXcurV9VtNBrUdduI7983F6n5EqVWe5Ge3pcFz+8r9PKxSo9vS4QzoGPif41S83WF6xa4bokeWlG6u48n2+12t1E8nfVadvgzdeGh7LWPclU/FZ0xKtXGGZNk1cJicTdrISqIX8XgQ262MkIZe5jSZQ+V7Jkv62TOZ2zs9c8fXg5SjgMAEo9uwowZ1+KsUKxPkVWf/hVXOdK0Mir1qTMPJXZ65421zZ7IwfkgmRwoVENCbDEByEAEe+w20VY3RRPkgjjPtRAGkbGtvogR2+qJZK68Qpx3ApStsnJeB6zJFudOmNWg6wsSanJ8x6QgPigPUWLXJVar8FPBUaqhHAo6of0g1jE9Je5mJUDpSy+tsVhjfbtPFOf5AfBYJYdH+weKzoTUoQEUgxicsgqtGCOJGlauxsXICqKQ/aLMzdP5yEWDnO13d8yKsWO8JMaQVWAd/0ZAPaAdFOIfxWleOLrp/6vGwx/lMXktsJ3QfvwInPHAsmPmglgDi06eDwgx9qSBJvphcNb3v+LwQ1ym7BPibwAAAP//3wh7owAAAeRJREFUpVFLTxNhFP12rl21P6A74x6TSkho+i4iQpGfwGrSBQk2hIQ0UcBpHaalUNrpA8rLgKXgf+H7N9dzrozMxo1Ocue+zj338Zktd9Y5uV2QwbQspz/X/llGDx8luHsv3R/vZKcx7xj+6JxMFqX/UBYChtD9+1XVQ+qojVw0T1xY0wPH8feSbDfmHLPtzjl02G0wXZbgfkX14En/9ssSYCNuRT8U4sOa/nRJOdrXReEVzMZu0vEv89KbLGkhAQRTR+UPyd0HEDxLiGG+M1mQFriUuLo76zQvi3KMO3PqqLBZ1A9trhza1CGOJ21dFKSKK+jE3jgnzauCHp7J7u3isx31/xbnG2EwnsE7zwuvYCq1N05jmNFOR7h156akgM4NGjwVsOgI8RYKtTHixDHO96GwltN6o7zwCmbzy9tKvZ8R7xRTo5vKRU4OcZ5DbNG+KqnNd2gyjhgbHADLTYkL676NsuIGaanUZipmq5Ze/9rLyV43pUEmfRS4g6w288cFOTjLI1ZQqSPPIRirD3NquxisAfx+Ny3k2thJrZtkMvny0+dM2w2yj/tB2qKjBbkF0PrjosVqaoPIgtCCxPqIecgTQ2HNXi9lQfxYBRc5Db9EIvEiHo+/isVir/9HyEEucv4C2kidCQj5FesAAAAASUVORK5CYII=";
    
    NSData *i = [[NSData alloc] initWithBase64EncodedString:img_off options:NSDataBase64DecodingIgnoreUnknownCharacters];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithData:i]]];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void) InitInstance
{
    NSString *testPath = [[NSBundle mainBundle] pathForResource:@"do_Test" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:testPath];
    NSMutableDictionary *_testDics = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    Type = [_testDics valueForKey:@"Type"];
    //在下面构造model
    //model = [[xxxx alloc]init];
    
    [doServiceContainer Instance].SingletonModuleFactory =  [[doModuleFactory alloc]init:model];
    
    //如果是UI类型，还需要构造view
    //UIView* view = [[xxxxView alloc]init];
    
}
- (void)ConfigUI {
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    //在对应的测试按钮添加自己的测试代码, 如果6个测试按钮不够，可以自己添加
    
    if([Type isEqualToString:@"UI"]){
        //和SM，MM不一样，UI类型还得添加自己的View，所以测试按钮都在底部
        CGFloat height = h/6;
        CGFloat width = (w - 35)/6;
        for(int i = 0;i<6;i++){
            UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
            test.frame = CGRectMake(5*(i+1)+width*i, h-h/6, width, height);
            NSString* title = [NSString stringWithFormat:@"Test%d",i ];
            [test setTitle:title forState:UIControlStateNormal];
            SEL customSelector = NSSelectorFromString([NSString stringWithFormat:@"test%d:",i]);
            [test addTarget:self action:customSelector forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:test];
        }
        //addsubview 自定义的UI
        
    }else{
        CGFloat height = (h-140)/6;
        CGFloat width = w - 60;
        for(int i = 0;i<6;i++){
            UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
            test.frame = CGRectMake(30, 20*(i+1)+height*i, width, height);
            NSString* title = [NSString stringWithFormat:@"Test%d",i ];
            [test setTitle:title forState:UIControlStateNormal];
            SEL customSelector = NSSelectorFromString([NSString stringWithFormat:@"test%d:",i]);
            [test addTarget:self action:customSelector forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:test];
        }
    }
}

- (void)test0:(UIButton *)sender
{
    NSLog(@"请添加自己的测试代码");
}
- (void)test1:(UIButton *)sender
{
    NSLog(@"请添加自己的测试代码");
    //执行同步方法
    //NSMutableDictionary* node = [[NSMutableDictionary alloc]init];
    //[node setObject:参数值 forKey:参数名];
    //[[doService Instance] SyncMethod:model :同步方法名 :node];
    
}
- (void)test2:(UIButton *)sender
{
    NSLog(@"请添加自己的测试代码");
    //执行异步方法
    //NSMutableDictionary* node = [[NSMutableDictionary alloc]init];
    //[node setObject:参数值 forKey:参数名];
    //CallBackEvnet* event = [[CallBackEvnet alloc]init];//回调类
    //[[doService Instance] AsyncMethod:model :异步步方法名 :node:event];

}
- (void)test3:(UIButton *)sender
{
    NSLog(@"请添加自己的测试代码");
}
- (void)test4:(UIButton *)sender
{
    NSLog(@"请添加自己的测试代码");
}
- (void)test5:(UIButton *)sender
{
    NSLog(@"请添加自己的测试代码");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
