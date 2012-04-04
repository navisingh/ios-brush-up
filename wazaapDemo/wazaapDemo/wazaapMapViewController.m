//
//  wazaapMapViewController.m
//  wazaapDemo
//
//  Created by Navi Singh on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "wazaapMapViewController.h"
#import "MyLocation.h"

#define EVENT_URL @"http://sf.wazaap.in/wp-content/plugins/wz_reloaded/action.php?action=search&category=deals,nightlife,nightlife-clubbing,nightlife-eatingdrinking,nightlife-others,nightlife-comedy,nightlife-music,nightlife-dance,nightlife-movies,offbeat,offbeat-films,offbeat-music,offbeat-other,offbeat-performingarts,offbeat-visualarts,offbeat-literature,challenges,challenges-volunteering,challenges-sportsrecreation,challenges-others,challenges-networking,challenges-hobbies,challenges-classes,challenges-lecturesworkshops,others,others-artscrafts,others-festivals,others-others,others-social,others-sports,others-tours,deals,nightlife,offbeat,challenges"

@implementation wazaapMapViewController
@synthesize mapView;
@synthesize connectorDelegate;
@synthesize entities;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!connectorDelegate) {
        self.connectorDelegate = [[WazaapConnector alloc] initWithDelegate:self];
        
    }
}


- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)viewWillAppear:(BOOL)animated 
{  
    [self.connectorDelegate makeConnectionWithURL:EVENT_URL];

    if (0) {
        // 1 Picks out the location to zoom in. Here we choose the location in Baltimore where I initially wrote this app, which is a good choice for the BPD Arrests API we’ll be using later on in this tutorial.
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = 39.281516;
        zoomLocation.longitude= -76.580806;
        
        // 2 When you are trying to tell the map what to display, you can’t just give a lat/long – you need to specify the box (or region) to display. So this uses a helper function to make a region around a center point (the user’s location) and a given width/height. We use half a mile here, because that works well for plotting arrests data.
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
        
        // 3 Before sending the region on to the map view, you have to trim the region a bit into what can actually fit on the screen, given the current size of the map view’s frame. The map view has a helper method called regionThatFits that does exactly that.
        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];   
        
        // 4     Finally, tells the mapView to display the region. The map view automatically transitions the current view to the desired region with a neat zoom animation with no extra code required!
        [self.mapView setRegion:adjustedRegion animated:YES];      
    }
}

- (void) didReceiveJsonData:(NSDictionary *)json
{
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        [self.mapView removeAnnotation:annotation];
    }

    self.entities = [json objectForKey:@"events"];
    
    bool firstEntry = true;
    NSDictionary *entity;
    for (entity in self.entities) {
        NSString *title = [entity objectForKey:@"title"]; 
        NSString *longitude = [entity objectForKey:@"long"]; 
        NSString *latitude = [entity objectForKey:@"lat"]; 
        NSString *zip = [entity objectForKey:@"zip"]; 
        NSString *address = [entity objectForKey:@"address"]; 
        
        if (firstEntry) {
            // 1 Picks out the location to zoom in. Here we choose the location in Baltimore where I initially wrote this app, which is a good choice for the BPD Arrests API we’ll be using later on in this tutorial.
            CLLocationCoordinate2D zoomLocation;
            zoomLocation.latitude = latitude.doubleValue;
            zoomLocation.longitude= longitude.doubleValue;
            
            if (latitude.doubleValue && longitude.doubleValue) {
                // 2 When you are trying to tell the map what to display, you can’t just give a lat/long – you need to specify the box (or region) to display. So this uses a helper function to make a region around a center point (the user’s location) and a given width/height. We use half a mile here, because that works well for plotting arrests data.
                double scale = 4.0;
                MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, scale*METERS_PER_MILE, scale*METERS_PER_MILE);
                
                // 3 Before sending the region on to the map view, you have to trim the region a bit into what can actually fit on the screen, given the current size of the map view’s frame. The map view has a helper method called regionThatFits that does exactly that.
                MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];   
                
                // 4     Finally, tells the mapView to display the region. The map view automatically transitions the current view to the desired region with a neat zoom animation with no extra code required!
                [self.mapView setRegion:adjustedRegion animated:YES];  
                
                firstEntry = false;
            }
        }

        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue;            
        MyLocation *annotation = [[MyLocation alloc] initWithName:title 
                                                          address:address 
                                                        longitude:longitude
                                                         latitude:latitude
                                                              zip:zip
                                                          coordinate:coordinate];
        @try {
            [self.mapView addAnnotation:annotation];    
        }
        @catch (NSException *exception) {
            int x=0;
        }
        @finally {
        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";   
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.image=[UIImage imageNamed:@"arrest.png"];//here we use a nice image instead of the default pins
        
        return annotationView;
    }
    
    return nil;    
}
@end
