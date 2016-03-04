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
}

@end

@implementation Login
@synthesize Indicador, ViewLogin;
- (void)viewDidLoad {

    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"retina_display_320x480.png"]];
    self.view.backgroundColor = background;
    background = nil;

    UIView *xView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.ViewLogin.layer.cornerRadius = xView.frame.size.width/2;
    self.ViewLogin.layer.borderWidth = 1.0f;
    self.ViewLogin.layer.borderColor = [UIColor colorWithRed:222.0/255.0 green:225.0/255.0 blue:227.0/255.0 alpha:1.0].CGColor;
    self.ViewLogin.layer.masksToBounds = YES;
    xView = nil;

    self.Singleton  = [Singleton sharedMySingleton];
    self.IsOKLogin = NO;
    
    [self.Indicador stopAnimating];
    [self.Indicador setHidden:YES];
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        NSString *noteDataString = [NSString stringWithFormat:@"username=%@&passwordL=%@&UUID=%@&tD=%@", usernamex, passwordl,self.Singleton.uniqueIdentifier,self.Singleton.typeDevice];
        
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
                    NSLog(@"Data->: %@",msg);
                    NSArray *Value = [testString componentsSeparatedByString:@"|"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (![msg  isEqual: @"OK"]){
                            [self.lblMensaje setText:msg];
                        }else{
                            self.Singleton.Username           = usernamex;
                            self.Singleton.Password           = passwordl;
                            self.Singleton.IdUser             = [[Value objectAtIndex:0] intValue];
                            self.Singleton.IdEmp              = [[Value objectAtIndex:2] intValue];
                            self.Singleton.Empresa            = [Value objectAtIndex:3];
                            self.Singleton.IdUserNivelAcceso  = [[Value objectAtIndex:4] intValue];
                            self.Singleton.RegistrosPorPagina = [[Value objectAtIndex:5] intValue];
                            self.Singleton.Clave              = [[Value objectAtIndex:6] intValue];
                            self.Singleton.Param1             = [[Value objectAtIndex:7] intValue];
                            
                            /*
                             
                             NSLog(@"IdUser->: %@",self.Singleton.Username);
                             NSLog(@"Password->: %@",self.Singleton.Password);
                             NSLog(@"IdEmp->: %d",self.Singleton.IdEmp);
                             NSLog(@"Empresa->: %@",self.Singleton.Empresa);
                             NSLog(@"IdUserNivelAcceso->: %d",self.Singleton.IdUserNivelAcceso);
                             NSLog(@"RegistrosPorPagina->: %d",self.Singleton.RegistrosPorPagina);
                             NSLog(@"Clave->: %d",self.Singleton.Clave);
                             NSLog(@"Param1->: %d",self.Singleton.Param1);
                             
                             */
                            
                            [self performSegueWithIdentifier:@"NUno" sender:nil];
                        }
                        [self.btnIngresar setEnabled:YES];
                    });
                } else {
                    NSAssert(NO, @"Error en la conversión de JSON a Foundation ");
                }
            } else {
                NSAssert(NO, @"Error a la hora de obtener las notas del servidor");
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
        NSLog(@"Get Data Exception: %@", theException);
    }
}

-(void)dealloc{
    self.Singleton = nil;
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
    [self Login];
    
    if ( [identifier isEqualToString:@"NUno"] ){
        if (self.IsOKLogin) return YES;
        else return NO;
    }
    
    return YES;
    
}
@end
