//
//  UITableViewController+MasInfo_Token.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 06/04/17.
//  Copyright © 2017 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface MasInfo_Token: UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) Singleton *Singleton;
@property (weak, nonatomic) IBOutlet UITextView *lblToken;
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;
@property (weak, nonatomic) IBOutlet UILabel *lblNoTransactions;

@end
