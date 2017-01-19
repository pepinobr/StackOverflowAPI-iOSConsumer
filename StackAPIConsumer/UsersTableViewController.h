//
//  UsersTableViewController.h
//  StackAPIConsumer
//
//  Created by Christian Becker Pepino on 18/01/17.
//  Copyright © 2017 Christian Becker Pepino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsersTableViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *users;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
