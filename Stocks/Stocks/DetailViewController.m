//
//  DetailViewController.m
//  Stocks
//
//  Created by Navi Singh on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "GData-ARC.h"

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
  
    [self fetchFeedOfSpreadsheets];
}

// begin retrieving the list of the user's spreadsheets
- (void)fetchFeedOfSpreadsheets {
    
    spreadsheetFeed_ = nil;
    
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
            didFinishSelector:@selector(feedTicket:finishedWithFeed:error:)];
    
    [self updateUI];
}

// spreadsheet list fetch callback
- (void)feedTicket:(GDataServiceTicket *)ticket
  finishedWithFeed:(GDataFeedSpreadsheet *)feed
             error:(NSError *)error {
    
    spreadsheetFeed_ = feed;
    spreadsheetFetchError_ = error;
    
    // get the spreadsheet entry's title
    if (spreadsheetFeed_) {
        for (int row=0; row < [[spreadsheetFeed_ entries] count]; row++) {
            GDataEntrySpreadsheet *spreadsheet = [[spreadsheetFeed_ entries] objectAtIndex:row];
            if (spreadsheet) {
                NSString *s = [[spreadsheet title] stringValue];
            }
        }
    }

    
    isSpreadsheetFetchPending_ = NO;
    [self updateUI];
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

- (void)updateUI 
{
    
    // spreadsheet list display
//    [mSpreadsheetTable reloadData]; 
    
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
    else 
    {
        GDataEntrySpreadsheet *spreadsheet = [self selectedSpreadsheet];
        if (spreadsheet) 
        {
            spreadsheetResultStr = [spreadsheet description];
        } 
        else 
        {
            
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
