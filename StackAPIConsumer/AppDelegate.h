//
//  AppDelegate.h
//  StackAPIConsumer
//
//  Created by Christian Becker Pepino on 18/01/17.
//  Copyright © 2017 Christian Becker Pepino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

