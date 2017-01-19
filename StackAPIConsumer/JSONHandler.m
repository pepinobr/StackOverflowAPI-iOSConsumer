//
//  JSONHandler.m
//  StackAPIConsumer
//
//  Created by Christian Becker Pepino on 18/01/17.
//  Copyright © 2017 Christian Becker Pepino. All rights reserved.
//

#import "JSONHandler.h"
#import "CoreDataHelper.h"

@implementation JSONHandler


+(void)handleJSONData:(NSData*)data {
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error != nil) {
        NSLog(@"whoopsies, JSON Error:%@", [error localizedDescription]);
    }
    else
    {
        if(json)                                        //If JSON is valid
        {
            
            [CoreDataHelper removeAllUsers];            //Remove old database
            
            for(NSDictionary *user in json[@"items"]) {         //Insert all users from JSON in database
                
                [CoreDataHelper insertUserWithDic:user];
                
            }
        }
    }
    
    [CoreDataHelper save];                      //Store database
    
}
@end
