//
//  DetailViewController.m
//  Stocks
//
//  Created by Navi Singh on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "GData-ARC.h"
#import "KeychainItemWrapper.h"

@interface DetailViewController (PrivateMethods)

- (void)updateUI;

- (void)fetchFeedOfSpreadsheets;
- (void)fetchSelectedSpreadsheet;
- (void)fetchSelectedWorksheet;

- (GDataServiceGoogleSpreadsheet *)spreadsheetService;
- (GDataEntrySpreadsheet *)selectedSpreadsheet;
- (GDataEntryWorksheet *)selectedWorksheet;
- (GDataEntryBase *)selectedEntry;

- (GDataFeedSpreadsheet *)spreadsheetFeed;
- (void)setSpreadsheetFeed:(GDataFeedSpreadsheet *)feed;
- (NSError *)spreadsheetFetchError;
- (void)setSpreadsheetFetchError:(NSError *)error;  

- (GDataFeedWorksheet *)worksheetFeed;
- (void)setWorksheetFeed:(GDataFeedWorksheet *)feed;
- (NSError *)worksheetFetchError;
- (void)setWorksheetFetchError:(NSError *)error;

- (GDataFeedBase *)entryFeed;
- (void)setEntryFeed:(GDataFeedBase *)feed;
- (NSError *)entryFetchError;
- (void)setEntryFetchError:(NSError *)error;

- (void) displayCells;
- (void) displayRows;

@end


@implementation DetailViewController
@synthesize username;
@synthesize password;

@synthesize stock, url, stockLabel, stockURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    stockLabel.text = self.stock;
    stockURL.text = self.url;
}


- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setPassword:nil];
    connectionProgressIndicator_ = nil;
    connectionProgressIndicator_ = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancel:(id)sender
{
    
}
- (IBAction)done:(id)sender
{
}
- (IBAction)connect:(id)sender
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSString *u = [username text];
    u = [u stringByTrimmingCharactersInSet:whitespace];
    
    if ([u rangeOfString:@"@"].location == NSNotFound) {
        // if no domain was supplied, add @gmail.com
        u = [u stringByAppendingString:@"@gmail.com"];
    }
    
    username.text = u;
    
    {
        KeychainItemWrapper *keychain = 
        [[KeychainItemWrapper alloc] initWithIdentifier:@"TestAppLoginData" accessGroup:nil];
        [keychain setObject:[username text] forKey:(__bridge id)kSecAttrAccount];
        [keychain setObject:[password text] forKey:(__bridge id)kSecValueData];
    }
  
    {
        KeychainItemWrapper *keychain = 
        [[KeychainItemWrapper alloc] initWithIdentifier:@"TestAppLoginData" accessGroup:nil];
        NSString *uu = [keychain objectForKey:(__bridge id)kSecAttrAccount];
        NSString *pp = [keychain objectForKey:(__bridge id)kSecValueData];
    }
    
    [self fetchFeedOfSpreadsheets];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == password) {
        
        [textField resignFirstResponder];
        [self connect:self];
    }
    return NO;
}


// get a spreadsheet service object with the current username/password
//
// A "service" object handles networking tasks.  Service objects
// contain user authentication information as well as networking
// state information (such as cookies and the "last modified" date for
// fetched data.)
- (GDataServiceGoogleSpreadsheet *)spreadsheetService {
    
    static GDataServiceGoogleSpreadsheet* service = nil;
    
    if (!service) {
        service = [[GDataServiceGoogleSpreadsheet alloc] init];
        
        [service setShouldCacheResponseData:YES];
        [service setServiceShouldFollowNextLinks:YES];
    }
    
    [service setUserCredentialsWithUsername:username.text
                                   password:password.text];
    
    return service;
}


// begin retrieving the list of the user's spreadsheets
- (void)fetchFeedOfSpreadsheets {
    
    spreadsheetFeed_ = nil;
    spreadsheet_ = nil;
    
//    [self setSpreadsheetFetchError:nil];
    
 //   [self setWorksheetFeed:nil];
 //   [self setWorksheetFetchError:nil];
    
 //   [self setEntryFeed:nil];
 //   [self setEntryFetchError:nil];
    
    isSpreadsheetFetchPending_ = YES;
    
    GDataServiceGoogleSpreadsheet *service = [self spreadsheetService];
    NSURL *feedURL = [NSURL URLWithString:@"https://spreadsheets.google.com/feeds/spreadsheets/private/full"];
    [service fetchFeedWithURL:feedURL
                     delegate:self
            didFinishSelector:@selector(spreadsheetFeedTicket:finishedWithFeed:error:)];
    
    [self updateUI];
}

