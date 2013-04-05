//
//  FormularioContatoViewController.m
//  ContatoIP67
//
//  Created by ios3401 on 26/03/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"
#import "TPKeyboardAvoidingScrollView.h"
#import <CoreLocation/CoreLocation.h>



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

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
        
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
            
        case 1 :
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        default:
            break;
    }
    [self presentViewController:picker animated:YES completion:nil];
}


-(IBAction)selecionaFoto:(id)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto do contato"
                                                                                     delegate:self
                                                                            cancelButtonTitle:@"Cancelar"
                                                                       destructiveButtonTitle:@"Tirar Foto"
                                                                            otherButtonTitles:@"Escolher da Bilioteca", nil];
        [sheet showInView:self.view];
        
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
        self.twitter.text = self.contato.twitter;
        self.facebook.text = self.contato.facebook;
        self.telefone.text = self.contato.telefone;
        
        if(self.contato.latitude){
            self.latitude.text = [self.contato.latitude stringValue];
            self.longitude.text = [self.contato.longitude stringValue];
        
            [self.mapacontato setCenterCoordinate:CLLocationCoordinate2DMake([self.contato.latitude floatValue], [self.contato.longitude floatValue])
                                         animated:YES];
            [self.mapacontato setZoomEnabled:YES];
            
                        
            [self.mapacontato setHidden:NO];
            [self.loading stopAnimating];
        }else{
            [self.mapacontato setHidden:YES];
         }
        
        if(self.contato.foto){
            [botaoFoto setImage:self.contato.foto forState:UIControlStateNormal];
        }
    }
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tecladoApareceu:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tecladoSumiu:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
}


-(void)viewDidUnload{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
}

-(void)tecladoApareceu:(NSNotification *)notification{
    NSLog(@"Teclado apareceu");
}

-(void)tecladoSumiu:(NSNotification *)notification{
    NSLog(@"Teclado sumiu");    
}

-(void) textFieldDidBegingEditing:(UITextField *)textField{
    self.campoAtual = textField;
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    self.campoAtual = nil;
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
    self.contato.twitter = _twitter.text;
    self.contato.facebook = _facebook.text;
    self.contato.latitude = [NSNumber numberWithFloat:[_latitude.text floatValue]];
    self.contato.longitude = [NSNumber numberWithFloat:[_longitude.text floatValue]];;
    
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
    }else if( textField == self.site){
        [self.twitter becomeFirstResponder];
    }else if( textField == self.twitter){
        [self.facebook becomeFirstResponder];
    }else {
        //[self novoContato:nil];
    }
}

-(IBAction)buscarCoordenadas:(id)sender{
    
    if( self.endereco ){
        [self.loading startAnimating];
        [self.localizador setHidden:YES];
        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
        [geocoder geocodeAddressString:self.endereco.text
                     completionHandler:^(NSArray *resultados, NSError *error) {
                         if(error == nil && [resultados count] > 0){
                             [self.loading stopAnimating];
                             [self.localizador setHidden:NO];
                             CLPlacemark *resultado = [resultados objectAtIndex:0];
                             CLLocationCoordinate2D coordenada = resultado.location.coordinate;
                         
                             self.latitude.text = [NSString stringWithFormat:@"%.5f",coordenada.latitude];
                             self.longitude.text = [NSString stringWithFormat:@"%.5f",coordenada.longitude];
                             
                             NSLog(@"%.5f",coordenada.latitude);
                             NSLog(@"%.5f",coordenada.longitude);
                             [self.mapacontato setCenterCoordinate:CLLocationCoordinate2DMake([self.contato.latitude floatValue], [self.contato.longitude floatValue])
                                                          animated:YES];
                             
                             //[self.mapacontato addAnnotation:self.contatos];

                             [self.mapacontato setHidden:NO];
                         }
                     }];
    
    }else{
        
    }
}


@end
