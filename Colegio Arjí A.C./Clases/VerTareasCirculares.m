//
//  VerObjeto.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import "VerTareasCirculares.h"
#import "Singleton.h"

@interface VerTareasCirculares ()

@end

@implementation VerTareasCirculares{
    NSString *miMIME;
    NSData *MiData;
}



@synthesize WebView, IdObj, IdObjAlu, IdObjMenu, Singleton, IdTarea, loadingView, lblPorc, urlWeb, IdComMensaje;

- (void)viewDidLoad {

    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
        
    
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
    
    switch (self.Singleton.Clave) {
        case 7:
            if (self.IdObjMenu == 0 || self.IdObjMenu == 1 || self.IdObjMenu == 3){
                miMIME = @"text/html";
                [self getHTMLVal];
            }else if (self.IdObjMenu == 2){
                miMIME = @"application/pdf";
                [self getPDF];
                [self.btnShare setEnabled:YES];
            }else{
                
            }
            break;
            
        default:
            break;
    }
    
    
    [super viewDidLoad];

    self.WebView.opaque=NO;
    self.WebView.userInteractionEnabled=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.WebView = nil;
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    self.WebView = nil;
    self.Singleton = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma Get HTML Val
-(void)getHTMLVal{

    @try
    {
        
    // Configuración de la sesión
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSString *usernamex = self.Singleton.Username;
    NSString *noteDataString;
    // Tarea de gestión de datos
    NSURL *url = [NSURL URLWithString:@"http://platsource.mx/getHTMLTemplate/"];
    if (self.IdObjMenu == 0){
        noteDataString = [NSString stringWithFormat:@"user=%@&idtarea=%d&idtareadestinatario=%d", usernamex,self.IdTarea,self.IdObj];
    }else     if (self.IdObjMenu == 1){
        noteDataString = [NSString stringWithFormat:@"user=%@&idcommensaje=%d&idcommensajedestinatario=%d&sts=0", usernamex,self.IdComMensaje,self.IdObj];
        url = [NSURL URLWithString:@"http://platsource.mx/getCircularesHTMLTemplate/"];
    }else     if (self.IdObjMenu == 3){
        noteDataString = [NSString stringWithFormat:@"user=%@&iduser=%d&idedocta=%d&sts=0", usernamex,self.Singleton.IdUser,self.IdObj];
        url = [NSURL URLWithString:@"http://platsource.mx/getPagosLayout/"];
        
    }
        
    // Tarea de gestión de datos
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [noteDataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    // Configuración de la sesión
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{@"Accept":@"html/text"};
 
    // Creación de la sesión
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];

    // Tarea de descarga de archivo
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request];
    [downloadTask resume];
 
    }
    @catch (NSException *theException)
    {
        NSLog(@"Get Data Exception: %@", theException);
    }

    
    
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
    // NSLog(@"Descarga terminada");
    
    NSData *htmlData = [NSData dataWithContentsOfURL:location];
    [self.WebView loadData:htmlData MIMEType:miMIME textEncodingName:@"UTF-8" baseURL:location];

    dispatch_async(dispatch_get_main_queue(), ^{
        [loadingView removeFromSuperview];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        MiData = htmlData;

    });
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [loadingView setHidden:NO];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [loadingView removeFromSuperview];
    
}

#pragma webView_shouldStartLoadWithRequest
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        NSLog(@"Entro");
        return NO;
    }
    
    return YES;
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
        NSString *filePath = [cachePath stringByAppendingPathComponent:@"factura.pdf"];
        NSData *pdfFile = [NSData dataWithData:MiData];
        [pdfFile writeToFile:filePath atomically:YES];
        UIDocumentInteractionController *documentInteractionController;

        NSURL* URL = [NSURL fileURLWithPath:filePath];
        
        documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        [documentInteractionController setDelegate:self];
        [documentInteractionController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
        
        
        
    }
    
}




@end
