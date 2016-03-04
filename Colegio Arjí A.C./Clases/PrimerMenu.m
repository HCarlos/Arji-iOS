//
//  PrimerMenu.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import "PrimerMenu.h"
#import "SegundoMenu.h"
#import "Singleton.h"

@interface PrimerMenu ()

@end

@implementation PrimerMenu{
    NSMutableArray *Hijos;
}
@synthesize tblView, Indicator;

- (void)viewDidLoad {
/*
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
*/
    
    self.tableView.layer.cornerRadius = 5.0f;
    [self.tableView.layer setMasksToBounds:YES];
    
    // [self.tblView registerClass:[M3CHeaderFooter class] forHeaderFooterViewReuseIdentifier:@"PrimerMenuHeader"];
    
    [self.Indicator startAnimating];

    self.Singleton  = [Singleton sharedMySingleton];
    
    // NSLog(@"Clave: %d",self.Singleton.Clave);
    
    switch (self.Singleton.Clave) {
        case 7:
            [self getHijos];
            break;
            
        default:
            [self.Indicator stopAnimating];
            UILabel* lblLoading = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, 350, 30)];
            lblLoading.text = @"No se encontraron datos para este Usuario.";
            lblLoading.textColor = [UIColor brownColor];
            lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:15];
            lblLoading.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:lblLoading];
            
            break;
    }
 
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    self.Singleton = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Hijos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *TableId = @"PrimerMenuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableId forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableId];

        [cell.layer setCornerRadius:5.0];
        
    
    }
    
    cell.textLabel.text = [[Hijos objectAtIndex:indexPath.row] objectForKey:@"label"];
    cell.detailTextLabel.text = [[Hijos objectAtIndex:indexPath.row] objectForKey:@"grupo"];
    // NSLog(@"grupo: %@", [[Hijos objectAtIndex:indexPath.row] objectForKey:@"grupo"]  );
    return cell;
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"DDos"]){
        NSIndexPath *iPath = [self.tblView indexPathForSelectedRow];
        SegundoMenu *sm = segue.destinationViewController;
        sm.title = [[Hijos objectAtIndex:iPath.row] objectForKey:@"label"];
        sm.IdObjAlu = [ [[Hijos objectAtIndex:iPath.row] objectForKey:@"data"] intValue];
    }

    if ([segue.identifier isEqualToString:@"CloseSession"]){
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Cerrar Sesión"
                                      message:@"Desea cerrar la sesión actual?"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Si, por favor"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        exit(0);
                            
                                    }];
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"No, gracias"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       //Handel no, thanks button
                                       
                                   }];
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }

}



#pragma mark - getHijos
-(void)getHijos{
    @try
    {
        
        // Evio de Datos Sin Imagen
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSString *usernamex = self.Singleton.Username;
        NSString *noteDataString = [NSString stringWithFormat:@"username=%@", usernamex];
        
        // Configuración de la sesión
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{@"Accept":@"application/json"};
        
        // Inicialización de la sesión
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        
        // Tarea de gestión de datos
        NSURL *url = [NSURL URLWithString:@"http://platsource.mx/getListaHijos/"];
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
                    dispatch_async(dispatch_get_main_queue(), ^{
                        Hijos = (NSMutableArray *)responseBody;
                        // NSLog(@"Hijos: %lu",(unsigned long)[Hijos count]);
                        [tblView reloadData];
                        [self.Indicator stopAnimating];

                        
                    });
                } else {
                    NSAssert(NO, @"Error en la conversión de JSON a Foundation ");
                }
            } else {
                NSAssert(NO, @"Error a la hora de obtener las notas del servidor");
            }
            dispatch_async(dispatch_get_main_queue(), ^{ });
                [self.Indicator stopAnimating];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }];
        
        
        
        [postDataTask resume];
        
        
    }
    @catch (NSException *theException)
    {
        NSLog(@"Get Data Exception: %@", theException);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"ALUMNOS";
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *CellIdentifier = @"PrimerMenuHeader";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    [cell.layer setCornerRadius:5.0];
    
    return cell;

}




@end
