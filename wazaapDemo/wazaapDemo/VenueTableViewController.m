//
//  DiningTableViewController.m
//  wazaapDemo
//
//  Created by Navi Singh on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VenueTableViewController.h"
#import "DetailViewController.h"

#define WAZAAP_URL @"http://sf.wazaap.in/wp-content/plugins/wz_reloaded/action.php?action=search&category=deals,nightlife,nightlife-clubbing,nightlife-eatingdrinking,nightlife-others,nightlife-comedy,nightlife-music,nightlife-dance,nightlife-movies,offbeat,offbeat-films,offbeat-music,offbeat-other,offbeat-performingarts,offbeat-visualarts,offbeat-literature,challenges,challenges-volunteering,challenges-sportsrecreation,challenges-others,challenges-networking,challenges-hobbies,challenges-classes,challenges-lecturesworkshops,others,others-artscrafts,others-festivals,others-others,others-social,others-sports,others-tours,deals,nightlife,offbeat,challenges"


@implementation VenueTableViewController


@synthesize tableView;

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
    self.title = @"Events";
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int count = [self.entities count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     static NSString *CellIdentifier = @"Cell";
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     
     // Configure the cell...
     
     return cell;
     */
    
    
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"VenueCell"];
    NSDictionary *entity = [self.entities objectAtIndex:indexPath.row];
    
    NSString *rawTitle = [entity objectForKey:@"title"]; 
    @try {
        //        NSString *title = [NSString stringWithCString:[rawTitle cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
        cell.textLabel.text = rawTitle;
    }
    @catch (NSException *exception) {
        cell.textLabel.text = rawTitle;
    }
    @finally {
    }
    
    NSString *rawSubTitle = [entity objectForKey:@"description"];
    @try {
        //        NSString *subtitle = [NSString stringWithCString:[rawSubTitle cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
        cell.detailTextLabel.text = rawSubTitle;
    }
    @catch (NSException *exception) {
        cell.detailTextLabel.text = @"";
    }
    @finally {
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
    
    //    DetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    //    vc.appData = self.entities;
    //    vc.startIndex = indexPath.row;
    //    [self.navigationController pushViewController:vc animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"ShowDetails"])
	{
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        UINavigationController *navigationController = segue.destinationViewController;
        DetailViewController *dvc = [[navigationController viewControllers] objectAtIndex:0];           
        
        dvc.appData = self.entities;
        dvc.startIndex = indexPath.row;
        
        //        if ([dvc respondsToSelector:@selector(willAppearIn:)])
        //            [dvc performSelector:@selector(willAppearIn:) withObject:navigationController];
	}
}


@end
