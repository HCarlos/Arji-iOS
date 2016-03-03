//
//  SegundoMenu.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface SegundoMenu : UITableViewController{
    int IdObjAlu;
    Singleton *Singleton;
}

@property (nonatomic) int IdObjAlu;
@property (strong,nonatomic) Singleton *Singleton;

@property (strong, nonatomic) IBOutlet UITableView *tblView;

@end
