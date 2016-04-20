//
//  MasInfo_Mapa_Ubicacion.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 11/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Singleton.h"

@interface MasInfo_Mapa_Ubicacion : UIViewController<CLLocationManagerDelegate>{
    UIView* loadingView;
    UILabel* lblPorc;
    NSString *urlWeb;
    Singleton *Singleton;
    CLLocation *lo;
}

@property (strong,nonatomic) Singleton *Singleton;
@property (strong, nonatomic) IBOutlet MKMapView *MapView;
@property (copy)CLLocation* lo;
@property (strong, nonatomic) CLLocationManager * manager;

- (IBAction)btnRefresh:(id)sender;

-(void)UpdateMap;

@end
