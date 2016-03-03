//
//  SegundoMenu.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import "SegundoMenu.h"
#import "TercerMenu.h"
#import "VerTareasCirculares.h"
#import "Singleton.h"

@interface SegundoMenu ()

@end

@implementation SegundoMenu{
    NSMutableArray *ArrObj;
}
@synthesize Singleton, IdObjAlu;

- (void)viewDidLoad {

    self.Singleton  = [Singleton sharedMySingleton];
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    
    switch (self.Singleton.Clave) {
        case 7:
            ArrObj = [NSMutableArray arrayWithObjects:@"TAREAS",@"CIRCULARES",@"FACTURAS",@"PAGOS",@"BOLETAS", nil];
            break;
            
        default:
            break;
    }
    
    

    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    self.Singleton = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ArrObj count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *TableId;
    
    switch (indexPath.row) {
        case 0:
        case 1:
        case 2:
        case 3:
            TableId = @"SegundoMenuCell";
            break;
        default:
            TableId = @"SegundoMenuCell_Boleta";
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableId forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableId];
    }
    
    cell.textLabel.text = [ArrObj objectAtIndex:indexPath.row];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"OPCIONES";
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *CellIdentifier = @"SegundoMenuHeader";
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return headerView;
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath{

    NSString *urlstring = [[NSString alloc] initWithFormat:@"http://platsource.mx/php/getBoletasLayout/%d/%@/%d/%d/",self.IdObjAlu,self.Singleton.Username,self.Singleton.IdUser, self.Singleton.IdEmp] ;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [[UIApplication sharedApplication] openURL:[request URL]];

}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"TTres"]){
        
        NSIndexPath *iPath = [self.tblView indexPathForSelectedRow];
        TercerMenu *tm = segue.destinationViewController;
        tm.title = [ArrObj objectAtIndex:iPath.row];
        tm.IdObjAlu =  self.IdObjAlu;
        tm.IdObjMenu = (int)iPath.row;
         
    }

}


@end
