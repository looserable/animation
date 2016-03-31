//
//  ViewController.m
//  animation
//
//  Created by Kyon on 16/3/24.
//  Copyright © 2016年 Kyon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    BOOL done;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
   
    [self performSelectorOnMainThread:@selector(testMethod:) withObject:@3 waitUntilDone:done];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"haha");
        done = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"第三啊");
        });
    });
    
}

- (void)testMethod:(NSNumber*)canShu{
    NSLog(@"%@",canShu);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
