//
//  UITableViewController+MasInfo_Token.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 06/04/17.
//  Copyright © 2017 Colegio Arji A.C. All rights reserved.
//

#import "MasInfo_Token.h"
#import "Singleton.h"

@implementation MasInfo_Token

@synthesize Singleton,lblVersion,lblToken, lblNoTransactions;

- (void)viewDidLoad {
    
    self.Singleton  = [Singleton sharedMySingleton];
    
    [lblToken setText:self.Singleton.tokenUser];
    [lblVersion setText:[[NSString alloc] initWithFormat:@"v.%@",self.Singleton.Version]];
    [lblNoTransactions setText:[[NSString alloc] initWithFormat:@"%ld",(long)self.Singleton.getAccess]];

    /*
    self.cell.layer.masksToBounds = true;
    self.layer.borderColor = UIColor( red: 153/255, green: 153/255, blue:0/255, alpha: 1.0 ).CGColor;
    self.layer.borderWidth = 2.0;
    */
    
   // [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    
    
    [super viewDidLoad];

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Force your tableview margins (this may be a bad idea)
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.cornerRadius = 15;
    cell.layer.masksToBounds = YES;
    cell.preservesSuperviewLayoutMargins = NO;
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }    
    
}


@end
