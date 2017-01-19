//
//  UserTableViewCell.h
//  StackAPIConsumer
//
//  Created by Christian Becker Pepino on 19/01/17.
//  Copyright © 2017 Christian Becker Pepino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgesLabel;

@end
