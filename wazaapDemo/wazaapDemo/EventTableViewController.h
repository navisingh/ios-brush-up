//
//  EventTableViewController.h
//  wazaapDemo
//
//  Created by Navi Singh on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewController : UITableViewController
{
    NSMutableData *connectionData;

}

@property (nonatomic, strong) NSMutableData *connectionData;

@end
