//
//  MasInfo_root.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 10/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface MasInfo_root : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    Singleton *Singleton;
}

@property (strong,nonatomic) Singleton *Singleton;

@property (strong, nonatomic) IBOutlet UITableView *tblMIR;

@end
