//
//  testAppDelegate.h
//  testFacebookConnection
//
//  Created by Navi Singh on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBConnect.h"
#import "DataSet.h"

@interface testAppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) Facebook *facebook;
@property (nonatomic, retain) NSMutableDictionary *userPermissions;
@property (nonatomic, retain) DataSet *apiData;

@end
