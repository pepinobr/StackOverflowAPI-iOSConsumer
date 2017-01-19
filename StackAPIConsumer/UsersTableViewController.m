//
//  UsersTableViewController.m
//  StackAPIConsumer
//
//  Created by Christian Becker Pepino on 18/01/17.
//  Copyright © 2017 Christian Becker Pepino. All rights reserved.
//

#import "UsersTableViewController.h"
#import "UserTableViewCell.h"
#import "JSONHandler.h"
#import "CoreDataHelper.h"
#import "User+CoreDataProperties.h"

@interface UsersTableViewController ()

@end

@implementation UsersTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.stackexchange.com/2.2/users?site=stackoverflow"];
    
    //Dispatch task to refresh database
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error)
        {
            [self showConnectionErrorAlert];            //Warn the user that there's no connection and therefore the offline local database will be used.
        }
        else
        {
            if (data) {
                
                [JSONHandler handleJSONData:data];          //If users JSON was received, process it and update the database
                
            }
            
        }
        
        NSLog(@"Response:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        users = [CoreDataHelper allUsers];              //Get all users from local database
        
        if (users) {
            dispatch_async(dispatch_get_main_queue(), ^{        //Trigger UI updates on main queue
                [self.activityIndicator stopAnimating];
                [self.tableView reloadData];
                
            });
            
        }
        
    }];
    
    [task resume];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [users count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    
    User *user = users[indexPath.row];
    
    cell.userNameLabel.text = user.username;
    cell.badgesLabel.text = [NSString stringWithFormat:@"Gold:%d Silver:%d Bronze:%d",user.goldBadges,user.silverBadges,user.bronzeBadges];
    [cell.activityIndicator startAnimating];
    
    if(user.gravatarData)                   //If image is already stored offline, use it
    {
        cell.avatarImageView.image = [UIImage imageWithData:user.gravatarData];
        cell.avatarImageView.alpha = 1;
        [cell.activityIndicator stopAnimating];
    }
    else
    {
        
        NSURL *url = [NSURL URLWithString: user.gravatarURL];   //Load image from server asynchronously
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (data) {
                
                UIImage *avatarImage =  [UIImage imageWithData:data];
                
                if(avatarImage) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{            //Perform UI updates on main queue
                        [CoreDataHelper storeGravatarImageData:data forUser:user];
                        UserTableViewCell *userCell = [tableView cellForRowAtIndexPath:indexPath];
                        if (userCell) {
                            userCell.avatarImageView.image = [UIImage imageWithData:user.gravatarData];  //Update tableviewcell with loaded image
                            userCell.avatarImageView.alpha = 1;
                            [userCell.activityIndicator stopAnimating];
                            
                        }
                    });
                }
                
            }
            
        }];
        
        [task resume];
    }
    
    
    return cell;
}




- (void)showConnectionErrorAlert
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Connection Error" message:@"The app is presenting it's offline database" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
