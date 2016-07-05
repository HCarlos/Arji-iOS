//
//  MasInfo_Directorio.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 10/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface MasInfo_Directorio : UIViewController<NSURLSessionDownloadDelegate, UIWebViewDelegate, UIDocumentInteractionControllerDelegate>{
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
- (void)getDirectorio;

@end
