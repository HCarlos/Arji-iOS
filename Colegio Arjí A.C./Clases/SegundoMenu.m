//
//  SegundoMenu.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import "SegundoMenu.h"
#import "TercerMenu.h"
#import "Calendarios.h"
#import "VerTareasCirculares.h"
#import "MasInfo_Mensaje.h"
#import "Singleton.h"
#import "Login.h"
#import <QuartzCore/QuartzCore.h>

@interface SegundoMenu ()

@end

@implementation SegundoMenu{
    NSArray *ArrObj;
    NSArray *ArrObj2;
    NSArray *ArrObj3;
}
@synthesize Singleton, IdObjAlu;

- (void)viewDidLoad {

    self.Singleton  = [Singleton sharedMySingleton];

    // self.tableView.layer.cornerRadius = 5.0f;
    // [self.tableView.layer setMasksToBounds:YES];
    
    switch (self.Singleton.Clave) {
        case 3:
            ArrObj = [NSMutableArray arrayWithObjects:@"CIRCULARES", nil];
            ArrObj2 = [NSMutableArray arrayWithObjects:@"MENSAJES", nil];
            self.IdObjAlu = self.Singleton.IdUser;
            self.title = self.Singleton.NombreCompletoUsuario;
            break;
        case 5:
            ArrObj = [NSMutableArray arrayWithObjects:@"TAREAS",@"CIRCULARES",@"BOLETAS", nil];
            ArrObj2 = [NSMutableArray arrayWithObjects:@"CALENDARIO", nil];
            ArrObj3 = [NSMutableArray arrayWithObjects:@"MENSAJES", nil];
            self.IdObjAlu = self.Singleton.IdUser;
            self.title = self.Singleton.NombreCompletoUsuario;
            break;
        case 6:
            ArrObj = [NSMutableArray arrayWithObjects:@"CIRCULARES", nil];
            ArrObj2 = [NSMutableArray arrayWithObjects:@"MENSAJES", nil];
            self.IdObjAlu = self.Singleton.IdUser;
            self.title = self.Singleton.NombreCompletoUsuario;
            break;
        case 7:
            ArrObj = [NSMutableArray arrayWithObjects:@"TAREAS",@"CIRCULARES",@"FACTURAS",@"PAGOS",@"BOLETAS", nil];
            ArrObj2 = [NSMutableArray arrayWithObjects:@"CALENDARIO", nil];
            ArrObj3 = [NSMutableArray arrayWithObjects:@"MENSAJES", nil];
            break;
        case 28:
        case 29:
            ArrObj = [NSMutableArray arrayWithObjects:@"TAREAS",@"CIRCULARES",@"BOLETAS", nil];
            ArrObj2 = [NSMutableArray arrayWithObjects:@"CALENDARIO", nil];
            ArrObj3 = [NSMutableArray arrayWithObjects:@"MENSAJES", nil];
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
    int nret = 1;
    if (self.Singleton.Clave == 3){
        nret = 2;
    }
    if (self.Singleton.Clave == 6){
        nret = 2;
    }
    if (self.Singleton.Clave == 5 || self.Singleton.Clave == 7 || self.Singleton.Clave == 28 || self.Singleton.Clave == 29){
        nret = 3;
    }
    
    return nret;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger nret = 1;

    if (self.Singleton.Clave == 3){
        if (section==0) {
            nret = [ArrObj count];
        }else{
            nret = [ArrObj2 count];
        }
    }
    
    if (self.Singleton.Clave == 6){
        if (section==0) {
            nret = [ArrObj count];
        }else{
            nret = [ArrObj2 count];
        }
    }

    if (self.Singleton.Clave == 5 || self.Singleton.Clave == 7 || self.Singleton.Clave == 28 || self.Singleton.Clave == 29){
        if (section==0) {
            nret = [ArrObj count];
        }else if(section==1) {
            nret = [ArrObj2 count];
        }else{
            nret = [ArrObj3 count];
        }
    }
    
    return nret;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SegundoMenuCell" forIndexPath:indexPath];

    static NSString *TableId;
    
    //NSIndexPath *path = [self.tableView indexPathForCell:cell];
    
    NSUInteger sectionNumber = indexPath.section;
    
    // NSLog(@"ID CEL: %ld",(long)sectionNumber);
    
    if (self.Singleton.Clave == 3){
        if (sectionNumber == 0){
            switch (indexPath.row) {
                case 0:
                    TableId = @"SegundoMenuCell";
                    break;
            }
        }else if (sectionNumber == 1){
            switch (indexPath.row) {
                case 0:
                    TableId = @"SegundoMenuCell_2";
                    
                    break;
            }
        }else{
            
        }
    }
    
    
    if (self.Singleton.Clave == 5 || self.Singleton.Clave == 28 || self.Singleton.Clave == 29){
        if (sectionNumber == 0){
            switch (indexPath.row) {
                case 0:
                case 1:
                    TableId = @"SegundoMenuCell";
                    break;
                case 2:
                    TableId = @"SegundoMenuCell_Boleta";
                    break;
            }
        }else if (sectionNumber == 1){
            switch (indexPath.row) {
                case 0:
                    TableId = @"SegundoMenuCell_1";
                    
                    break;
            }
        }else{
            switch (indexPath.row) {
                case 0:
                    TableId = @"SegundoMenuCell_2";
                    
                    break;
            }
            
        }
    }

    if (self.Singleton.Clave == 6){
        if (sectionNumber == 0){
            switch (indexPath.row) {
                case 0:
                    TableId = @"SegundoMenuCell";
                    break;
            }
        }else if (sectionNumber == 1){
            switch (indexPath.row) {
                case 0:
                    TableId = @"SegundoMenuCell_2";
                    
                    break;
            }
        }else{
            
        }
    }
    
    
    if (self.Singleton.Clave == 7){
        if (sectionNumber == 0){
            switch (indexPath.row) {
                case 0:
                case 1:
                case 2:
                case 3:
                    TableId = @"SegundoMenuCell";
                    break;
                case 4:
                    TableId = @"SegundoMenuCell_Boleta";
                    break;
            }
        }else if (sectionNumber == 1){
            switch (indexPath.row) {
                case 0:
                    TableId = @"SegundoMenuCell_1";
                    
                    break;
            }
        }else{
            switch (indexPath.row) {
                case 0:
                    TableId = @"SegundoMenuCell_2";
                    
                    break;
            }
            
        }
    }
    
    // NSLog(@"ID CEL: %ld",(long)indexPath.row);

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableId forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableId];
        // [cell.layer setCornerRadius:5.0];

    }
    
    // cell.textLabel.text = [ArrObj objectAtIndex:indexPath.row];

    if (self.Singleton.Clave == 3){
        if (sectionNumber == 0){
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = [ArrObj objectAtIndex:indexPath.row];
                    [self enableDetailCell:cell tipoOption:indexPath.row];
                    break;
            }
        }else if(sectionNumber == 1){
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = [ArrObj2 objectAtIndex:indexPath.row];
                    break;
            }
            
        }else{
            
        }
    }
    
    
    if (self.Singleton.Clave == 5 || self.Singleton.Clave == 28 || self.Singleton.Clave == 29 ){
        if (sectionNumber == 0){
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = [ArrObj objectAtIndex:indexPath.row];
                    [self enableDetailCell:cell tipoOption:indexPath.row];
                    break;
                case 1:
                    cell.textLabel.text = [ArrObj objectAtIndex:indexPath.row];
                    [self enableDetailCell:cell tipoOption:indexPath.row];
                    break;
                case 2:
                    cell.textLabel.text = [ArrObj objectAtIndex:indexPath.row];
                    cell.detailTextLabel.text = @"";
                    break;
                    break;
            }
        }else if(sectionNumber == 1){
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = [ArrObj2 objectAtIndex:indexPath.row];
                    break;
            }
            
        }else{
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = [ArrObj3 objectAtIndex:indexPath.row];
                    [self enableDetailCell:cell tipoOption:indexPath.row];
                    break;
            }
            
        }
    }

    if (self.Singleton.Clave == 6){
        if (sectionNumber == 0){
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = [ArrObj objectAtIndex:indexPath.row];
                    [self enableDetailCell:cell tipoOption:indexPath.row];
                    break;
            }
        }else if(sectionNumber == 1){
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = [ArrObj2 objectAtIndex:indexPath.row];
                    break;
            }
            
        }else{
            
        }
    }
    
    
    if (self.Singleton.Clave == 7){
        if (sectionNumber == 0){
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = [ArrObj objectAtIndex:indexPath.row];
                    [self enableDetailCell:cell tipoOption:indexPath.row];
                    break;
                case 1:
                    cell.textLabel.text = [ArrObj objectAtIndex:indexPath.row];
                    [self enableDetailCell:cell tipoOption:indexPath.row];
                    break;
                case 2:
                    cell.textLabel.text = [ArrObj objectAtIndex:indexPath.row];
                    cell.detailTextLabel.text = @"";
                    break;
                case 3:
                    cell.textLabel.text = [ArrObj objectAtIndex:indexPath.row];
                    cell.detailTextLabel.text = @"";
                    break;
                case 4:
                    cell.textLabel.text = [ArrObj objectAtIndex:indexPath.row];
                    cell.detailTextLabel.text = @"";
                    break;
            }
        }else if(sectionNumber == 1){
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = [ArrObj2 objectAtIndex:indexPath.row];
                    cell.detailTextLabel.text = @"";
                    break;
            }
            
        }else{
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = [ArrObj3 objectAtIndex:indexPath.row];
                    [self enableDetailCell:cell tipoOption:indexPath.row];
                    break;
            }
            
        }
    }
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // NSLog(@"Section: %ld",(long)section);
    
    NSString *secc;

    if (self.Singleton.Clave == 3){
        switch(section) {
            case 0:
                secc =  @"OPCIONES";
                break;
            case 1:
                secc =  @"NOTIFICACIONES";
                break;
        }
    }
    
    
    if (self.Singleton.Clave == 6){
        switch(section) {
            case 0:
                secc =  @"OPCIONES";
                break;
            case 1:
                secc =  @"NOTIFICACIONES";
                break;
        }
    }

    if (self.Singleton.Clave == 5 || self.Singleton.Clave == 7 || self.Singleton.Clave == 28 || self.Singleton.Clave == 29 ){
        switch(section) {
            case 0:
                secc =  @"OPCIONES";
                break;
            case 1:
                secc =  @"CALENDARIOS";
                break;
            case 2:
                secc =  @"NOTIFICACIONES";
                break;
        }
    }
    
    return secc; // @"OPCIONES";
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *CellIdentifier;
    
    if (self.Singleton.Clave == 3){
        if (section == 0){
            CellIdentifier = @"SegundoMenuHeader";
        }else if (section == 1){
            CellIdentifier = @"SegundoMenuHeader_2";
        }
    }
    
    if (self.Singleton.Clave == 6){
        if (section == 0){
            CellIdentifier = @"SegundoMenuHeader";
        }else if (section == 1){
            CellIdentifier = @"SegundoMenuHeader_2";
        }
    }

    if (self.Singleton.Clave == 5 || self.Singleton.Clave == 7 || self.Singleton.Clave == 28 || self.Singleton.Clave == 29){
        if (section == 0){
            CellIdentifier = @"SegundoMenuHeader";
        }else if (section == 1){
            CellIdentifier = @"SegundoMenuHeader_1";
        }else{
            CellIdentifier = @"SegundoMenuHeader_2";
        }
    }
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //[headerView.layer setCornerRadius:5.0];

    return headerView;
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath{

    NSString *urlstring = [[NSString alloc] initWithFormat:self.Singleton.urlBoletas,self.IdObjAlu,self.Singleton.Username,self.Singleton.IdUser, self.Singleton.IdEmp] ;
    NSLog(@"URL Calif: %@",urlstring);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [[UIApplication sharedApplication] openURL:[request URL]];

}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *iPath = [self.tblView indexPathForSelectedRow];

    if ( [segue.identifier isEqualToString:@"TTres"] || [segue.identifier isEqualToString:@"TTres_Alumnos"] || [segue.identifier isEqualToString:@"TTres_Profesores"] ){
        
        TercerMenu *tm = segue.destinationViewController;
        tm.title = [ArrObj objectAtIndex:iPath.row];
        tm.IdObjAlu =  self.IdObjAlu;
 
        if (self.Singleton.Clave == 3){
            tm.IdObjMenu = 1;
        }
        
        if (self.Singleton.Clave == 6){
            tm.IdObjMenu = 1;
        }
        
        if (self.Singleton.Clave == 5 || self.Singleton.Clave == 7 || self.Singleton.Clave == 28 || self.Singleton.Clave == 29){
            tm.IdObjMenu = (int)iPath.row;
        }
        
    }

    if ( [segue.identifier isEqualToString:@"QQuatro"] || [segue.identifier isEqualToString:@"QQuatro_Alumnos"] || [segue.identifier isEqualToString:@"QQuatro_Profesores"] ){
        
        Calendarios *cld = segue.destinationViewController;
        cld.title = [ArrObj2 objectAtIndex:0];
        cld.IdObjAlu =  self.IdObjAlu;
        cld.IdObjMenu = (int)iPath.row;
        
    }

    if ( [segue.identifier isEqualToString:@"CCinco"] || [segue.identifier isEqualToString:@"CCinco_Alumnos"] || [segue.identifier isEqualToString:@"CCinco_Profesores"]){
        
        MasInfo_Mensaje *mim = segue.destinationViewController;
        mim.title = [ArrObj3 objectAtIndex:0];
        //mim.IdObjAlu =  self.IdObjAlu;
        // mim.IdObjMenu = (int)iPath.row;
        
    }

    if ( [segue.identifier isEqualToString:@"GoToLoginFromAlu"] ){
        
        [self.Singleton deleteUser];
        Login *lo = segue.destinationViewController;
        [lo.navigationItem setHidesBackButton:YES];
        [lo.txtUsername setText:@""];
        [lo.txtPassword setText:@""];
        
    }
    
    if ( [segue.identifier isEqualToString:@"GoToLoginFromProf"] ){
        
        [self.Singleton deleteUser];
        Login *lo = segue.destinationViewController;
        [lo.navigationItem setHidesBackButton:YES];
        [lo.txtUsername setText:@""];
        [lo.txtPassword setText:@""];
        
    }

    
    
}


