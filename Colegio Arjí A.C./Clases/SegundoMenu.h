//
//  SegundoMenu.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface SegundoMenu : UITableViewController<UITableViewDelegate, UITableViewDataSource>{
    int IdObjAlu;
    Singleton *Singleton;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnRefresh;

@property (nonatomic) int IdObjAlu;
@property (strong,nonatomic) Singleton *Singleton;

@property (strong, nonatomic) IBOutlet UITableView *tblView;
- (IBAction)btnLogin:(id)sender;

- (void)enableDetailCell:(UITableViewCell *)cell tipoOption:(NSInteger ) tipoOption;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
