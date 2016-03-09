//
//  Boletin.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 08/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import "Boletin.h"

@interface Boletin ()

@end

@implementation Boletin{
    NSString *miMIME;
    NSData *MiData;
}
@synthesize WebView, Singleton, loadingView, lblPorc, urlWeb, interactionController;

- (void)viewDidLoad {

    loadingView = [[UIView alloc]initWithFrame:CGRectMake(
                                                          ((self.WebView.scrollView.contentSize.width/2)-60),
                                                          ((self.WebView.scrollView.contentSize.height/2)-50),
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
    
    self.Singleton  = [Singleton sharedMySingleton];
    
    // NSLog(@"Clave: %d",self.Singleton.Clave);
    [self.btnShare setEnabled:NO];
    
    [self getURLBoletin];
    
    
    [super viewDidLoad];
    
    self.WebView.opaque=NO;
    self.WebView.userInteractionEnabled=YES;
    
    
    // Do any additional setup after loading the view.
}

-(void)dealloc{
    self.WebView = nil;
    self.Singleton = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double currentProgress = (double)totalBytesWritten / totalBytesExpectedToWrite;
    int porc = (int)(currentProgress * 100.0f);
    // NSLog(@"Progreso de descarga… %d", porc);
    self->lblPorc.text = [NSString stringWithFormat: @"%d",porc];
}

#pragma mark - didFinishDownloadingToURL
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData *htmlData = [NSData dataWithContentsOfURL:location];
        MiData = htmlData;
        [self.WebView loadData:htmlData MIMEType:miMIME textEncodingName:@"UTF-8" baseURL:location];
        
    });
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [loadingView setHidden:NO];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [loadingView removeFromSuperview];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma webView_shouldStartLoadWithRequest
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    return YES;
}


-(void)getURLBoletin{
    // Configuración de la sesión
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{
                                                   @"api-key"   : @"55e76dc4bbae25b066cb",
                                                   @"Accept"    : @"application/json"
                                                   };
    
    // Inicialización de la sesión
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    // Tarea de gestión de datos
    NSURL *url = [NSURL URLWithString:@"http://platsource.mx/getBoletin/"];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // Sondeo de la respuesta HTTP del servidor
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        if (HTTPResponse.statusCode == 200) {
            if (!error) {
                // Conversión de JSON a objeto Foundation (NSArray)
                NSError *JSONError;
                NSArray *notes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&JSONError];
                
                if (!JSONError) {
                    NSString *msg = [[notes objectAtIndex:0]objectForKey:@"msg"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (![msg  isEqual: @"OK"]){
                            //[self.lblMensaje setText:msg];
                        }else{
                            self.urlWeb           = [[notes objectAtIndex:0]objectForKey:@"ruta"];
                            NSLog(@"%@",self.urlWeb);
                            miMIME = @"application/pdf";
                            [self getPDF];
                            [self.btnShare setEnabled:YES];
                        }
                    });
                } else {
                    NSAssert(NO, @"Error en la conversión de JSON a Foundation");
                }
            } else {
                NSAssert(NO, @"Error al obtener las notas del servidor");
            }
        }
    }];
    [dataTask resume];
}


#pragma getPDF
-(void)getPDF{
    @try {
        // Configuración de la sesión
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
        
        // Creación de la sesión
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
        
        // Tarea de descarga de archivo
        NSURL *url = [NSURL URLWithString:self.urlWeb];
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
        [downloadTask resume];
        
    }@catch (NSException *exception) { }
    @finally { }
    
}

-(IBAction)Zoom:(UIPinchGestureRecognizer *)recognizer{
    @try {
        recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale,recognizer.scale); recognizer.scale = 1;
    }@catch (NSException *exception) { }
    @finally { }
    
}

- (IBAction)btnShare:(id)sender {
    
    NSURL *url = self.WebView.request.URL;
    if (url != nil) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [paths objectAtIndex:0];
        BOOL isDir = NO;
        NSError *error;
        //You must check if this directory exist every time
        if (! [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDir] && isDir   == NO)
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:&error];
        }
        NSString *filePath = [cachePath stringByAppendingPathComponent:@"boletin.pdf"];
        NSData *pdfFile = [NSData dataWithData:MiData];
        [pdfFile writeToFile:filePath atomically:YES];
        
        NSURL* URL = [NSURL fileURLWithPath:filePath];
        self.interactionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        [self.interactionController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
        
    }
    
}


@end
