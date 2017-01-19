//
//  CoreDataHelper.m
//  StackAPIConsumer
//
//  Created by Christian Becker Pepino on 18/01/17.
//  Copyright © 2017 Christian Becker Pepino. All rights reserved.
//

#import "CoreDataHelper.h"
#import "AppDelegate.h"

@implementation CoreDataHelper

//Erases the database
+ (void)removeAllUsers {
    
    NSPersistentContainer *persistentContainer = [(AppDelegate*)[[UIApplication sharedApplication] delegate] persistentContainer];
    NSManagedObjectContext *context = persistentContainer.viewContext;
    
    for(User *usr in [self allUsers])
    {
        [context deleteObject:usr];
        
    }
    
}


//Fetches all users the database
+ (NSArray*)allUsers {
    
    NSPersistentContainer *persistentContainer = [(AppDelegate*)[[UIApplication sharedApplication] delegate] persistentContainer];
    NSManagedObjectContext *context = persistentContainer.viewContext;
    NSArray __block *users;
    
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSFetchRequest *request = [User fetchRequest];
        users =  [context executeFetchRequest:request error:nil];
        
    });
    
    return users;
}


//Insert a new user in database using his dictionary
+ (void)insertUserWithDic:(NSDictionary*)userDic {
    
    NSPersistentContainer *persistentContainer = [(AppDelegate*)[[UIApplication sharedApplication] delegate] persistentContainer];
    NSManagedObjectContext *context = persistentContainer. viewContext;
    
    
    
    
    
    dispatch_sync(dispatch_get_main_queue(), ^{            //Insert using main queue to avoid race conditions
       
        
            User * user;
            user = [NSEntityDescription
                    insertNewObjectForEntityForName:@"User"
                    inManagedObjectContext:context];
            
            user.username = userDic[@"display_name"];
            user.gravatarURL = userDic[@"profile_image"];
            user.bronzeBadges = [userDic[@"badge_counts"][@"bronze"] intValue];
            user.silverBadges = [userDic[@"badge_counts"][@"silver"] intValue];
            user.goldBadges = [userDic[@"badge_counts"][@"gold"] intValue];
        
        
    });
    
    
    
    
}


+ (void)storeGravatarImageData:(NSData*)data forUser:(User*)user
{
    user.gravatarData = data;
}


//Stores the database
+ (void)save
{
    
    NSPersistentContainer *persistentContainer = [(AppDelegate*)[[UIApplication sharedApplication] delegate] persistentContainer];
    NSManagedObjectContext *context = persistentContainer.viewContext;

    
    dispatch_async(dispatch_get_main_queue(), ^{            //Store using main queue to avoid race conditions
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"whoopsies, couldn't save: %@", [error localizedDescription]);
        }
        
    });
    
    
}

@end
