//
//  FirstViewController.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface Login : UIViewController

@property (weak, nonatomic) IBOutlet UIView *ViewLogin;
@property (weak, nonatomic) IBOutlet UILabel *lblMensaje;

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnIngresar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Indicador;

@property BOOL IsOKLogin;

@property (strong,nonatomic) Singleton *Singleton;

-(void)ValidCredentials;
-(void)Login;
-(void)HideKeyBoard;

@end

