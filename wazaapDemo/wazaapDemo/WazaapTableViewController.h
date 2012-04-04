//
//  WazaapTableViewController.h
//  wazaapDemo
//
//  Created by Navi Singh on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wazaapConnector.h"

@class WazaapEntity;
@interface WazaapTableViewController : UITableViewController <WazaapConnectorDelegate>
{
}

@property (nonatomic, strong) WazaapEntity *entity;
@property (nonatomic, strong) NSMutableArray *entities;
@property (nonatomic, strong) WazaapConnector *connectorDelegate;

@end


