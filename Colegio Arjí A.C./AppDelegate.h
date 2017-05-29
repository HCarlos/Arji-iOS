//
//  AppDelegate.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
#import <UserNotifications/UserNotifications.h>
// #import "Firebase/Firebase.h"

@interface AppDelegate : UIResponder   <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) Singleton *Singleton;

@end

