//
//  EventViewController.h
//  wazaapDemo
//
//  Created by Navi Singh on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VerticalSwipeScrollView.h"

@interface DetailViewController : UIViewController <VerticalSwipeScrollViewDelegate, UIScrollViewDelegate>
{
}

@property (nonatomic, strong) IBOutlet UIView* headerView;
@property (nonatomic, strong) IBOutlet UIImageView* headerImageView;
@property (nonatomic, strong) IBOutlet UILabel* headerLabel;
@property (nonatomic, strong) IBOutlet UIView* footerView;
@property (nonatomic, strong) IBOutlet UIImageView* footerImageView;
@property (nonatomic, strong) IBOutlet UILabel* footerLabel;
@property (nonatomic, strong) VerticalSwipeScrollView* verticalSwipeScrollView;
@property (nonatomic, strong) UIWebView* previousPage;
@property (nonatomic, strong) UIWebView* nextPage;
@property (nonatomic, strong) NSArray* appData;
@property (nonatomic) NSUInteger startIndex;

@end
