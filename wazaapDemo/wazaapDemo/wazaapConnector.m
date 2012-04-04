//
//  wazaapConnector.m
//  wazaapDemo
//
//  Created by Navi Singh on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "wazaapConnector.h"


@interface WazaapConnector (PrivateMethods)
- (void) makeConnectionWithURL:(NSString *)URLString;
- (void) didReceiveJsonData:(NSDictionary *)data;
- (void) cancel:(NSURLConnection *)connection;
@end

@implementation WazaapConnector

@synthesize connectionData;
@synthesize delegate;

- (id) initWithDelegate:(id<WazaapConnectorDelegate>)obj
{
    self = [super init];
    if (self)
    {
        self.delegate = obj;
    }
    return self;
    
}

#pragma mark NSURLConnectionDelegate

- (void) makeConnectionWithURL:(NSString *)URLString
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection)
        self.connectionData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSInteger status = [(NSHTTPURLResponse*)response statusCode];
    
    if (status != 200)
        [self cancel:connection];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self cancel:connection];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [connectionData appendData:data];
}

- (void) cancel:(NSURLConnection *)connection
{
    [connection cancel];
    self.connectionData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //this string is only for debugging.
    NSString* jsonString = [[NSString alloc] initWithData:connectionData encoding:NSUTF8StringEncoding]; 
    
    @try {
        
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:connectionData options:kNilOptions error:&error];
        [self didReceiveJsonData:json];
    }
    @catch (NSException * e) {
    }
    
    self.connectionData = nil;
}

- (void) didReceiveJsonData:(NSDictionary *)json
{
    if (delegate) {
        [delegate didReceiveJsonData:json];
    }
}

@end
