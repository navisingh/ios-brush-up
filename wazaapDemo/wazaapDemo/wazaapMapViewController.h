//
//  wazaapMapViewController.h
//  wazaapDemo
//
//  Created by Navi Singh on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import "wazaapConnector.h"

#define METERS_PER_MILE 1609.344

@interface wazaapMapViewController : UIViewController <WazaapConnectorDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) WazaapConnector *connectorDelegate;
@property (nonatomic, strong) NSArray *entities;

@end
