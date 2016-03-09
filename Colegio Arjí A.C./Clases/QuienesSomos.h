//
//  QuienesSomos.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 09/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface QuienesSomos : UIViewController<NSURLSessionDownloadDelegate, UIWebViewDelegate, UIDocumentInteractionControllerDelegate>{
    UIView* loadingView;
    UILabel* lblPorc;
    NSString *urlWeb;
}

@property (strong, nonatomic) IBOutlet UIWebView *WebView;

@property (nonatomic, retain) NSString *urlWeb;

@property (strong, nonatomic) UIView* loadingView;
@property (strong, nonatomic) UILabel* lblPorc;

@property (strong,nonatomic) Singleton *Singleton;

@property (nonatomic) UIDocumentInteractionController *interactionController;

- (IBAction)btnRefresh:(id)sender;

-(IBAction)Zoom:(UIPinchGestureRecognizer *)recognizer;

-(void) Preloader;

-(void)getURLQuienesSomos;

@end
