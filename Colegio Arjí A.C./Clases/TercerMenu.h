//
//  TercerMenu.h
//  Colegio Arjí A.C.
//
//  Created by Carlos Hidalgo on 24/02/16.
//  Copyright © 2016 Colegio Arji A.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
#import "VerTareasCirculares.h"

@interface TercerMenu : UITableViewController<UITableViewDelegate, UITableViewDataSource, UIToolbarDelegate, UIBarPositioningDelegate>{
    int IdObjAlu;
    int IdObjMenu;
    Byte Status;
}

@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Indicator;
@property (weak, nonatomic) IBOutlet UINavigationItem *Nav0;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Bar0;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Segment0;
@property(nonatomic) int IdObjAlu;
@property(nonatomic) int IdObjMenu;
@property(nonatomic) Byte Status;
- (IBAction)btnActionSegment:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnRefresh;
- (IBAction)btnRefresh:(id)sender;

@property (strong,nonatomic) Singleton *Singleton;

-(void)getTercerMenu;

-(void)sayMessageTable:(NSInteger) Indice Celda:(UITableViewCell*) cell;

-(void)sayTareaTable:(NSInteger) Indice Celda:(UITableViewCell*) cell;

-(NSString *)sayHeaderTable:(NSString *) Label Param:(NSInteger) param;

@end
