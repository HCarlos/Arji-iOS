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
    UILabel* lblTbl;
    NSMutableArray* arrPagos;
}
@synthesize tblView, IdObjAlu, IdObjMenu, Indicator, Nav0, Bar0, Segment0, Status;

- (void)viewDidLoad {
    [self.Indicator startAnimating];

    lblTbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, 350, 30)];
    lblTbl.text = @"No se encontraron Mensajes para este Usuario.";
    lblTbl.textColor = [UIColor brownColor];
    lblTbl.font = [UIFont fontWithName:lblTbl.font.fontName size:15];
    lblTbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblTbl];
    [lblTbl setHidden:YES];
    
    
    self.Singleton  = [Singleton sharedMySingleton];
    [self.Segment0 setHidden:NO];

    self.tableView.layer.cornerRadius = 5.0f;
    [self.tableView.layer setMasksToBounds:YES];
    
    self.Status = 0;
    if (self.Singleton.Clave == 3){
        switch (self.IdObjMenu) {
            case 1:
                [self.Segment0 setHidden:NO];
                break;
        }
    }else if (self.Singleton.Clave == 5){
        switch (self.IdObjMenu) {
            case 0:
            case 1:
                [self.Segment0 setHidden:NO];
                break;
        }
    }else if (self.Singleton.Clave == 6){
            switch (self.IdObjMenu) {
                case 1:
                    [self.Segment0 setHidden:NO];
                    break;
            }
    }else if (self.Singleton.Clave == 7 || self.Singleton.Clave == 28 || self.Singleton.Clave == 29){
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
        
    }
    
    switch (self.Singleton.Clave) {
        case 3:
        case 5:
        case 6:
        case 7:
        case 28:
        case 29:
            NSLog(@"STATUS INIT: %hhu",self.Status);
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
    
    // Boolean primerPago = false;
    
    static NSString *TableId = @"";
    int vencido = [ [[Menu objectAtIndex:indexPath.row] objectForKey:@"dias_que_faltan_para_vencer"] intValue];
    int status_movto = [ [[Menu objectAtIndex:indexPath.row] objectForKey:@"status_movto"] intValue];
    int idconceptounico = [ [[Menu objectAtIndex:indexPath.row] objectForKey:@"idconceptounico"] intValue];
    
    if (self.Singleton.Clave == 3){
        TableId = @"TercerMenuCell";
    }
    
    if (self.Singleton.Clave == 5){
        TableId = @"TercerMenuCell";
    }

    if (self.Singleton.Clave == 6){
        TableId = @"TercerMenuCell";
    }
    
    if (self.Singleton.Clave == 7 || self.Singleton.Clave == 28 || self.Singleton.Clave == 29){
        switch (self.IdObjMenu) {
            case 3:
                if (vencido < 0 && status_movto == 0){
                    TableId = @"TercerMenuCell_Vencido";
                }else{
                    if (status_movto == 1){
                        TableId = @"TercerMenuCell_Pagado";
                    }else{
                        if ( idconceptounico == 0 ){
                            TableId = @"TercerMenuCell_PorVencer";
                        }else{
                            TableId = @"TercerMenuCell_Pago_Normal";
                        }
                    }
                }
                break;
            // case 0:
            //     TableId = @"TercerMenuCell_Custom_1";
            //     break;
            default:
                TableId = @"TercerMenuCell";
                break;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableId forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableId];
    }
    
    NSLog(@"INDEX PATH: %ld",(long)indexPath.row);

    if (self.Singleton.Clave == 3){
        switch (self.IdObjMenu) {
            case 1:
                [self sayMessageTable:indexPath.row Celda:cell];
                break;
                
            default:
                break;
        }
    }
    
    if (self.Singleton.Clave == 5){
        switch (self.IdObjMenu) {
            case 0:
                [self sayTareaTable:indexPath.row Celda:cell];
                break;
            case 1:
                [self sayMessageTable:indexPath.row Celda:cell];
                break;
                
            default:
                break;
        }
    }
    
    if (self.Singleton.Clave == 6){
        switch (self.IdObjMenu) {
            case 1:
                [self sayMessageTable:indexPath.row Celda:cell];
                break;
                
            default:
                break;
        }
    }
    
    
    if (self.Singleton.Clave == 7 || self.Singleton.Clave == 28 || self.Singleton.Clave == 29){
        switch (self.IdObjMenu) {
            case 0:
                [self sayTareaTable:indexPath.row Celda:cell];
                break;
            case 1:
                [self sayMessageTable:indexPath.row Celda:cell];
                break;
            case 2:
                cell.textLabel.text = [[Menu objectAtIndex:indexPath.row] objectForKey:@"pdf"];
                cell.detailTextLabel.text = @"";
                break;
            case 3:
                
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
    }
    
    return cell;

}



- (void)updateTableViewCell:(UITableViewCell *)cell forCount:(NSUInteger)count
{
    // Count > 0, show count
    if (count > 0) {
        
        // Create label
        CGFloat fontSize = 14;
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:fontSize];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor redColor];
        
        // Add count to label and size to fit
        label.text = [NSString stringWithFormat:@"%@", @(count)];
        [label sizeToFit];
        
        // Adjust frame to be square for single digits or elliptical for numbers > 9
        CGRect frame = label.frame;
        frame.size.height += (int)(0.4*fontSize);
        frame.size.width = (count <= 9) ? frame.size.height : frame.size.width + (int)fontSize;
        label.frame = frame;
        
        // Set radius and clip to bounds
        label.layer.cornerRadius = frame.size.height/2.0;
        label.clipsToBounds = true;
        
        // Show label in accessory view and remove disclosure
        cell.accessoryView = label;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Count = 0, show disclosure
    else {
        cell.accessoryView = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}





#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //  [segue.identifier isEqualToString:@"VerTareasCircularesCustom"] ||
    
    if ([segue.identifier isEqualToString:@"VerTareasCirculares"] ||
       
        [segue.identifier isEqualToString:@"PagosVencidos"] ){
        
        NSIndexPath *iPath = [self.tblView indexPathForSelectedRow];
        VerTareasCirculares *vo = segue.destinationViewController;
        
        vo.title = [[Menu objectAtIndex:iPath.row] objectForKey:@"label"];
        
        vo.urlWeb = @"";
        
        NSLog(@"Menu %d",self.IdObjMenu);
        
        switch (self.IdObjMenu) {
            case 0:
                vo.title = [[Menu objectAtIndex:iPath.row] objectForKey:@"titulo_tarea"];
                vo.IdTarea = [ [[Menu objectAtIndex:iPath.row] objectForKey:@"idtarea"] intValue];
                vo.IdObj = [ [[Menu objectAtIndex:iPath.row] objectForKey:@"idtareadestinatario"] intValue];
                break;
            case 1:
                vo.title = @"Sin título";
                if ([[Menu objectAtIndex:iPath.row] objectForKey:@"titulo_mensaje"]){
                    vo.title = [[Menu objectAtIndex:iPath.row] objectForKey:@"titulo_mensaje"];
                }
                vo.IdComMensaje = [ [[Menu objectAtIndex:iPath.row] objectForKey:@"idcommensaje"] intValue];
                vo.IdObj = [ [[Menu objectAtIndex:iPath.row] objectForKey:@"idcommensajedestinatario"] intValue];
                break;
                
            case 2:
                vo.title  = [[Menu objectAtIndex:iPath.row] objectForKey:@"pdf"];
                vo.IdObj = [ [[Menu objectAtIndex:iPath.row] objectForKey:@"idfactura"] intValue];
                vo.urlWeb = [NSString stringWithFormat:self.Singleton.urlFE,
                                    [[Menu objectAtIndex:iPath.row] objectForKey:@"directorio"],
                                    [[Menu objectAtIndex:iPath.row] objectForKey:@"pdf"]
                                    ];
                break;
                
        }
        
        vo.IdObjAlu  =  self.IdObjAlu;
        vo.IdObjMenu =  self.IdObjMenu;
        
    }

}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath{
    
    int IdObj = [ [[Menu objectAtIndex:indexPath.row] objectForKey:@"idedocta"] intValue];
    NSInteger idconcepto = [ [[Menu objectAtIndex:indexPath.row] objectForKey:@"idconceptounico"] intValue];
    NSString *urlstring = [[NSString alloc] initWithFormat:self.Singleton.urlPagos,IdObj,self.Singleton.Username,self.Singleton.IdUser, (long)idconcepto] ;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [[UIApplication sharedApplication] openURL:[request URL]];
    
}



