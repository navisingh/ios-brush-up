//
//  DetailViewController.h
//  Stocks
//
//  Created by Navi Singh on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    NSString *stock;
    NSString *url;
    IBOutlet UILabel *stockLabel;
    IBOutlet UILabel *stockURL;
}

@property (nonatomic, retain) NSString *stock, *url;
@property (nonatomic, retain) IBOutlet UILabel *stockLabel, *stockURL;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
