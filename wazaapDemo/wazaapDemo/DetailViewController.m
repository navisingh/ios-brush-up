//
//  EventViewController.m
//  wazaapDemo
//
//  Created by Navi Singh on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailWebViewController.h"
#import "Utility.h"

@interface DetailViewController (PrivateMethods)
-(void)hideGradientBackground:(UIView*)theView;
-(UIWebView*) createWebViewForIndex:(NSUInteger)index;
-(void)willAppearIn:(UINavigationController *)navigationController;
- (void) goBack:(id)sender;
- (void) goToWebPage:(id)sender;
@end

@implementation DetailViewController

@synthesize headerView, headerImageView, headerLabel;
@synthesize footerView, footerImageView, footerLabel;
@synthesize verticalSwipeScrollView, appData, startIndex;
@synthesize previousPage, nextPage;

- (void)viewDidLoad
{
    headerImageView.transform = CGAffineTransformMakeRotation(DegreesToRadians(180));
    [self willAppearIn:nil];
}

- (void)viewDidUnload
{
    self.headerView = nil;
    self.headerImageView = nil;
    self.headerLabel = nil;
    
    self.footerView = nil;
    self.footerImageView = nil;
    self.footerLabel = nil;
}

- (void) dealloc
{
    int x=0;
}

-(void)willAppearIn:(UINavigationController *)navigationController
{
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = 320;
    frame.size.height = 416;
   
    self.verticalSwipeScrollView = [[VerticalSwipeScrollView alloc] initWithFrame:self.view.frame headerView:headerView footerView:footerView startingAt:startIndex delegate:self];
    [self.view addSubview:verticalSwipeScrollView];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];          
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *webButton = [[UIBarButtonItem alloc] initWithTitle:@"Details" style:UIBarButtonItemStylePlain target:self action:@selector(goToWebPage:)];          
    self.navigationItem.rightBarButtonItem = webButton;
}

- (void) goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) goToWebPage:(id)sender
{
    NSString *sPermalink;
    id siteData = [appData objectAtIndex:verticalSwipeScrollView.currentPageIndex];
    id title = [siteData objectForKey:@"permalink"];
    if ([title isKindOfClass:[NSString class]]) {
        NSString *utf8String = title;
        @try {
            NSString *correctString = [NSString stringWithCString:[utf8String cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
            sPermalink = correctString;
        }
        @catch (NSException *exception) {
            sPermalink = utf8String;
        }
        @finally {
        }
    }
    DetailWebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsOnWeb"];
    vc.urlAddress = sPermalink;
    vc.siteData = siteData;
    
    //we rename the back button in the webview and restore it in viewWillAppear.
    self.navigationItem.title = @"back";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) viewWillAppear:(BOOL)animated  
{
    //we got to do this because we changed it when we went to the web view.
    id siteData = [appData objectAtIndex:verticalSwipeScrollView.currentPageIndex];
    id title = [siteData objectForKey:@"title"];
    if ([title isKindOfClass:[NSString class]]) {
        NSString *utf8String = title;
        @try {
            NSString *correctString = [NSString stringWithCString:[utf8String cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
            self.navigationItem.title = correctString;
        }
        @catch (NSException *exception) {
            self.navigationItem.title = utf8String;
        }
        @finally {
        }
    }
}

- (void) rotateImageView:(UIImageView*)imageView angle:(CGFloat)angle
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    imageView.transform = CGAffineTransformMakeRotation(DegreesToRadians(angle));
    [UIView commitAnimations];
}

# pragma mark VerticalSwipeScrollViewDelegate

-(void) headerLoadedInScrollView:(VerticalSwipeScrollView*)scrollView
{
    [self rotateImageView:headerImageView angle:0];
}

-(void) headerUnloadedInScrollView:(VerticalSwipeScrollView*)scrollView
{
    [self rotateImageView:headerImageView angle:180];
}

-(void) footerLoadedInScrollView:(VerticalSwipeScrollView*)scrollView
{
    [self rotateImageView:footerImageView angle:180];
}

-(void) footerUnloadedInScrollView:(VerticalSwipeScrollView*)scrollView
{
    [self rotateImageView:footerImageView angle:0];
}

-(UIView*) viewForScrollView:(VerticalSwipeScrollView*)scrollView atPage:(NSUInteger)page
{
    UIWebView* webView = nil;
    
    if (page < scrollView.currentPageIndex)
        webView = previousPage;
    else if (page > scrollView.currentPageIndex)
        webView = nextPage;
    
    if (!webView)
        webView = [self createWebViewForIndex:page];
    
    self.previousPage = page > 0 ? [self createWebViewForIndex:page-1] : nil;
    self.nextPage = (page == (appData.count-1)) ? nil : [self createWebViewForIndex:page+1];
    
    id title = [[appData objectAtIndex:page] objectForKey:@"title"];
    if ([title isKindOfClass:[NSString class]]) {
        NSString *utf8String = title;
        @try {
            NSString *correctString = [NSString stringWithCString:[utf8String cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
            self.navigationItem.title = correctString;
        }
        @catch (NSException *exception) {
            self.navigationItem.title = utf8String;
        }
        @finally {
        }
    }
    
    if (page > 0)
    {
        id title = [[appData objectAtIndex:page-1] objectForKey:@"title"];
        if ([title isKindOfClass:[NSString class]]) {
            NSString *utf8String = title;
            @try {
                NSString *correctString = [NSString stringWithCString:[utf8String cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
                headerLabel.text = correctString;
            }
            @catch (NSException *exception) {
                headerLabel.text = utf8String;
            }
            @finally {
            }
        }
    }
    if (page != appData.count-1)
    {
        id title = [[appData objectAtIndex:page+1] objectForKey:@"title"];
        if ([title isKindOfClass:[NSString class]]) {
            NSString *utf8String = title;
            @try {
                NSString *correctString = [NSString stringWithCString:[utf8String cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
                footerLabel.text = correctString;
            }
            @catch (NSException *exception) {
                footerLabel.text = utf8String;
            }
            @finally {
            }
        }
    }
    
    return webView;
}

-(NSUInteger) pageCount
{
    return appData.count;
}

-(UIWebView*) createWebViewForIndex:(NSUInteger)index
{
    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.opaque = NO;
    [webView setBackgroundColor:[UIColor clearColor]];
    [self hideGradientBackground:webView];
    
    NSString* htmlFile = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/DetailView.html"];
    
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    id title = [[appData objectAtIndex:index] objectForKey:@"title"];
    if ([title isKindOfClass:[NSString class]]) 
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<!-- title -->" withString:title];
    
    id image = [[appData objectAtIndex:index] objectForKey:@"image"];
    if ([image isKindOfClass:[NSString class]]) {
        NSString *img = [[appData objectAtIndex:index] objectForKey:@"image"];
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<!-- icon -->" withString:img];
    }
    
    
    id desc = [[appData objectAtIndex:index] objectForKey:@"description"];
    if ([desc isKindOfClass:[NSString class]]) 
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<!-- content -->" withString:desc];
    
    [webView loadHTMLString:htmlString baseURL:nil];
    
    return webView;
}

- (void) hideGradientBackground:(UIView*)theView
{
    for (UIView * subview in theView.subviews)
    {
        if ([subview isKindOfClass:[UIImageView class]])
            subview.hidden = YES;
        
        [self hideGradientBackground:subview];
    }
}



@end
