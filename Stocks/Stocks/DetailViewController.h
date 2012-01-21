//
//  DetailViewController.h
//  Stocks
//
//  Created by Navi Singh on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GDataFeedSpreadsheet;

@interface DetailViewController : UIViewController
{
    NSString *stock;
    NSString *url;
    
    BOOL isSpreadsheetFetchPending_;
    NSError *spreadsheetFetchError_;
    GDataFeedSpreadsheet *spreadsheetFeed_;
    
    IBOutlet UIActivityIndicatorView *connectionProgressIndicator_;
}


@property (strong, nonatomic) NSString *stock, *url;
@property (strong, nonatomic) IBOutlet UILabel *stockLabel, *stockURL;

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;


- (IBAction)connect:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
