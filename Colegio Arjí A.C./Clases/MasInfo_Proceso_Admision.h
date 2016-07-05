//
//  MasInfo_Proceso_Admision.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 11/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface MasInfo_Proceso_Admision : UIViewController<NSURLSessionDownloadDelegate, UIWebViewDelegate, UIDocumentInteractionControllerDelegate>{
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
- (void)getProcesoAdmision;

@end
