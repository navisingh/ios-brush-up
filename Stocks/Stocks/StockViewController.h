//
//  StockViewController.h
//  Stocks
//
//  Created by Navi Singh on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    
}

@property(nonatomic, retain) NSMutableDictionary *stocks;
@property(nonatomic, retain) NSArray *datasource;
- (void) setupArray;

@end
