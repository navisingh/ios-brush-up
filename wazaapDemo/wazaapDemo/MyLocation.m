//
//  MyLocation.m
//  wazaapDemo
//
//  Created by Navi Singh on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyLocation.h"

@implementation MyLocation
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;
@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize zip = _zip;

- (id)initWithName:(NSString*)name 
           address:(NSString*)address 
         longitude:(NSString *)longitude
          latitude:(NSString *)latitude
               zip:(NSString *)zip
        coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _longitude = [longitude copy];
        _latitude = [latitude copy];
        _zip = [zip copy];
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]]) 
        return @"Unknown charge";
    else
        return _name;
}

- (NSString *)subtitle {
    return _address;
}

@end