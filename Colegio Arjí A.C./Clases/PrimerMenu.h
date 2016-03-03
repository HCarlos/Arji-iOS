//
//  PrimerMenu.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface PrimerMenu : UITableViewController<UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Indicator;
@property (strong,nonatomic) Singleton *Singleton;

-(void)getHijos;

@end
