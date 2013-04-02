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

@synthesize botaoFoto;


-(id)init{
    
    self = [super init];
    
    if(self){
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

-(void)atualizaContato{
    Contato *contatoAtualiado = [self pegaDadosDoFormulario];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if(self.delegate){
        [self.delegate contatoAtualizado:contatoAtualiado];
    }
}


-(IBAction)selecionaFoto:(id)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
    }else{
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [botaoFoto setImage:imagemSelecionada forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(id)initWithContato:(Contato *)contato{
    self = [super init];
    if(self){
        self.contato = contato;
        
        UIBarButtonItem *confirmar = [[UIBarButtonItem alloc] initWithTitle:@"Confirmar"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(atualizaContato)];
        self.navigationItem.rightBarButtonItem = confirmar;
    }
    return self;
}


-(void)viewDidLoad{
    
    if(self.contato){
        self.nome.text = self.contato.nome;
        self.endereco.text = self.contato.endereco;
        self.email.text = self.contato.email;
        self.site.text = self.contato.site;
        self.telefone.text = self.contato.telefone;
        
        if(self.contato.foto){
            [botaoFoto setImage:self.contato.foto forState:UIControlStateNormal];
        }
    }
    
}
-(void)escondeFormulario{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)criaContato{

    
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
        
        Contato *novoContato = [self pegaDadosDoFormulario];
         
        [self.contatos addObject:novoContato];
        
        NSLog(@"cpontato:%d",[self.contatos count]);
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [self.view endEditing:YES];
        
        if(self.delegate){
            [self.delegate contatoAdicionado:novoContato];
        }
        
    }
    

}

-(Contato *)pegaDadosDoFormulario{
    
    if(!self.contato){
        self.contato = [[Contato alloc]init];
    }
    self.contato.nome = _nome.text;
    self.contato.telefone = _telefone.text;
    self.contato.email = _email.text;
    self.contato.endereco = _endereco.text;
    self.contato.site = _site.text;
    
    if(botaoFoto.imageView.image){
        self.contato.foto = botaoFoto.imageView.image;
    }
    
    return self.contato;
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
        //[self novoContato:nil];
    }
}


@end
