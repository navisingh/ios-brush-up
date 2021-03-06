//
//  DiningViewController.h
//  wazaapDemo
//
//  Created by Navi Singh on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VerticalSwipeScrollView.h"

@interface DiningViewController : UIViewController <VerticalSwipeScrollViewDelegate, UIScrollViewDelegate>
{
    IBOutlet UIView* headerView;
    IBOutlet UIImageView* headerImageView;
    IBOutlet UILabel* headerLabel;
    
    IBOutlet UIView* footerView;
    IBOutlet UIImageView* footerImageView;
    IBOutlet UILabel* footerLabel;
    
    VerticalSwipeScrollView* verticalSwipeScrollView;
    NSArray* appData;
    NSUInteger startIndex;
    UIWebView* previousPage;
    UIWebView* nextPage;
}

@property (nonatomic, strong) IBOutlet UIView* headerView;
@property (nonatomic, strong) IBOutlet UIImageView* headerImageView;
@property (nonatomic, strong) IBOutlet UILabel* headerLabel;
@property (nonatomic, strong) IBOutlet UIView* footerView;
@property (nonatomic, strong) IBOutlet UIImageView* footerImageView;
@property (nonatomic, strong) IBOutlet UILabel* footerLabel;
@property (nonatomic, strong) VerticalSwipeScrollView* verticalSwipeScrollView;
@property (nonatomic, strong) NSArray* appData;
@property (nonatomic) NSUInteger startIndex;
@property (nonatomic, strong) UIWebView* previousPage;
@property (nonatomic, strong) UIWebView* nextPage;

@end
