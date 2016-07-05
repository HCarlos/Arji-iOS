//
//  MasInfo_Mapa_Ubicacion.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 11/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import "MasInfo_Mapa_Ubicacion.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MasInfo_Mapa_Ubicacion ()

@end

@implementation MasInfo_Mapa_Ubicacion{
    UILabel* lblLoading;
}
@synthesize MapView, manager, lo, Singleton;

- (void)viewDidLoad {
    
    self.Singleton  = [Singleton sharedMySingleton];

    self.manager = [[CLLocationManager alloc] init];
    self.manager.distanceFilter = 1;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager.delegate = self;
    
    [manager startUpdatingLocation];
    
    self.MapView.showsUserLocation = YES;
    
    [manager startUpdatingLocation];
    
    [self UpdateMap];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)managerE didFailWithError:(NSError *)error{
    
    
    [managerE stopUpdatingLocation];
    
    NSString *errors = @"";
    
    switch([error code])
    {
        case kCLErrorNetwork: {
                errors = @"Please check your network connection or that you are not in airplane mode";
            }
            break;
        case kCLErrorDenied:{
                errors = @"User has denied to use current Location ";
            }
            break;
        default:
            errors = @"Unknown network error";
            break;
    }

    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Error"
                                  message:errors
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"Aceptar"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    exit(0);
                                    
                                }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    self.lo = newLocation;
}

-(void)UpdateMap{
    
    MKCoordinateRegion region;
    
    region.center.latitude = 17.968768f;
    region.center.longitude = -92.949937f;
    
    region.span.latitudeDelta = 0.003;
    region.span.longitudeDelta = 0.003;
    
    [MapView setRegion:region animated:YES];

    lblLoading = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 500, 30)];
    lblLoading.text = @" Av. México Núm. 2. Col del Bosque, Villahermosa, Tab., MX";
    lblLoading.backgroundColor = [UIColor whiteColor];
    lblLoading.textColor = [UIColor blackColor];
    lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:14];
    lblLoading.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lblLoading];
    
    
}

- (IBAction)btnRefresh:(id)sender {
    [self UpdateMap];
}

@end
