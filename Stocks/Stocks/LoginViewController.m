//
//  LoginViewController.m
//  Stocks
//
//  Created by Navi Singh on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "KeychainItemWrapper.h"
#import "StockAppDelegate.h"
#import "GoogleSpreadSheetWrapper.h"

@implementation LoginViewController
@synthesize username;
@synthesize password;

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
/*
- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
*/

//When the user presses the back button on the navigation toolbar.
-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.  
        
        [self done:self];
    }
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == password) {
        
        [textField resignFirstResponder];
        
//        [self done:self];

        [self.navigationController popViewControllerAnimated:YES];
    }
    return NO;
}


- (IBAction)done:(id)sender 
{
    {
        KeychainItemWrapper *keychain = 
        [[KeychainItemWrapper alloc] initWithIdentifier:@"GoogleLoginData" accessGroup:nil];
        [keychain setObject:[username text] forKey:(__bridge id)kSecAttrAccount];
        [keychain setObject:[password text] forKey:(__bridge id)kSecValueData];
    }

    StockAppDelegate *delegate = (StockAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[password text] isEqualToString:@""]) 
    {
        delegate.googleSpreadsheetWrapper.username = [username text];
        delegate.googleSpreadsheetWrapper.password = [password text];
    }
}

@end
