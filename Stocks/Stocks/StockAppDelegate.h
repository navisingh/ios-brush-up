//
//  StockAppDelegate.h
//  Stocks
//
//  Created by Navi Singh on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoogleSpreadsheetWrapper;

@interface StockAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GoogleSpreadsheetWrapper *googleSpreadsheetWrapper;

@end
