//
//  WazaapTableViewController.h
//  wazaapDemo
//
//  Created by Navi Singh on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WazaapEntity;
@interface WazaapTableViewController : UITableViewController
{
}
@property (nonatomic, strong) WazaapEntity *entity;
@property (nonatomic, strong) NSMutableArray *entities;
@property (nonatomic, strong) NSMutableData *connectionData;

@end


