//
//  Mensaje_Body.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 22/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import "Mensaje_Body.h"

@interface Mensaje_Body ()

@end

@implementation Mensaje_Body{
    NSString *miMIME;
}

@synthesize Singleton,WebView,urlWeb,loadingView,lblPorc, IdMobilMensaje;

- (void)viewDidLoad {
    [self Preloader];
    
    self.Singleton  = [Singleton sharedMySingleton];
    
    miMIME = @"text/html";
    self.urlWeb = [[NSString alloc] initWithFormat:self.Singleton.urlCuerpoMensaje, self.IdMobilMensaje, self.Singleton.IdUser,self.Singleton.IdEmp];
    [self getMensaje];
    
    // NSLog(@"URL Web: %@",self.urlWeb);
    
    [super viewDidLoad];
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

#pragma Preloader
-(void) Preloader{
    
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
        NSData *htmlData = [NSData dataWithContentsOfURL:location];
        [self.WebView loadData:htmlData MIMEType:miMIME textEncodingName:@"UTF-8" baseURL:location];
        
    });
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [loadingView setHidden:NO];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [loadingView setHidden:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma webView_shouldStartLoadWithRequest
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}


-(void)getMensaje{
    // Configuración de la sesión
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

- (IBAction)btnRefresh:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [loadingView setHidden:NO];
    [self getMensaje];
    
}

-(IBAction)Zoom:(UIPinchGestureRecognizer *)recognizer{
    @try {
        recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale,recognizer.scale); recognizer.scale = 1;
    }@catch (NSException *exception) { }
    @finally { }
    
}



@end
