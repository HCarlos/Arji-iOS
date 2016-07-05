//
//  VerObjeto.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface VerTareasCirculares : UIViewController<NSURLSessionDownloadDelegate, UIWebViewDelegate, UIDocumentInteractionControllerDelegate>{
    int IdObjAlu;
    int IdObjMenu;
    int IdObj;
    int IdTarea;
    int IdComMensaje;
    UIView* loadingView;
    UILabel* lblPorc;
    NSString *urlWeb;
}
@property (nonatomic) int IdObj;
@property (nonatomic) int IdObjMenu;
@property (nonatomic) int IdObjAlu;
@property (nonatomic) int IdTarea;
@property (nonatomic) int IdComMensaje;

@property (nonatomic, retain) NSString *urlWeb;

@property (strong, nonatomic) IBOutlet UIWebView *WebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnShare;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnRefresh;

@property (strong, nonatomic) UIView* loadingView;
@property (strong, nonatomic) UILabel* lblPorc;

@property (strong,nonatomic) Singleton *Singleton;

@property (nonatomic) UIDocumentInteractionController *interactionController;

-(IBAction)Zoom:(UIPinchGestureRecognizer *)recognizer;
- (IBAction)btnRefresh:(id)sender;

-(void)getHTMLVal;

-(void)getPDF;

-(void)Reload;

@end

