//
//  TercerMenu.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import "TercerMenu.h"
#import "Singleton.h"
#import "VerTareasCirculares.h"

@interface TercerMenu ()

@end

@implementation TercerMenu{
    NSMutableArray *Menu;
}
@synthesize tblView, IdObjAlu, IdObjMenu, Indicator, Nav0, Bar0, Segment0, Status;

- (void)viewDidLoad {
    [self.Indicator startAnimating];
    self.Singleton  = [Singleton sharedMySingleton];
    [self.Segment0 setHidden:NO];
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    
    self.Status = 0;
    switch (self.IdObjMenu) {
        case 0:
        case 1:
            [self.Segment0 setHidden:NO];
            break;
        case 2:
        case 3:
            [self.Segment0 setHidden:YES];
            break;
    }
    
    switch (self.Singleton.Clave) {
        case 7:
            [self getTercerMenu];
            break;
            
        default:
            break;
    }
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

-(void)dealloc{
    self.Singleton = nil;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableId = @"";
    int vencido = [ [[Menu objectAtIndex:indexPath.row] objectForKey:@"dias_que_faltan_para_vencer"] intValue];
    int status_movto = [ [[Menu objectAtIndex:indexPath.row] objectForKey:@"status_movto"] intValue];

    switch (self.IdObjMenu) {
        case 3:
            if (vencido < 0 && status_movto == 0){
                TableId = @"TercerMenuCell_Vencido";
            }else{
                if (status_movto == 1){
                    TableId = @"TercerMenuCell_Pagado";
                }else{
                    TableId = @"TercerMenuCell";
                }
            }
            break;
        default:
            TableId = @"TercerMenuCell";
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableId forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableId];
    }
    switch (self.IdObjMenu) {
        case 0:
            cell.textLabel.text = [[Menu objectAtIndex:indexPath.row] objectForKey:@"titulo_tarea"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",
                                         [[Menu objectAtIndex:indexPath.row] objectForKey:@"materia"],
                                         [[Menu objectAtIndex:indexPath.row] objectForKey:@"grupo"]
                                         ];
            break;
        case 1:
            cell.textLabel.text = [[Menu objectAtIndex:indexPath.row] objectForKey:@"titulo_mensaje"];
            cell.detailTextLabel.text = @"";
            break;
        case 2:
            cell.textLabel.text = [[Menu objectAtIndex:indexPath.row] objectForKey:@"pdf"];
            cell.detailTextLabel.text = @"";
            break;
        case 3:
            
            // NSLog(@"vencido = %d, status_movto = %d",vencido,status_movto);

            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ ",
                                   [[Menu objectAtIndex:indexPath.row] objectForKey:@"concepto"],
                                   [[Menu objectAtIndex:indexPath.row] objectForKey:@"mes"]
                                   ];
            
            if (status_movto == 1){
                cell.detailTextLabel.text = [NSString stringWithFormat:@"PAGADO EL: %@ ",
                                             [[Menu objectAtIndex:indexPath.row] objectForKey:@"fecha_de_pago"]
                                             ];
            }else{
                if (vencido < 0){
                    cell.detailTextLabel.text = @"Vencido";                    
                }else{
                        cell.detailTextLabel.text = @"";
                }
            }
            
            break;
            
        default:
            break;
    }
    return cell;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"VerTareasCirculares"] || [segue.identifier isEqualToString:@"PagosVencidos"] ){
        
        NSIndexPath *iPath = [self.tblView indexPathForSelectedRow];
        VerTareasCirculares *vo = segue.destinationViewController;
        
        vo.title = [[Menu objectAtIndex:iPath.row] objectForKey:@"label"];
        
        vo.urlWeb = @"";
        
        switch (self.IdObjMenu) {
            case 0:
                vo.title = [[Menu objectAtIndex:iPath.row] objectForKey:@"titulo_tarea"];
                vo.IdTarea = [ [[Menu objectAtIndex:iPath.row] objectForKey:@"idtarea"] intValue];
                vo.IdObj = [ [[Menu objectAtIndex:iPath.row] objectForKey:@"idtareadestinatario"] intValue];
                // NSLog(@"idtareadestinatario = %d",vo.IdObj);
                break;
            case 1:
                vo.title = [[Menu objectAtIndex:iPath.row] objectForKey:@"titulo_mensaje"];
                vo.IdComMensaje = [ [[Menu objectAtIndex:iPath.row] objectForKey:@"idcommensaje"] intValue];
                vo.IdObj = [ [[Menu objectAtIndex:iPath.row] objectForKey:@"idcommensajedestinatario"] intValue];
                // NSLog(@"idcommensajedestinatario = %d",vo.IdObj);
                break;
            case 2:
                vo.title  = [[Menu objectAtIndex:iPath.row] objectForKey:@"pdf"];
                vo.IdObj = [ [[Menu objectAtIndex:iPath.row] objectForKey:@"idfactura"] intValue];
                vo.urlWeb = [NSString stringWithFormat:@"http://platsource.mx/uw_fe/%@/%@",
                                    [[Menu objectAtIndex:iPath.row] objectForKey:@"directorio"],
                                    [[Menu objectAtIndex:iPath.row] objectForKey:@"pdf"]
                                    ];
                break;
            case 3:
                
                vo.title  = [NSString stringWithFormat:@"%@ %@ ",
                             [[Menu objectAtIndex:iPath.row] objectForKey:@"concepto"],
                             [[Menu objectAtIndex:iPath.row] objectForKey:@"mes"]
                            ];
                vo.IdObj = [ [[Menu objectAtIndex:iPath.row] objectForKey:@"idedocta"] intValue];

                break;
                
            default:
                break;
        }
        
        vo.IdObjAlu  =  self.IdObjAlu;
        vo.IdObjMenu =  self.IdObjMenu;
        
    }

}




