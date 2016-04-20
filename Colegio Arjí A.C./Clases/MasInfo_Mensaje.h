//
//  MasInfo_Mensaje.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 18/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface MasInfo_Mensaje : UITableViewController<UITableViewDelegate, UITableViewDataSource, NSURLSessionDownloadDelegate,   UIToolbarDelegate, UIBarPositioningDelegate>{
    Singleton *Singleton;
    UIView* loadingView;
    UILabel* lblPorc;
    Byte Status;
    int IdMensaje;
}

@property (strong,nonatomic) Singleton *Singleton;
@property(nonatomic) Byte Status;
@property(nonatomic) int IdMensaje;
@property (strong, nonatomic) UIView* loadingView;
@property (strong, nonatomic) UILabel* lblPorc;
@property (strong, nonatomic) IBOutlet UITableView *tblMensajes;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Segment0;
- (IBAction)btnActionSegment:(id)sender;

- (IBAction)btnRefresh:(id)sender;

-(void)getMensajes;

@end
