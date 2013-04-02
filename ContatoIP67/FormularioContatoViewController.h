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


@interface FormularioContatoViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(weak) id<ListaContatosProtocol> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;

@property (strong) NSMutableArray *contatos;

@property(strong) Contato *contato;

-(IBAction)selecionaFoto:(id)sender;
-(id)initWithContato:(Contato *) contato;


@property (weak, nonatomic) IBOutlet UIButton *botaoFoto;


@end