#pragma mark - getTercerMenu
-(void)getTercerMenu{
    @try
    {
        
        // Evio de Datos Sin Imagen
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSString *usernamex = self.Singleton.Username;
        NSString *noteDataString = [NSString stringWithFormat:@"username=%@&sts=%d&iduseralu=%d&tipoconsulta=%d", usernamex,self.Status,self.IdObjAlu, self.IdObjMenu];
        
        // Configuración de la sesión
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{@"Accept":@"application/json"};
        
        // Inicialización de la sesión
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        
        // Tarea de gestión de datos
        NSURL *url = [NSURL URLWithString:@"http://platsource.mx/getListaTutorTareas/"];
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
                        Menu = (NSMutableArray *)responseBody;
                        // NSLog(@"Lista de Tareas: %lu",(unsigned long)[Menu count]);
                        [tblView reloadData];
                        [self.Indicator stopAnimating];

                    });
                } else {
                    // NSLog(@"Cadena Request: %@",noteDataString);
                    NSAssert(NO, @"Error en la conversión de JSON a Foundation ");
                }
            } else {
                NSAssert(NO, @"Error a la hora de obtener las notas del servidor");
            }
            dispatch_async(dispatch_get_main_queue(), ^{ });
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [self.Indicator stopAnimating];
            }];
        
        [postDataTask resume];
        
    }
    @catch (NSException *theException)
    {
        NSLog(@"Get Data Exception: %@", theException);
    }
}


// -(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
 
    return @"Datos";
 
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *CellIdentifier = @"TercerMenuHeader";
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // CGFloat constraintSize = 32.0f;
    CGRect customCreationRect;
    customCreationRect.size.height = 32.0f;
    [headerView setFrame:customCreationRect];
    
    NSString *sectionName;
    
    switch (self.IdObjMenu)
    {
        case 0:
            sectionName = [NSString stringWithFormat:@"%lu TAREAS",(unsigned long)[Menu count] ];
            break;
        case 1:
            sectionName = [NSString stringWithFormat:@"%lu CIRCULARES",(unsigned long)[Menu count] ];
            break;
        case 2:
            sectionName = [NSString stringWithFormat:@"%lu FACTURAS",(unsigned long)[Menu count] ];
            break;
        case 3:
            sectionName = [NSString stringWithFormat:@"%lu PAGOS",(unsigned long)[Menu count] ];
            break;
        case 4:
            // sectionName = NSLocalizedString(@"BOLETAS", @"BOLETAS");
            sectionName = [NSString stringWithFormat:@"%lu BOLETAS",(unsigned long)[Menu count] ];
            break;
    }
    
    headerView.textLabel.text = sectionName;
    
    return headerView;
    
}


- (IBAction)btnActionSegment:(UISegmentedControl *)sender {
    
    Byte selectedSegment = sender.selectedSegmentIndex;

    [self.Indicator startAnimating];
    
    if (selectedSegment != self.Status){
        
        self.Status =  selectedSegment;

        Menu = [[NSMutableArray alloc]init];
        [self.tblView reloadData];
        
        switch (self.Singleton.Clave) {
            case 7:
                [self getTercerMenu];
                break;
                
            default:
                break;
        }
        
    }

    
}





@end
