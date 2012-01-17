//
//  ViewController.h
//  StoryboardTutorial
//
//  Created by Kurry Tran on 10/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
}

@property(nonatomic, retain)NSMutableDictionary *states;
@property(nonatomic, retain)NSArray *datasource;
-(void)setupArray;

@end
