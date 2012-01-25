//
//  DetailViewController.h
//  Stocks
//
//  Created by Navi Singh on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GDataFeedSpreadsheet;
@class GDataEntrySpreadsheet;

@class GDataFeedWorksheet;
@class GDataEntryWorksheet;

@class GDataFeedBase;

@interface DetailViewController : UIViewController
{
    NSString *stock;
    NSString *url;
    
    //get the spreadsheet feed, then spreadsheet
    BOOL isSpreadsheetFetchPending_;
    NSError *spreadsheetFetchError_;
    GDataFeedSpreadsheet *spreadsheetFeed_;
    GDataEntrySpreadsheet *spreadsheet_;
    
    //get the worksheet feed, then the worksheet
    BOOL isWorksheetFetchPending_;
    NSError *worksheetFetchError_;
    GDataFeedWorksheet *worksheetFeed_;
    GDataEntryWorksheet *worksheet_;
    
    //get the individual cell
    BOOL isEntryFetchPending_;
    NSError *entryFetchError_;
    GDataFeedBase *entryFeed_;
    
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
