//
//  MasInfo_root.m
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 10/03/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import "MasInfo_root.h"
#import "Singleton.h"
#import "MasInfo_Directorio.h"
#import "MasInfo_Proceso_Admision.h"
#import "MasInfo_Mapa_Ubicacion.h"
#import "MasInfo_Beneficios.h"
#import "MasInfo_Contacto.h"
#import "MasInfo_Mensaje.h"

@interface MasInfo_root ()

@end

@implementation MasInfo_root{
    NSArray *ArrMIR;
    NSArray *ArrMIR2;
}

@synthesize Singleton;

- (void)viewDidLoad {

    self.Singleton  = [Singleton sharedMySingleton];
    
    self.tblMIR.delegate = self;
    
    ArrMIR = [NSMutableArray arrayWithObjects:@"Directorio",@"Proceso de Admisión",@"Mapa de ubicación",@"Beneficios", nil];
    ArrMIR2 = [NSMutableArray arrayWithObjects:@"Contacto", nil];

    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    self.Singleton = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return [ArrMIR count];
    }else {
        return [ArrMIR2 count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableId;
    
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                    TableId = @"MasInfoCell_Directorio";
                    break;
            case 1:
                    TableId = @"MasInfoCell_Proceso_Admision";
                    break;
            case 2:
                    TableId = @"MasInfoCell_Mapa_Ubicacion";
                    break;
            case 3:
                    TableId = @"MasInfoCell_Beneficios";
                    break;
        }
    }else {
        switch (indexPath.row) {
            case 0:
                    TableId = @"MasInfoCell_Contacto";
                    break;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableId forIndexPath:indexPath];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableId];
    }
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
            case 1:
            case 2:
            case 3:
                cell.textLabel.text = [ArrMIR objectAtIndex:indexPath.row];
                break;
        }
    }else {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = [ArrMIR2 objectAtIndex:indexPath.row];
                break;
        }
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0){
        return @"MAS INFORMACIÓN";
    }else{
        return @"DESARROLLADOR";
    }
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *CellIdentifier;
    if (section == 0){
        CellIdentifier = @"SegundoMenuHeader";
    }else{
        CellIdentifier = @"SegundoMenuHeader_1";
    }
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //[headerView.layer setCornerRadius:5.0];
    
    return headerView;
    
}
*/

/*
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath{
    
    NSString *urlstring = [[NSString alloc] initWithFormat:@"http://platsource.mx/php/getBoletasLayout/%d/%@/%d/%d/",self.IdObjAlu,self.Singleton.Username,self.Singleton.IdUser, self.Singleton.IdEmp] ;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    [[UIApplication sharedApplication] openURL:[request URL]];
    
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *iPath = [self.tblMIR indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"MasInfo_Directorio"]){
        
        MasInfo_Directorio *mid = segue.destinationViewController;
        mid.title = [ArrMIR objectAtIndex:iPath.row];
        
    }
    
    if ([segue.identifier isEqualToString:@"MasInfo_Proceso_Admision"]){
        
        MasInfo_Directorio *mipa = segue.destinationViewController;
        mipa.title = [ArrMIR objectAtIndex:iPath.row];
        
    }

    if ([segue.identifier isEqualToString:@"MasInfo_Mapa_ubicacion"]){
        
        MasInfo_Directorio *mimu = segue.destinationViewController;
        mimu.title = [ArrMIR objectAtIndex:iPath.row];
        
    }

    if ([segue.identifier isEqualToString:@"MasInfo_Contacto"]){
        
        MasInfo_Contacto *mic = segue.destinationViewController;
        mic.title = [ArrMIR2 objectAtIndex:iPath.row];
        
    }
    
}


@end