// spreadsheet list fetch callback
- (void)spreadsheetFeedTicket:(GDataServiceTicket *)ticket
  finishedWithFeed:(GDataFeedSpreadsheet *)feed
             error:(NSError *)error {
    
    spreadsheetFeed_ = feed;
    spreadsheetFetchError_ = error;
    
    // get the spreadsheet entry's title
    if (spreadsheetFeed_) {
        int rowMax = [[spreadsheetFeed_ entries] count];
        for (int row=0; row < rowMax; row++) {
            GDataEntrySpreadsheet *spreadsheet = [[spreadsheetFeed_ entries] objectAtIndex:row];
            if (spreadsheet) {
                NSString *s = [[spreadsheet title] stringValue];
                if ([s isEqualToString:@"Investments"]) {
                    spreadsheet_ = spreadsheet;
                    
                    [self fetchSelectedSpreadsheet];
                    break;
                }
            }
        }
    }

    isSpreadsheetFetchPending_ = NO;
    
    [self updateUI];
}

// for the spreadsheet selected in the top list, begin retrieving the list of
// Worksheets
- (void)fetchSelectedSpreadsheet {
    if (spreadsheet_) {
        
        NSURL *feedURL = [spreadsheet_ worksheetsFeedURL];
        if (feedURL) {
            
            worksheetFeed_ = nil;
            worksheet_ = nil;
            
            isWorksheetFetchPending_ = YES;
            
            GDataServiceGoogleSpreadsheet *service = [self spreadsheetService];
            [service fetchFeedWithURL:feedURL
                             delegate:self
                    didFinishSelector:@selector(worksheetsFeedTicket:finishedWithFeed:error:)];
            
            [self updateUI];
        }
    }
}

// fetch worksheet feed callback
- (void)worksheetsFeedTicket:(GDataServiceTicket *)ticket
        finishedWithFeed:(GDataFeedWorksheet *)feed
                   error:(NSError *)error {
    
    worksheetFeed_ = feed;
    worksheetFetchError_ = error;
    
    if (worksheetFeed_) {
        int rowMax = [[worksheetFeed_ entries] count];
        for (int row=0; row < rowMax; row++) {
            GDataEntryWorksheet *worksheet = [[worksheetFeed_ entries] objectAtIndex:row];
            if (worksheet) {
                NSString *s = [[worksheet title] stringValue];
                if ([s isEqualToString:@"Transactions"]) {
                    worksheet_ = worksheet;
                    
                    [self fetchSelectedWorksheet];
                    break;
                }
            }
        }
    }
    
    isWorksheetFetchPending_ = NO;
    
    [self updateUI];
}

// for the worksheet selected, fetch either a cell feed or a list feed
// of its contents, depending on the segmented control's setting

- (void)fetchSelectedWorksheet 
{
    if (worksheet_) {
        
        entryFeed_ = nil;
        entryFetchError_ = nil;
        
        isEntryFetchPending_ = YES;
        GDataServiceGoogleSpreadsheet *service = [self spreadsheetService];
       
        NSURL *feedURL;
        
        if (1) 
        {
            feedURL = [[worksheet_ cellsLink] URL];
            
            if (1) {
                [service fetchFeedWithURL:feedURL
                                 delegate:self
                        didFinishSelector:@selector(entriesCellsTicket:finishedWithFeed:error:)];
            }
            else
            {
                [service fetchFeedWithURL:feedURL
                                 delegate:self
                        didFinishSelector:@selector(entriesTicket:finishedWithFeed:error:)];
            }
        }
        else
        {
            feedURL = [worksheet_ listFeedURL];
            
            if (0) {
                [service fetchFeedWithURL:feedURL
                                 delegate:self
                        didFinishSelector:@selector(entriesListTicket:finishedWithFeed:error:)];
            }
            else
            {
                [service fetchFeedWithURL:feedURL
                                 delegate:self
                        didFinishSelector:@selector(entriesTicket:finishedWithFeed:error:)];
            }
       }
        
        [self updateUI];
    }
}

// fetch entries callback
- (void)entriesTicket:(GDataServiceTicket *)ticket
     finishedWithFeed:(GDataFeedBase *)feed
                error:(NSError *)error {
    
    entryFeed_ = feed;
    entryFetchError_ = error;
    
    isEntryFetchPending_ = NO;
    
    GDataEntryBase *entry = [[entryFeed_ entries] objectAtIndex:0]; //entries is an array.  See if the 0the element is a cell.
    if ([entry isKindOfClass:[GDataEntrySpreadsheetCell class]]) 
    {
        [self displayCells];
    }
    else
    {
        [self displayRows];
    }
    
    [self updateUI];
}

// fetch entries cells callback
- (void)entriesCellsTicket:(GDataServiceTicket *)ticket
     finishedWithFeed:(GDataFeedSpreadsheetCell *)feed
                error:(NSError *)error {
    
    entryFeed_ = feed;
    entryFetchError_ = error;
    
    if (!entryFetchError_) {
        [self displayCells];
     }
    
    isEntryFetchPending_ = NO;
    
    [self updateUI];
}

// fetch entries callback
- (void)entriesListTicket:(GDataServiceTicket *)ticket
         finishedWithFeed:(GDataFeedBase *)feed
                    error:(NSError *)error {
    
    entryFeed_ = feed;
    entryFetchError_ = error;
    
    if (!entryFetchError_) {
        [self displayRows];
    }
    
    isEntryFetchPending_ = NO;
    
    [self updateUI];
}


