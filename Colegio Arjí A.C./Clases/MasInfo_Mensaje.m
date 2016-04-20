//
//  MasInfo_Mensaje.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 18/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import "MasInfo_Mensaje.h"
#import "Mensaje_Body.h"

@interface MasInfo_Mensaje ()

@end

@implementation MasInfo_Mensaje{
    NSMutableArray *arrMensajes;
    UILabel* lblTbl;
}

@synthesize Singleton, tblMensajes, Status, IdMensaje, loadingView, lblPorc;
// Felices vacaciones de semana santa, nos vemos el lunes 4 de abril.

- (void)viewDidLoad {
    [self Preloader];

    lblTbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, 350, 30)];
    lblTbl.text = @"No se encontraron Mensajes para este Usuario.";
    lblTbl.textColor = [UIColor brownColor];
    lblTbl.font = [UIFont fontWithName:lblTbl.font.fontName size:15];
    lblTbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblTbl];
    [lblTbl setHidden:YES];
    
    self.Singleton  = [Singleton sharedMySingleton];
    
    self.tblMensajes.delegate = self;
    
    self.Status = 0;
    
    [self getMensajes];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)dealloc{
    self.Singleton = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Preloader
-(void) Preloader{
    
    loadingView = [[UIView alloc]initWithFrame:CGRectMake(
                                                          ((self.view.frame.size.width/2)-60),
                                                          ((self.view.frame.size.height/2)-50),
                                                          120,
                                                          100
                                                          )];
    
    loadingView.backgroundColor = [UIColor colorWithWhite:0. alpha:0.6];
    loadingView.layer.cornerRadius = 5;
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center = CGPointMake(loadingView.frame.size.width / 2.0, 35);
    [activityView startAnimating];
    activityView.tag = 100;
    [loadingView addSubview:activityView];
    
    UILabel* lblLoading = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, 100, 30)];
    lblLoading.text = @"Cargando...";
    lblLoading.textColor = [UIColor whiteColor];
    lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:15];
    lblLoading.textAlignment = NSTextAlignmentCenter;
    [loadingView addSubview:lblLoading];
    
    lblPorc = [[UILabel alloc]initWithFrame:CGRectMake(0, 68, 100, 30)];
    // lblPorc.text = @"%";
    lblPorc.textColor = [UIColor whiteColor];
    lblPorc.font = [UIFont fontWithName:lblPorc.font.fontName size:15];
    lblPorc.textAlignment = NSTextAlignmentCenter;
    [loadingView addSubview:lblPorc];
    
    
    [self.view addSubview:loadingView];
    
}

#pragma mark - didFinishDownloadingToURL
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // NSData *htmlData = [NSData dataWithContentsOfURL:location];
        // MiData = htmlData;
        // [self.WebView loadData:htmlData MIMEType:miMIME textEncodingName:@"UTF-8" baseURL:location];
        
    });
}


#pragma mark - getMensajes
-(void)getMensajes{
    @try
    {
        
        // Evio de Datos Sin Imagen
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [loadingView setHidden:NO];
        [lblTbl setHidden:YES];
        
        NSString *noteDataString = [NSString stringWithFormat:@"iduser=%d&device=%@&sts=%d", self.Singleton.IdUser,self.Singleton.tokenUser,self.Status];
        
        // Configuración de la sesión
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{@"Accept":@"application/json"};
        
        // Inicialización de la sesión
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        
        // Tarea de gestión de datos
        NSURL *url = [NSURL URLWithString:@"http://platsource.mx/getMensajes/"];
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
                
                arrMensajes = (NSMutableArray *)responseBody;
                
                if (!JSONError) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *msg = [[arrMensajes objectAtIndex:0]objectForKey:@"msg"];
                        if ([msg  isEqual: @"OK"]){

                            //arrMensajes = (NSMutableArray *)responseBody;
                            [tblMensajes reloadData];
                        
                            [lblTbl setHidden:YES];
                        }else{
                            
                            [lblTbl setHidden:NO];
                        
                        }
                        
                        [loadingView setHidden:YES];
                        
                    });
                } else {
                    NSAssert(NO, @"Error en la conversión de JSON a Foundation; %@",noteDataString);
                    [postDataTask resume];
                }
            } else {
                NSAssert(NO, @"Error a la hora de obtener las notas del servidor");
                [postDataTask resume];
            }
            dispatch_async(dispatch_get_main_queue(), ^{ });
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }];
        
        [postDataTask resume];
        
    }
    @catch (NSException *theException)
    {
        NSLog(@"Get Data Exception: %@", theException);
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"NOTIFICACIONES";
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrMensajes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableId =  @"Mensaje_Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableId forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableId];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",
                                   [[arrMensajes objectAtIndex:indexPath.row] objectForKey:@"mensaje"]
                                   ];
            
    return cell;
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"MMensaje"] ){
        
        NSIndexPath *iPath = [self.tblMensajes indexPathForSelectedRow];
        Mensaje_Body *mb = segue.destinationViewController;
        
        mb.title = [[arrMensajes objectAtIndex:iPath.row] objectForKey:@"mensaje"];
        mb.IdMobilMensaje = [ [[arrMensajes objectAtIndex:iPath.row] objectForKey:@"idmobilmensaje"] intValue];
        
        // NSLog(@"idmobilmensaje: %d",mb.IdMobilMensaje);
        
    }
    
}


- (IBAction)btnRefresh:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [loadingView setHidden:NO];
    [self getMensajes];
}

- (IBAction)btnActionSegment:(UISegmentedControl *)sender {
    
    Byte selectedSegment = sender.selectedSegmentIndex;
    
    if (selectedSegment != self.Status){
        
        self.Status =  selectedSegment;
        
        arrMensajes = [[NSMutableArray alloc]init];
        [self.tblMensajes reloadData];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [loadingView setHidden:NO];
        [self getMensajes];
        
    }
    
}



@end
