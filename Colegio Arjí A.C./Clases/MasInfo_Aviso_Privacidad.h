//
//  MasInfo_Aviso_Privacidad.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 13/09/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface MasInfo_Aviso_Privacidad : UIViewController<NSURLSessionDownloadDelegate, UIWebViewDelegate, UIDocumentInteractionControllerDelegate>{
    UIView* loadingView;
    UILabel* lblPorc;
    NSString *urlWeb;
    Singleton *Singleton;
}
@property (nonatomic, retain) NSString *urlWeb;
@property (strong, nonatomic) UIView* loadingView;
@property (strong, nonatomic) UILabel* lblPorc;

@property (strong,nonatomic) Singleton *Singleton;
@property (strong, nonatomic) IBOutlet UIWebView *WebView;
- (IBAction)btnRefresh:(id)sender;
- (IBAction)Zoom:(UIPinchGestureRecognizer *)recognizer;
- (void) Preloader;
- (void)getAvisoPrivacidad;

@end
