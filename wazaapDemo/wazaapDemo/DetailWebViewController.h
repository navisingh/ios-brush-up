//
//  DetailWebViewController.h
//  wazaapDemo
//
//  Created by Navi Singh on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailWebViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *urlAddress;
@property (nonatomic, strong) id siteData;
@end
