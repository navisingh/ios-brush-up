//
//  wazaapConnector.h
//  wazaapDemo
//
//  Created by Navi Singh on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WazaapConnectorDelegate
- (void) didReceiveJsonData:(NSDictionary *)json;
@optional
@end

@interface WazaapConnector : NSObject

- (id) initWithDelegate:(id<WazaapConnectorDelegate>)obj;
- (void) makeConnectionWithURL:(NSString *)URLString;

@property (nonatomic, strong) NSMutableData *connectionData;
@property (nonatomic, unsafe_unretained) id<WazaapConnectorDelegate> delegate;

@end
