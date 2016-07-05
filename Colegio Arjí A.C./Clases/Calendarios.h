//
//  Calendarios.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 09/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
@interface Calendarios : UIViewController<NSURLSessionDownloadDelegate, UIWebViewDelegate, UIDocumentInteractionControllerDelegate>{
    UIView* loadingView;
    UILabel* lblPorc;
    NSString *urlWeb;
    int IdObjAlu;
    int IdObjMenu;
    int IdObj;
}
@property (nonatomic) int IdObj;
@property (nonatomic) int IdObjMenu;
@property (nonatomic) int IdObjAlu;

@property (nonatomic, retain) NSString *urlWeb;

@property (strong, nonatomic) UIView* loadingView;
@property (strong, nonatomic) UILabel* lblPorc;

@property (strong,nonatomic) Singleton *Singleton;
@property (strong, nonatomic) IBOutlet UIWebView *WebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnShare;

@property (nonatomic) UIDocumentInteractionController *interactionController;

- (IBAction)btnShare:(id)sender;

-(IBAction)Zoom:(UIPinchGestureRecognizer *)recognizer;

-(void) Preloader;

-(void)getCalendario;


@end
