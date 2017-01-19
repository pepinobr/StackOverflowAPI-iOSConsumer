//
//  UserTableViewCell.m
//  StackAPIConsumer
//
//  Created by Christian Becker Pepino on 19/01/17.
//  Copyright © 2017 Christian Becker Pepino. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)prepareForReuse
{
    self.avatarImageView.image = nil;               //Don't let imageview have an image when reused
    
}
@end
