//
//  BaseTableViewController.h
//  wazaapDemo
//
//  Created by Navi Singh on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@interface BaseTableViewController : UITableViewController
{
}

@property (nonatomic, strong) NSArray *entities;
@property (nonatomic, strong) DetailViewController *detailViewController; 

@end
