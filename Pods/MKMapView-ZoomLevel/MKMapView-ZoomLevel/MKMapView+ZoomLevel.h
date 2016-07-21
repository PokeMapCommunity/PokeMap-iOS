//
//  MKMapView+ZoomLevel.h
//  iPokeMon
//
//  Created by Kaijie Yu on 5/22/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//
#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

/*! Zoom map to a desired zoom level based on a coordinate.
 *
 * \param centerCoordinate The location coordinate as the center of zooming
 * \param zoomLevel The desired zoom level, from 0 to 20
 * \param animated If YES, the map is being zoomed to the desired level using an animation.
 */
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

/*! Retuan the coordinate region for map view with center coordinate & zoom level
 *
 *  MKMapView cannot display tiles that cross the pole (as these would involve wrapping
 *    the map from top to bottom, something that a Mercator projection just cannot do).
 *
 * \param mapView The target map view
 * \param centerCoordinate The center coordinate
 * \param zoomLevel The zoom level
 *
 * \returns A coordinate region for map view
 */
- (MKCoordinateRegion)coordinateRegionWithMapView:(MKMapView *)mapView
                                 centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                     andZoomLevel:(NSUInteger)zoomLevel;

/*! Get current zoom level.
 *
 * \returns Current zoom level value
 */
- (NSUInteger)zoomLevel;

// Helper
+ (double)originXForLongitude:(double)longitude;
+ (double)originYForLatitude:(double)latitude;
+ (double)longitudeForOriginX:(double)originX;
+ (double)latitudeForOriginY:(double)originY;

/*! Return real word distance (in meter) of the map view in current zoom level.
 * 
 * \param mapView The target map view
 *
 * \returns A distance value in meter
 */
+ (double)realWorldDistanceOfMapView:(MKMapView *)mapView;

@end
