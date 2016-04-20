//
//  PrimerMenu.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface PrimerMenu : UITableViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Indicator;
@property (strong,nonatomic) Singleton *Singleton;
- (IBAction)btnCloseSession:(id)sender;

-(void)getHijos;

@end
