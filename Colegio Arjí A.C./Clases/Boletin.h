//
//  Boletin.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 08/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface Boletin : UIViewController<NSURLSessionDownloadDelegate, UIWebViewDelegate, UIDocumentInteractionControllerDelegate>{
    UIView* loadingView;
    UILabel* lblPorc;
    NSString *urlWeb;
}
@property (nonatomic, retain) NSString *urlWeb;

@property (strong, nonatomic) IBOutlet UIWebView *WebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnShare;

@property (strong, nonatomic) UIView* loadingView;
@property (strong, nonatomic) UILabel* lblPorc;

@property (strong,nonatomic) Singleton *Singleton;

@property (nonatomic) UIDocumentInteractionController *interactionController;

- (IBAction)btnRefresh:(id)sender;

- (IBAction)btnShare:(id)sender;

-(IBAction)Zoom:(UIPinchGestureRecognizer *)recognizer;

-(void) Preloader;

-(void)getURLBoletin;
-(void)getPDF;

@end
