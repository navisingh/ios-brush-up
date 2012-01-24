//
//  testAppDelegate.h
//  testFacebookConnection
//
//  Created by Navi Singh on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface testAppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Facebook *facebook;

@end