- (void) displayCells
{
    NSString *displayStr;
    GDataFeedSpreadsheetCell *feed = (GDataFeedSpreadsheetCell *)entryFeed_;
    NSInteger rows = [feed rowCount];
    NSInteger cols = [feed columnCount];
    bool containsHoldings = false;
    NSInteger prevRowNo = -1;
    NSString *security;
    for (GDataEntrySpreadsheetCell *entry in [feed entries]) {
        GDataSpreadsheetCell *cell = [entry cell];
        NSInteger rowNo = [cell row]-1;
        NSInteger colNo = [cell column]-1;
        
        if (prevRowNo != rowNo) {
            containsHoldings = false;
            prevRowNo = rowNo;
            security = @"";
        }
        
        NSString *resultStr = [cell resultString]; // like "3.1415926"
        NSString *inputStr = [cell inputString]; // like "=pi()"
        NSString *title = [[entry title] stringValue]; // like "A3"

 //       if ([title isEqualToString:@""])
 //           continue;
        
        if (colNo == 3 && ![resultStr isEqualToString:@""]) {
            security = resultStr;
       }
        if (colNo == 1) {
            NSString *resultStr = [cell resultString]; // like "3.1415926"
            if ([resultStr isEqualToString:@"Holdings"]) {
                containsHoldings = true;
            }
        }
 //       else if(colNo > 2 && !containsHoldings)
 //           continue;
        
        
        if (containsHoldings && colNo == 11) {
            displayStr = [NSString stringWithFormat:@"%@ %@", security, resultStr];
 //           displayStr = [NSString stringWithFormat:@"%@ (%d, %d) %@: %@  %@",
 //                         security, rowNo, colNo,
 //                         title, inputStr, (resultStr ? resultStr : @"")];  
            NSLog(@"%@", displayStr);
        }
//        else
//            displayStr = [NSString stringWithFormat:@"(%d, %d) %@: %@  %@",
//                          rowNo, colNo,
//                          title, inputStr, (resultStr ? resultStr : @"")];  

    }
}

- (void) displayRows
{
    int rowMax = [[entryFeed_ entries] count];  //gotcha: the count is the count to the first blank row.  
    for (int row = 0; row < rowMax; row++) {
        GDataEntryBase *entry = [[entryFeed_ entries] objectAtIndex:row];
        
        NSString *displayStr;
        GDataEntrySpreadsheetList *listEntry = (GDataEntrySpreadsheetList *)entry;
        NSDictionary *customElements = [listEntry customElementDictionary];
        
        NSMutableArray *array = [NSMutableArray array];
        NSEnumerator *enumerator = [customElements objectEnumerator];
        GDataSpreadsheetCustomElement *element;
        
        while ((element = [enumerator nextObject]) != nil) {
            
            NSString *elemStr = [NSString stringWithFormat:@"(%@, %@)",
                                 [element name], [element stringValue]];
            [array addObject:elemStr];
        }
        displayStr = [array componentsJoinedByString:@", "];
        NSLog(@"%@", displayStr);   
    }
}


- (void)updateUI 
{
    if (isSpreadsheetFetchPending_) 
    {
        [connectionProgressIndicator_ startAnimating];  
    } 
    else 
    {
        [connectionProgressIndicator_ stopAnimating];  
    }
    
    // spreadsheet fetch result or selected item
    NSString *spreadsheetResultStr = @"";
    if (spreadsheetFetchError_) 
    {
        spreadsheetResultStr = [spreadsheetFetchError_ description];
    } 
    else if (spreadsheet_) 
    {
        spreadsheetResultStr = [spreadsheet_ description];
    } 
    
    
    if (0)//entryFeed_) 
    {
        GDataEntryBase *entry = [[entryFeed_ entries] objectAtIndex:20];
        NSString *displayStr;
        
        if ([entry isKindOfClass:[GDataEntrySpreadsheetCell class]]) {
            
            // format cell entry data
            GDataSpreadsheetCell *cell = [(GDataEntrySpreadsheetCell *)entry cell];
            
            NSString *resultStr = [cell resultString]; // like "3.1415926"
            NSString *inputStr = [cell inputString]; // like "=pi()"
            NSString *title = [[entry title] stringValue]; // like "A3"
            
            // show the input string (like =pi()) only if it differs
            // from the result string
            if (!inputStr || (resultStr && [inputStr isEqual:resultStr])) {
                inputStr = @""; 
            }
            
            displayStr = [NSString stringWithFormat:@"%@: %@  %@",
                          title, inputStr, (resultStr ? resultStr : @"")];
            
        }
    }
    
    
}

// get the spreadsheet selected in the top list, or nil if none
- (GDataEntrySpreadsheet *)selectedSpreadsheet {
    
    NSArray *spreadsheets = [spreadsheetFeed_ entries];
//    int rowIndex = [mSpreadsheetTable selectedRow];
//    if ([spreadsheets count] > 0 && rowIndex > -1) {
//        
//        GDataEntrySpreadsheet *spreadsheet = [spreadsheets objectAtIndex:rowIndex];
//        return spreadsheet;
//    }
    return nil;
}

@end
