//
//  FormularioContatoViewController.m
//  ContatoIP67
//
//  Created by ios3401 on 26/03/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"

@implementation FormularioContatoViewController

-(id)init{
    
    self = [super init];
    
    if(self){
        self.contatos = [[NSMutableArray alloc]init];
        self.navigationItem.title = @"Cadastro";
        
        UIBarButtonItem *cancela = [[UIBarButtonItem alloc] initWithTitle:@"Cancela"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(escondeFormulario)];
        self.navigationItem.leftBarButtonItem = cancela;
        
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc] initWithTitle:@"Adiciona"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(criaContato)];
        self.navigationItem.rightBarButtonItem = adiciona;
        
    }    
    return self;     
}

-(void)escondeFormulario{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)criaContato{
    Contato *contato = [[Contato alloc]init];
    [self.contatos addObject:contato];
}

- (IBAction)novoContato:(id)sender {
    
    Contato *contato = [[Contato alloc]init];
    
    contato.nome = _nome.text;
    contato.telefone = _telefone.text;
    contato.email = _email.text;
    contato.endereco = _endereco.text;
    contato.site = _site.text;
    
    if ([_nome.text isEqualToString:@""]) {
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Atenção"
                                                        message:@"Digite o nome"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert1 show];
    
    }else if ([_telefone.text isEqualToString:@""]) {
    
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Atenção"
                                                        message:@"Digite o telefone"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert2 show];
    }else{
        
        for(NSString *contatos in self.contatos){
            
        }
        
        [self.contatos addObject:contato];
        NSLog(@"contato: %@",self.contatos);
        
        
    }
    
    
    [self.view endEditing:YES];

}


-(IBAction)proximoElemento:(UITextField *)textField{
    
    if( textField == self.nome){
        [self.telefone becomeFirstResponder];
    }else if( textField == self.telefone){
        [self.email becomeFirstResponder];
    }else if( textField == self.email){
        [self.endereco becomeFirstResponder];
    }else if( textField == self.endereco){
        [self.site becomeFirstResponder];
    }else {
        [self novoContato:nil];
    }
}


@end
