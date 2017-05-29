//
//  Singleton.h
//  New Financial Personal for iPad
//
//  Created by DevCH on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

/*
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <CoreLocation/CoreLocation.h>
#import <CommonCrypto/CommonDigest.h>
*/

@interface Singleton : NSObject{
	// int IdIO;
    // NSString *JS;
    // CLLocation* loSelf;
    NSString *pathPList;
    NSMutableDictionary *dataPList;
    int Modulo;
//    UIWebView* webView;
    int IdUser;
    int IdEmp;
    int IdUserNivelAcceso;
    int Clave;
    int Param1;
    int RegistrosPorPagina;
	BOOL IsDelete;
    NSString *Empresa;
    
    NSString *Username;
    NSString *Password;
    
    NSString *NombreCompletoUsuario;
    
    NSString *Version;
    
}

// @property (nonatomic) int IdIO;
// @property (nonatomic, retain) NSString *JS;
@property (nonatomic, retain) NSString *Empresa;
// @property (nonatomic, copy) CLLocation* loSelf;
@property (nonatomic) int Modulo;
@property (nonatomic) int IdEmp;
@property (nonatomic) int IdUser;
@property (nonatomic) int IdUserNivelAcceso;
@property (nonatomic) int Clave;
@property (nonatomic) int Param1;
@property (nonatomic) int limFrom;
@property (nonatomic) int limCant;
@property (nonatomic) int RegistrosPorPagina;
@property (nonatomic, retain) NSString *Username;
@property (nonatomic, retain) NSString *Password;
@property (nonatomic, retain) NSString *NombreCompletoUsuario;
@property (nonatomic, retain) NSString *Version;

@property (nonatomic) NSInteger applicationIconBadgeNumber;
@property (nonatomic) NSInteger noIngresos;
@property (nonatomic) NSInteger IdConcepto;

@property (nonatomic) BOOL IsDelete;

/*
@property(nonatomic,readonly,retain) NSString    *name;              // e.g. "My iPhone"
@property(nonatomic,readonly,retain) NSString    *model;             // e.g. @"iPhone", @"iPod Touch"
@property(nonatomic,readonly,retain) NSString    *localizedModel;    // localized version of model
@property(nonatomic,readonly,retain) NSString    *systemName;        // e.g. @"iPhone OS"
@property(nonatomic,readonly,retain) NSString    *systemVersion;     // e.g. @"2.0"
*/

// @property(nonatomic,readonly) CLDeviceOrientation orientation;       // return current device orientation
@property(nonatomic, retain) NSString    *typeDevice;  // a string unique to each device based on various
@property(nonatomic, retain) NSString    *uniqueIdentifier;  // a string unique to each device based on various
@property(nonatomic, retain) NSUUID *identifierForVendor;

/*
@property(nonatomic,retain) NSString *domicilio;            // domicilio
 */

@property(nonatomic,retain) NSString *tokenUser;              // e.g. "My iPhone"
@property(nonatomic,retain) NSMutableDictionary *dataPList;
@property(nonatomic,retain) NSString *pathPList;

// @property(nonatomic,retain) UIWebView* webView;

+(Singleton*)sharedMySingleton;

- (BOOL) validateEmail: (NSString *) candidate;

// -(CLLocation *) getLocation:(CLLocation *)Loc;

-(NSString *) getDeviceData:(int )field;

-(NSString*) sha1:(NSString*)input;
-(NSString *)makeUniqueString;

-(int)intInRangeMinimum:(int)min andMaximum:(int)max;
-(double)intInRangeDouble:(double)min andMaximum:(double)max;

-(void)setPlist;
-(void)insertUser:(NSString *) User insertPass:(NSString *) PWD;
-(void)deleteUser;

-(NSString *) getUser;
-(NSString *) getPassword;
-(NSArray*)explodeString:(NSString*)stringToBeExploded WithDelimiter:(NSString*)delimiter;

-(NSInteger) addAccess;
-(NSInteger) getAccess;

-(NSInteger) getBadge;
-(NSInteger) incrementBadge;
-(NSInteger) decrementBadge;
-(void) removeBadge;

@end
