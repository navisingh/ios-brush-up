//
//  MyLocation.h
//  wazaapDemo
//
//  Created by Navi Singh on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocation : NSObject <MKAnnotation> {
    NSString *_name;
    NSString *_address;
    NSString *_longitude;
    NSString *_latitude;
    NSString *_zip;
    CLLocationCoordinate2D _coordinate;
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (copy) NSString *longitude;
@property (copy) NSString *latitude;
@property (copy) NSString *zip;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name 
           address:(NSString*)address 
         longitude:(NSString *)longitude
          latitude:(NSString *)latitude
               zip:(NSString *)zip
        coordinate:(CLLocationCoordinate2D)coordinate;

@end