- (void)enableDetailCell:(UITableViewCell *)cell  tipoOption:(NSInteger ) tipoOption{
    
    cell.detailTextLabel.text = @"";
    switch (tipoOption) {
        case 0:
            if (self.Singleton.totalNoLeidasTareas > 0){
                cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d  ", self.Singleton.totalNoLeidasTareas];
            }
            break;
        case 1:
            if (self.Singleton.totalNoLeidasCirculaes > 0){
                cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d  ", self.Singleton.totalNoLeidasCirculaes];
            }
            break;
        default:
            cell.detailTextLabel.hidden = YES;
            break;
    }
    cell.detailTextLabel.backgroundColor = [UIColor redColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.clipsToBounds = YES;
    cell.detailTextLabel.layer.cornerRadius = 7.5;

    NSString *badge = [[NSString alloc] initWithFormat:@"%d  ", self.Singleton.totalNoLeidasBadge];
    
    UITabBarController *tabController =(UITabBarController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    [[tabController.viewControllers objectAtIndex:0] tabBarItem].badgeValue = badge;

    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: self.Singleton.totalNoLeidasBadge];
    
    
}


- (IBAction)btnLogin:(id)sender {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Cerrar Sesión"
                                  message:@"Desea cerrar la sesión actual?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Si, por favor"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    if (self.Singleton.Clave == 5){
                                    [self performSegueWithIdentifier:@"GoToLoginFromAlu" sender:nil];
                                    }

                                    if (self.Singleton.Clave == 6){
                                        [self performSegueWithIdentifier:@"GoToLoginFromProf" sender:nil];
                                    }
                                   
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, gracias"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   //Handel no, thanks button
                                   
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
