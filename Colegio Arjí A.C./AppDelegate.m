//
//  AppDelegate.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import "AppDelegate.h"
#import "Singleton.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize Singleton;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    if (launchOptions != nil)
    {
        NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dictionary != nil)
        {
            NSLog(@"Launched from push notification: %@", dictionary);
            
            [self clearNotifications];
        }
    }else{
    
        self.Singleton  = [Singleton sharedMySingleton];
        
        
        UIDevice *myDevice=[UIDevice currentDevice];
        NSString *UUID = [[myDevice identifierForVendor] UUIDString];
        
        self.Singleton.uniqueIdentifier = UUID;
        self.Singleton.typeDevice = @"1";
        NSLog(@"UUID: %@",UUID);
        
        myDevice = nil;
        UUID = nil;

        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
    #ifdef __IPHONE_8_0
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                                 | UIUserNotificationTypeBadge
                                                                                                 | UIUserNotificationTypeSound) categories:nil];
            [application registerUserNotificationSettings:settings];
    #endif
        
        } else {
            
            /*
             
            UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
            [application registerForRemoteNotificationTypes:myTypes];
            
             */
            
        }
        
    }
    
    
    return YES;
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToke{
    self.Singleton.tokenUser = [[NSString alloc] initWithFormat:@"%@",deviceToke] ;
    
    NSString *new = [self.Singleton.tokenUser stringByReplacingOccurrencesOfString: @" " withString:@""];
    new = [new stringByReplacingOccurrencesOfString: @"<" withString:@""];
    new = [new stringByReplacingOccurrencesOfString: @">" withString:@""];
    self.Singleton.tokenUser = new;
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"Remote Notification Recieved...");
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    //notification.alertBody =  @"Looks like i got a notification - fetch thingy";
    [application presentLocalNotificationNow:notification];
    completionHandler(UIBackgroundFetchResultNewData);
    /*
     UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Título"
     message:@"Esto es una prueba"
     delegate:self
     cancelButtonTitle:@"Aceptar"
     otherButtonTitles:@"Botón 1", @"Botón 2", nil];
     [alertView show];
     */
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    NSLog(@"Contenido del JSON: %@", userInfo);
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody =  @"Looks like i got a notification - fetch thingy";
    [application presentLocalNotificationNow:notification];
    //completionHandler(UIBackgroundFetchResultNewData);
    
    
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

- (void) clearNotifications {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}



@end
