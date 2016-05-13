//
//  FirstViewController.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import "Login.h"
#import "Singleton.h"

@interface Login (){
    NSMutableArray *datos;
    NSString *Usr;
}

@end

@implementation Login
@synthesize Indicador, ViewLogin, txtUsername, txtPassword;
- (void)viewDidLoad {

    /*
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"retina_display_320x480.png"]];
    self.view.backgroundColor = background;
    background = nil;
     */

    UIView *xView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.ViewLogin.layer.cornerRadius = xView.frame.size.width/2;
    self.ViewLogin.layer.borderWidth = 1.0f;
    self.ViewLogin.layer.borderColor = [UIColor colorWithRed:222.0/255.0 green:225.0/255.0 blue:227.0/255.0 alpha:1.0].CGColor;
    self.ViewLogin.layer.masksToBounds = YES;
    xView = nil;

    self.Singleton  = [Singleton sharedMySingleton];
    [self ValidCredentials];
    
    self.IsOKLogin = NO;
    
    [self.Indicador stopAnimating];
    [self.Indicador setHidden:YES];
    
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self ValidCredentials];
    // NSLog(@"Apareció");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ValidCredentials{
    Usr = [self.Singleton getUser];
    if (![Usr  isEqual: @""]){
        [self.txtUsername setText:Usr];
        [self.txtPassword setText:[self.Singleton getPassword]];
    }
    
}


#pragma mark - getLogin
-(void)Login{
    @try
    {
        // Evio de Datos Sin Imagen
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [self.Indicador startAnimating];
        [self.Indicador setHidden:NO];
        
        [self.btnIngresar setEnabled:NO];
        [self.lblMensaje setText:@""];
        
        NSString *usernamex = [[NSString alloc] initWithFormat: @"%@",self.txtUsername.text];
        NSString *passwordl = [[NSString alloc] initWithFormat: @"%@",self.txtPassword.text];
        NSString *noteDataString = [NSString stringWithFormat:@"username=%@&passwordL=%@&UUID=%@&tD=%@&device_token=%@", usernamex, passwordl,self.Singleton.uniqueIdentifier,self.Singleton.typeDevice,self.Singleton.tokenUser];
        
        // Configuración de la sesión
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{
                                                       @"Accept" : @"application/json"
                                                       };
        
        // Inicialización de la sesión
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        
        // Tarea de gestión de datos
        NSURL *url = [NSURL URLWithString:@"http://platsource.mx/getLoginUserMobile/"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPBody = [noteDataString dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPMethod = @"POST";
        
        // Tarea de gestión de datos        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            // Sondeo de la respuesta HTTP del servidor
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
            if (HTTPResponse.statusCode == 200) {
                // Conversión de JSON a objeto Foundation (NSDictionary)
                NSError *JSONError;
                
                NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&JSONError];
                
                if (!JSONError) {
                    
                    datos = (NSMutableArray *)responseBody;
                    NSString *msg = [[datos objectAtIndex:0]objectForKey:@"msg"];
                    NSString *testString= [[datos objectAtIndex:0]objectForKey:@"data"];
                    //NSLog(@"Data->: %@",testString);
                    NSArray *Value = [testString componentsSeparatedByString:@"|"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (![msg isEqual: @"OK"]){
                            // NSLog(@"No hubo e %d",self.Singleton.Clave);
                            [self.lblMensaje setText:msg];
                        }else{
                            self.Singleton.Username              = usernamex;
                            self.Singleton.Password              = passwordl;
                            self.Singleton.IdUser                = [[Value objectAtIndex:0] intValue];
                            self.Singleton.IdEmp                 = [[Value objectAtIndex:2] intValue];
                            self.Singleton.Empresa               = [Value objectAtIndex:3];
                            self.Singleton.IdUserNivelAcceso     = [[Value objectAtIndex:3] intValue];
                            self.Singleton.RegistrosPorPagina    = [[Value objectAtIndex:4] intValue];
                            self.Singleton.Clave                 = [[Value objectAtIndex:5] intValue];
                            self.Singleton.Param1                = [[Value objectAtIndex:6] intValue];
                            self.Singleton.NombreCompletoUsuario = [Value objectAtIndex:7];
                            /*
                            NSLog(@"IdUser->: %d",self.Singleton.IdUser);
                            NSLog(@"Username->: %@",self.Singleton.Username);
                            NSLog(@"Password->: %@",self.Singleton.Password);
                            NSLog(@"IdEmp->: %d",self.Singleton.IdEmp);
                            NSLog(@"Empresa->: %@",self.Singleton.Empresa);
                            NSLog(@"IdUserNivelAcceso->: %d",self.Singleton.IdUserNivelAcceso);
                            NSLog(@"RegistrosPorPagina->: %d",self.Singleton.RegistrosPorPagina);
                            NSLog(@"Clave->: %d",self.Singleton.Clave);
                            NSLog(@"Param1->: %d",self.Singleton.Param1);
                            NSLog(@"Nombre Completo->: %@",self.Singleton.NombreCompletoUsuario);
                             */
                            
                            // NSLog(@"Clave %d",self.Singleton.Clave);

                            [self.Singleton insertUser:usernamex insertPass:passwordl];
                            
                            if (self.Singleton.IdUserNivelAcceso == 7){ // Tutores
                                [self performSegueWithIdentifier:@"NUno" sender:nil];
                            }else if (self.Singleton.IdUserNivelAcceso == 5){ // Alumnos
                                [self performSegueWithIdentifier:@"AAlumnos" sender:nil];
                            }else if (
                                      self.Singleton.IdUserNivelAcceso == 6 ||
                                      self.Singleton.IdUserNivelAcceso == 18 ||
                                      self.Singleton.IdUserNivelAcceso == 23
                                      
                                      ){ // Profesores
                                self.Singleton.Clave = 6;
                                [self performSegueWithIdentifier:@"PProfesores" sender:nil];
                            }else{
                                NSString *an = [NSString stringWithFormat:@"Acceso Denegado: %d",self.Singleton.Clave];
                                [self.lblMensaje setText:an];
                                an = nil;
                            }
                        }
                        
                        [self.btnIngresar setEnabled:YES];
                    });
                } else {
                    [self.btnIngresar setEnabled:YES];
                    [self.lblMensaje setText:@"Ocurrió un Error!"];
                    // NSAssert(NO, @"Error en la conversión de JSON a Foundation ");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.Indicador stopAnimating];
                        [self.Indicador setHidden:YES];
                    });
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                }
            } else {
                [self.btnIngresar setEnabled:YES];
                [self.lblMensaje setText:@"Ocurrió un Error!!"];
                // NSAssert(NO, @"Error a la hora de obtener las notas del servidor");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.Indicador stopAnimating];
                    [self.Indicador setHidden:YES];
                });
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.Indicador stopAnimating];
                [self.Indicador setHidden:YES];
            });
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }];
        
        [postDataTask resume];
        
    }
    @catch (NSException *theException)
    {
        // NSLog(@"Get Data Exception: %@", theException);
    }
}

-(void)dealloc{
    self.Singleton = nil;
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
    [self Login];
    
    if ( [identifier isEqualToString:@"NUno"] || [identifier isEqualToString:@"AAlumnos"] || [identifier isEqualToString:@"PProfesores"] ){
        if (self.IsOKLogin) return YES;
        else return NO;
    }
    
    return YES;
    
}
@end
