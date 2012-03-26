//
//  EventTableViewController.m
//  wazaapDemo
//
//  Created by Navi Singh on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventTableViewController.h"

#define WAZAAP_URL @"http://sf.wazaap.in/wp-content/plugins/wz_reloaded/action.php?action=search&category=deals,nightlife,nightlife-clubbing,nightlife-eatingdrinking,nightlife-others,nightlife-comedy,nightlife-music,nightlife-dance,nightlife-movies,offbeat,offbeat-films,offbeat-music,offbeat-other,offbeat-performingarts,offbeat-visualarts,offbeat-literature,challenges,challenges-volunteering,challenges-sportsrecreation,challenges-others,challenges-networking,challenges-hobbies,challenges-classes,challenges-lecturesworkshops,others,others-artscrafts,others-festivals,others-others,others-social,others-sports,others-tours,deals,nightlife,offbeat,challenges,others&sort_by=chronological&sort_order=asc&items_per_page=15&page=2&start_before=23"

@implementation EventTableViewController

@synthesize connectionData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:WAZAAP_URL]];
    
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request2 delegate:self];
    if (connection)
        self.connectionData = [NSMutableData data];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void) cancel:(NSURLConnection *)connection
{
    [connection cancel];
    self.connectionData = nil;
}

#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSInteger status = [(NSHTTPURLResponse*)response statusCode];
    
    if (status != 200)
        [self cancel:connection];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self cancel:connection];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [connectionData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
#warning identify the container for storing the received data.
//    RootViewController* rootViewController = (RootViewController*)[navigationController.viewControllers objectAtIndex:0];
    
    {
        NSString* topAppsString = [[NSString alloc] initWithData:connectionData encoding:NSUTF8StringEncoding]; 
        
        @try {
            
            NSError *error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:connectionData options:kNilOptions error:&error];
#warning got to store the received data.
//            rootViewController.topApps = [json objectForKey:@"events"];
            
            //           rootViewController.topApps = [[topAppsString JSONValue] objectForKey:@"events"];
            
#warning not sure what view to add.
//            [self.window addSubview:navigationController.view];
        }
        @catch (NSException * e) {
        }
        
        self.connectionData = nil;
    }
}

@end
