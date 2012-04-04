//
//  WazaapTableViewController.m
//  wazaapDemo
//
//  Created by Navi Singh on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WazaapTableViewController.h"
#import "WazaapEntity.h"
#import "BaseTableViewController.h"
#import "EventTableViewController.h"
#import "VenueTableViewController.h"
#import "wazaapConnector.h"

#define EVENT_URL @"http://sf.wazaap.in/wp-content/plugins/wz_reloaded/action.php?action=search&category=deals,nightlife,nightlife-clubbing,nightlife-eatingdrinking,nightlife-others,nightlife-comedy,nightlife-music,nightlife-dance,nightlife-movies,offbeat,offbeat-films,offbeat-music,offbeat-other,offbeat-performingarts,offbeat-visualarts,offbeat-literature,challenges,challenges-volunteering,challenges-sportsrecreation,challenges-others,challenges-networking,challenges-hobbies,challenges-classes,challenges-lecturesworkshops,others,others-artscrafts,others-festivals,others-others,others-social,others-sports,others-tours,deals,nightlife,offbeat,challenges"
#define VENUE_URL @"http://sf.wazaap.in/wp-content/plugins/wz_reloaded/action.php?action=search&category=deals,nightlife,nightlife-clubbing,nightlife-eatingdrinking,nightlife-others,nightlife-comedy,nightlife-music,nightlife-dance,nightlife-movies,offbeat,offbeat-films,offbeat-music,offbeat-other,offbeat-performingarts,offbeat-visualarts,offbeat-literature,challenges,challenges-volunteering,challenges-sportsrecreation,challenges-others,challenges-networking,challenges-hobbies,challenges-classes,challenges-lecturesworkshops,others,others-artscrafts,others-festivals,others-others,others-social,others-sports,others-tours,deals,nightlife,offbeat,challenges"

@interface WazaapTableViewController (PrivateMethods)
- (void) makeConnectionWithURL:(NSString *)URLString;
- (void) didReceiveJsonData:(NSDictionary *)data;
- (void) cancel:(NSURLConnection *)connection;
@end

@implementation WazaapTableViewController

@synthesize entities, entity, connectorDelegate;

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
    self.title = @"Wazaap!!";
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
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    // return 0;
    return [self.entities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"EntityCell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntityCell"];
	WazaapEntity *e = [self.entities objectAtIndex:indexPath.row];
	cell.textLabel.text = e.name;
	cell.detailTextLabel.text = e.detail;

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
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
	self.entity = [self.entities objectAtIndex:indexPath.row];
 
    if (!connectorDelegate) {
        self.connectorDelegate = [[WazaapConnector alloc] initWithDelegate:self];
    }

    
    if ([self.entity.name isEqualToString:@"Events"]) {
        [self.connectorDelegate makeConnectionWithURL:EVENT_URL];
    }
    else if ([self.entity.name isEqualToString:@"Venues"]) {
        [self.connectorDelegate makeConnectionWithURL:VENUE_URL];
    }
    else if ([self.entity.name isEqualToString:@"Friends"]) {
        [self.connectorDelegate makeConnectionWithURL:VENUE_URL];
    }
    
}

- (void) didReceiveJsonData:(NSDictionary *)json
{
    BaseTableViewController *tvc;
    if ([self.entity.name isEqualToString:@"Events"]) {
        tvc = [self.storyboard instantiateViewControllerWithIdentifier:entity.name];
        tvc.entities = [json objectForKey:@"events"];
    }
    else if ([self.entity.name isEqualToString:@"Venues"]) {
        tvc = [self.storyboard instantiateViewControllerWithIdentifier:entity.name];
#warning TBD. need to change this to dining later.        
        tvc.entities = [json objectForKey:@"events"];
    }
    else if ([self.entity.name isEqualToString:@"Friends"]) {
#warning TBD. handle other cases.
        tvc.entities = [json objectForKey:@"events"];
    }
    
    if (tvc) {
        [self.navigationController pushViewController:tvc animated:YES];
    }
}


@end
