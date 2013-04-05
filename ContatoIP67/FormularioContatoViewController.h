//
//  FormularioContatoViewController.h
//  ContatoIP67
//
//  Created by ios3401 on 26/03/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "ListaContatosProtocol.h"
#import <MapKit/MapKit.h>


@interface FormularioContatoViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(weak) id<ListaContatosProtocol> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;
@property (weak, nonatomic) IBOutlet UITextField *twitter;
@property (weak, nonatomic) IBOutlet UITextField *facebook;

@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;

@property(weak) UITextField *campoAtual;


@property (weak,nonatomic) IBOutlet UIButton *localizador;
@property (weak,nonatomic) IBOutlet MKMapView *mapacontato;

@property (nonatomic,weak) IBOutlet UIActivityIndicatorView *loading;

@property (strong) NSMutableArray *contatos;

@property(strong) Contato *contato;

-(IBAction)selecionaFoto:(id)sender;
-(IBAction)buscarCoordenadas:(id)sender;

-(id)initWithContato:(Contato *) contato;


@property (weak, nonatomic) IBOutlet UIButton *botaoFoto;


@end