#pragma mark - getTercerMenu
-(void)getTercerMenu{
    @try
    {
        
        // Evio de Datos Sin Imagen
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [self.Indicator startAnimating];
        [lblTbl setHidden:YES];
        
        NSString *usernamex = self.Singleton.Username;
        NSString *noteDataString = [NSString stringWithFormat:@"username=%@&sts=%d&iduseralu=%d&tipoconsulta=%d", usernamex,self.Status,self.IdObjAlu, self.IdObjMenu];
        
        
        NSLog(@"STRING QRY: %@", noteDataString);
        
        // Configuración de la sesión
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{@"Accept":@"application/json"};
        
        // Inicialización de la sesión
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        
        // Tarea de gestión de datos
        NSURL *url = [NSURL URLWithString:self.Singleton.urlListaTutorTareas];
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
                        NSLog(@"RESPUESTA: %@",responseBody);
                        Menu = (NSMutableArray *)responseBody;
                        NSString *msg = [[Menu objectAtIndex:0]objectForKey:@"msg"];
                        
                        if ([msg  isEqual: @"OK"]){
                            
                            [tblView reloadData];
                            
                            [lblTbl setHidden:YES];
                            
                        }else{
                            [lblTbl setHidden:NO];
                        }
                        
                        [self.Indicator stopAnimating];

                    });
                } else {
                    // NSLog(@"Cadena Request: %@",noteDataString);
                    NSAssert(NO, @"Error en la conversión de JSON a Foundation ");
                    [postDataTask resume];
                }
            } else {
                NSAssert(NO, @"Error a la hora de obtener las notas del servidor");
                [postDataTask resume];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSLog(@"Section %ld",(long)section);
    
    static NSString *CellIdentifier = @"TercerMenuHeader";
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    CGRect customCreationRect = headerView.frame;
    
    customCreationRect.size.height = 32.0f;
    [headerView setFrame:customCreationRect];

    NSString *_sectionName = [NSString stringWithFormat:@""];

    if (self.Singleton.Clave == 3){
        switch (self.IdObjMenu)
        {
            case 1:
                _sectionName = [self sayHeaderTable:@"%lu CIRCULARES %@" Param:0];
                break;
        }
    }
    
    if (self.Singleton.Clave == 5){
        switch (self.IdObjMenu)
        {
            case 0:
                _sectionName = [self sayHeaderTable:@"%lu TAREAS %@" Param:0];
                break;
            case 1:
                _sectionName = [self sayHeaderTable:@"%lu CIRCULARES %@" Param:0];
                break;
        }
    }

    if (self.Singleton.Clave == 6){
        switch (self.IdObjMenu)
        {
            case 1:
                _sectionName = [self sayHeaderTable:@"%lu CIRCULARES %@" Param:0];
                break;
        }
    }
    
    if (self.Singleton.Clave == 7 || self.Singleton.Clave == 28 || self.Singleton.Clave == 29){
        switch (self.IdObjMenu)
        {
            case 0:
                _sectionName = [self sayHeaderTable:@"%lu TAREAS %@" Param:0];
                break;
            case 1:
                _sectionName = [self sayHeaderTable:@"%lu CIRCULARES %@" Param:0];
                break;
            case 2:
                _sectionName = [self sayHeaderTable:@"%lu FACTURAS" Param:1];
                break;
            case 3:
                _sectionName = [self sayHeaderTable:@"%lu PAGOS" Param:1];
                break;
        }
    }
    
    NSLog(@"Section 2:  %ld",(long)section);
    
    
    headerView.textLabel.text = _sectionName;
    
    return headerView;
    
}

