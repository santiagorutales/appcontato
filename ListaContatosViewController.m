//
//  ListaContatosViewController.m
//  ContatoIP67
//
//  Created by ios3401 on 27/03/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"

@implementation ListaContatosViewController

-(id)init{
    self = [super init];
    
    if (self){
        
        self.navigationItem.title = @"Contatos";
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                               target:self
                                                                                               action:@selector(exibeFormulario)];
        
        self.navigationItem.rightBarButtonItem = botaoExibirFormulario;
    }
    return self;
}


-(void)exibeFormulario{

    FormularioContatoViewController  *form = [[FormularioContatoViewController alloc]init];
    
    [self presentViewController:form animated:YES completion:nil];
}
@end
