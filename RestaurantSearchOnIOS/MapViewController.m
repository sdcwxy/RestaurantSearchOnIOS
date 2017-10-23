//
//  MapViewController.m
//  RestaurantSearchOnIOS
//
//  Created by zhonglis on 10/22/17.
//  Copyright © 2017 steve. All rights reserved.
//

#import "MapViewController.h"
#import "YelpDataStore.h"
#import "YelpAnnotation.h"
#import <UIImageView+AFNetworking.h>

@import MapKit;


@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic) MKMapView *mapView;

@end


@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.mapView];
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    
    CLLocationCoordinate2D location;
    location.latitude = 37.331566;
    location.longitude = -122.032744;
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = location;
    
    [self.mapView setRegion:region animated:YES];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setCenterCoordinate:location animated:YES];
    self.mapView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateAnnotation];
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    [self.mapView setVisibleMapRect:zoomRect animated:YES];
    
    if ([[YelpDataStore sharedInstance] userLocation]) {
        [self.mapView setCenterCoordinate:[[YelpDataStore sharedInstance] userLocation].coordinate animated:YES];
    }
}


- (void)updateAnnotation
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    NSArray <YelpAnnotation *> *annotations = [YelpAnnotation buildAnnotationArrayFromDataArray:[[YelpDataStore sharedInstance] dataModels]];
    [self.mapView addAnnotations:annotations];
}


#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
        return;
    }
    
    YelpAnnotation *annotation = view.annotation;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [imageView setImageWithURL:[NSURL URLWithString:annotation.dataModel.imageUrl]];
    view.leftCalloutAccessoryView = imageView;
}


@end
