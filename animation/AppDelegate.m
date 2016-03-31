//
//  AppDelegate.m
//  animation
//
//  Created by Kyon on 16/3/24.
//  Copyright © 2016年 Kyon. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window.backgroundColor = [UIColor colorWithRed:241/255.0 green:196/255.0 blue:15/255.0 alpha:1];
    [self.window makeKeyAndVisible];
    
    
    // rootViewController from StoryBoard
    UIStoryboard *stroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *nav = [stroyBoard instantiateViewControllerWithIdentifier:@"navigationController"];
    
    self.window.rootViewController = nav;
    
    //  logo mask
    nav.view.layer.mask = [CALayer layer];
    nav.view.layer.mask.contents = (__bridge id _Nullable)([UIImage imageNamed:@"logo"].CGImage);
    nav.view.layer.mask.bounds = CGRectMake(0, 0, 60, 60);
    nav.view.layer.mask.anchorPoint = CGPointMake(0.5, 0.5);
    nav.view.layer.mask.position = CGPointMake(nav.view.frame.size.width / 2, nav.view.frame.size.height / 2);
    UIView *maskBgView = [[UIView alloc] initWithFrame:nav.view.frame];
    [maskBgView setBackgroundColor:[UIColor whiteColor]];
    [nav.view addSubview:maskBgView];
    [nav.view bringSubviewToFront:maskBgView];
    

    CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    transformAnimation.delegate = self;
    transformAnimation.duration = 1;
    transformAnimation.beginTime = CACurrentMediaTime() + 1;
    
    NSValue *initalBounds = [NSValue valueWithCGRect:nav.view.layer.mask.bounds];
    NSValue *secondBounds = [NSValue valueWithCGRect:CGRectMake(0, 0, 50, 50)];
    NSValue *finalBounds = [NSValue valueWithCGRect:CGRectMake(0, 0, 2000, 2000)];
    [transformAnimation setValues:@[initalBounds, secondBounds, finalBounds]];
    [transformAnimation setKeyTimes:@[@0, @0.5, @1]];
    [transformAnimation setTimingFunctions:@[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]]];
    [transformAnimation setRemovedOnCompletion:NO];
    [transformAnimation setFillMode:kCAFillModeForwards];
    [nav.view.layer.mask addAnimation:transformAnimation forKey:@"maskAnimation"];
    
    // logo mask background view animation
    [UIView animateWithDuration:0.1 delay:1.35 options:UIViewAnimationOptionCurveEaseIn animations:^{
        maskBgView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [maskBgView removeFromSuperview];
    }];
    
    // root view animation
    [UIView animateWithDuration:0.25 delay:1.3 options:UIViewAnimationOptionTransitionNone animations:^{
        [self.window.rootViewController.view setTransform:CGAffineTransformMakeScale(1.05, 1.05)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.window.rootViewController.view setTransform:CGAffineTransformIdentity];
        } completion:nil];
    }];
    
    return YES;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.window.rootViewController.view.layer setMask:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
