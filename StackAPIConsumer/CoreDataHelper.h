//
//  CoreDataHelper.h
//  StackAPIConsumer
//
//  Created by Christian Becker Pepino on 18/01/17.
//  Copyright © 2017 Christian Becker Pepino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User+CoreDataProperties.h"
@interface CoreDataHelper : NSObject

+ (void)removeAllUsers;

+ (NSArray*)allUsers;

+ (void)insertUserWithDic:(NSDictionary*)userDic;

+ (void)storeGravatarImageData:(NSData*)data forUser:(User*)user;

+ (void)save;



@end
