//
//  EventViewController.m
//  wazaapDemo
//
//  Created by Navi Singh on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "Utility.h"

@interface DetailViewController (PrivateMethods)
-(void)hideGradientBackground:(UIView*)theView;
-(UIWebView*) createWebViewForIndex:(NSUInteger)index;
-(void)willAppearIn:(UINavigationController *)navigationController;
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

-(void)willAppearIn:(UINavigationController *)navigationController
{
    self.verticalSwipeScrollView = [[VerticalSwipeScrollView alloc] initWithFrame:self.view.frame headerView:headerView footerView:footerView startingAt:startIndex delegate:self] ;
    [self.view addSubview:verticalSwipeScrollView];
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
    
    {
        NSString *utf8String = [[appData objectAtIndex:page] objectForKey:@"title"];
        
        NSString *correctString = [NSString stringWithCString:[utf8String cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
        self.navigationItem.title = correctString;
        //       self.navigationItem.title = [[appData objectAtIndex:page] objectForKey:@"title"];
        if (page > 0)
            headerLabel.text = [[appData objectAtIndex:page-1] objectForKey:@"title"];
        if (page != appData.count-1)
            footerLabel.text = [[appData objectAtIndex:page+1] objectForKey:@"title"] ;
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
    
    NSString* htmlString;
    
    {
        htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<!-- title -->" withString:[[appData objectAtIndex:index] objectForKey:@"title"]];
        @try {
            htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<!-- icon -->" withString:[[appData objectAtIndex:index] objectForKey:@"image"]];
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"<!-- content -->" withString:[[appData objectAtIndex:index] objectForKey:@"description"] ];
    }
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

- (void)viewDidUnload
{
    self.headerView = nil;
    self.headerImageView = nil;
    self.headerLabel = nil;
    
    self.footerView = nil;
    self.footerImageView = nil;
    self.footerLabel = nil;
}

- (void)dealloc
{
}

@end
