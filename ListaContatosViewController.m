//
//  ListaContatosViewController.m
//  ContatoIP67
//
//  Created by ios3401 on 27/03/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"
#import "Contato.h"


@implementation ListaContatosViewController

-(id)init{
    self = [super init];
    
    if (self){
        
        self.contatos = [[NSMutableArray alloc]init];
        
        self.navigationItem.title = @"Contatos";
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                               target:self
                                                                                               action:@selector(exibeFormulario)];
        
        self.navigationItem.rightBarButtonItem = botaoExibirFormulario;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

-(void) viewDidLoad{
    
    [super viewDidLoad];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    
    [self.tableView addGestureRecognizer:longPress];
    
}

-(void)exibeMaisAcoes:(UIGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:point];
        Contato *contato = self.contatos[index.row];
        
        contatoSelecionado = contato;
        
        UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:contato.nome
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancelar"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"Ligar",@"Enviar Email",@"Visualizar Site",@"Abrir Mapa", nil];
        
        [opcoes showInView:self.view];
    }
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
            
        case 1:
            [self enviarEmail];
            break;
            
        case 2:
            [self abrirSite];
            break;
            
        case 3:
            [self mostraMapa];
            break;
            
        default:
            break;
    }
    
}

-(void)abrirAplicativoComURL:(NSString *)url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void)ligar{
    UIDevice *device = [UIDevice currentDevice];
    
    if([device.model isEqualToString:@"iPhone"]){
        NSString *numero = [NSString stringWithFormat:@"telprompt:%@",contatoSelecionado.telefone];
        [self abrirAplicativoComURL:numero];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Impossivel fazer ligação"
                                    message:@"Seu dispositivo não é um iPhone"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil]show];
        
    }
    
}

-(void)abrirSite{
    NSString *url = contatoSelecionado.site;
    [self abrirAplicativoComURL:url];
}

-(void)mostraMapa{
    NSString *url = [[NSString stringWithFormat:@"http://maps.apple.com/maps?q=%@", contatoSelecionado.endereco]
                   stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirAplicativoComURL:url];
    
}

-(void)enviarEmail{
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *enviadorEmail = [[MFMailComposeViewController alloc]init];
        enviadorEmail.mailComposeDelegate = self;
        
        [enviadorEmail setToRecipients:[NSArray arrayWithObject:contatoSelecionado.email]];
        [enviadorEmail setSubject:@"Contatos"];
        
        [self presentViewController:enviadorEmail animated:YES completion:nil];
        
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ops"
                                                        message:@"Nao e possivel enviar email"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.contatos removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Contato *contato = [self.contatos objectAtIndex:indexPath.row];
    
    FormularioContatoViewController *form = [[FormularioContatoViewController alloc] initWithContato:contato];
    
    form.delegate = self;
    form.contatos = self.contatos;
    
    
    [self.navigationController pushViewController:form animated:YES];
    
    NSLog(@"nome: %@", contato.nome);
    
}


-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contatos count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        
    }
    Contato *contato = [self.contatos objectAtIndex:indexPath.row];
    cell.textLabel.text = contato.nome;
    
    return cell;
}

-(void)exibeFormulario{
    
    [self setEditing:NO animated:YES];
    
    FormularioContatoViewController  *form = [[FormularioContatoViewController alloc]init];
    
    form.contatos = self.contatos;
    form.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:form];
    
    [self presentViewController:nav animated:YES completion:nil];
     
}


-(void)contatoAtualizado:(Contato *)contato{
    NSLog(@"atualizado: %d",[self.contatos indexOfObject:contato]);
};

-(void)contatoAdicionado:(Contato *)contato{
    NSLog(@"adicionado: %d",[self.contatos indexOfObject:contato]);
};


- (void) setContatos: (NSMutableArray *) contatos {
    _contatos = contatos;
}
- (NSMutableArray *) contatos {
    return _contatos;
}
@end
