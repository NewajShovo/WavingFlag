//
//  AppDelegate.m
//  WavingFlag
//
//  Created by leo on 24/12/20.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *root = [[UINavigationController alloc]initWithRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"WFMainVC"]];
    root.navigationBar.translucent = YES;
    [root.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    root.navigationBar.shadowImage = [UIImage new];
    self.window.rootViewController= root;

    return YES;
}



@end
