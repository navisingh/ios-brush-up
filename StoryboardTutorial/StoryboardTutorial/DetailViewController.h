//
//  DetailViewController.h
//  StoryboardTutorial
//
//  Created by Kurry Tran on 10/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController{
    NSString *state;
    NSString *capital;
    IBOutlet UILabel *stateLabel;
    IBOutlet UILabel *capitalLabel;
}
@property (nonatomic, retain)NSString *state, *capital;
@property (nonatomic, retain)IBOutlet UILabel *stateLabel, *capitalLabel;
@end
