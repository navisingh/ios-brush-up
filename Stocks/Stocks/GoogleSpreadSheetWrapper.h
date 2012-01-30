//
//  GoogleSpreadSheetWrapper.h
//  Stocks
//
//  Created by Navi Singh on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GDataFeedSpreadsheet;
@class GDataEntrySpreadsheet;

@class GDataFeedWorksheet;
@class GDataEntryWorksheet;

@class GDataFeedBase;


@interface GoogleSpreadsheetWrapper : NSObject
{
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
}

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;


- (void)connect:(id)sender;
- (void)updateHoldings:(id)sender;
- (void)updateWatch:(id)sender;

@end