-(NSString *)sayHeaderTable:(NSString *) Label Param:(NSInteger) param{
    NSString *sStatus = nil;
    // sStatus = @" NUEVAS";
    
    NSLog(@"STATUS 3:  %hhu",self.Status);
    
    sStatus = self.Status == 0 ? @" NUEVAS" : @" REVISADAS";
    NSString *_sectionName;
    
    
    if (param==0){
        _sectionName = [NSString stringWithFormat:Label,(unsigned long)[Menu count], sStatus ];
    }else{
        _sectionName = [NSString stringWithFormat:Label,(unsigned long)[Menu count] ];
    }
    
    NSLog(@"STATUS 4:  %@", _sectionName);

    return (unsigned long)[Menu count] == 0 ? @"Cargando Datos..." : _sectionName;
}

-(void)sayMessageTable:(NSInteger) Indice Celda:(UITableViewCell*) cell{
    
    @try
    {
        NSString *tituloM = @"Hola";
        NSString *titDetM = @"";
        tituloM = [[Menu objectAtIndex:Indice] objectForKey:@"titulo_mensaje"] ;
        titDetM = [[Menu objectAtIndex:Indice] objectForKey:@"nombre_remitente"];
        
        cell.textLabel.text = tituloM;
        cell.detailTextLabel.text = titDetM;

        int IsLeida = [ [[Menu objectAtIndex:Indice] objectForKey:@"isleida"] intValue];
        NSString *isleida = IsLeida == 0 ? @"badge_red" : @"badge_white";

        cell.accessoryView = [[ UIImageView alloc ]
                              initWithImage:[UIImage imageNamed:isleida ]];
        
        
    }
    @catch (NSException *theException)
    {
        NSLog(@"Data Table Error: %@", theException);
    }
    
}

-(void)sayTareaTable:(NSInteger) Indice Celda:(UITableViewCell*) cell{
    cell.textLabel.text = [[Menu objectAtIndex:Indice] objectForKey:@"titulo_tarea"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",
                                [[Menu objectAtIndex:Indice] objectForKey:@"materia"],
                                [[Menu objectAtIndex:Indice] objectForKey:@"grupo"]
                                ];
    int IsLeida = [ [[Menu objectAtIndex:Indice] objectForKey:@"isleida"] intValue];
    NSString *isleida = IsLeida == 0 ? @"badge_red" : @"badge_white";
    
    cell.accessoryView = [[ UIImageView alloc ]
                          initWithImage:[UIImage imageNamed:isleida ]];

}

- (IBAction)btnActionSegment:(UISegmentedControl *)sender {
    
    Byte selectedSegment = sender.selectedSegmentIndex;

    [self.Indicator startAnimating];
    
    if (selectedSegment != self.Status){
        
        self.Status =  selectedSegment;
        
        Menu = [[NSMutableArray alloc]init];
        [self.tblView reloadData];
        
        switch (self.Singleton.Clave) {
            case 3:
            case 5:
            case 6:
            case 7:
            case 28:
            case 29:
                NSLog(@"STATUS: %hhu",self.Status);
                [self getTercerMenu];
                break;
            default:
                break;
        }
        
    }
    
}





@end
