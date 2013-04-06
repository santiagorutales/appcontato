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
#import <Social/Social.h>
#import "ContatoCell.h"

@implementation ListaContatosViewController


@synthesize contexto;

-(id)init{
    self = [super init];
    
    if (self){
        
        UIImage *imageTabItem = [UIImage imageNamed:@"lista-contatos.png"];

        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Contatos" image:imageTabItem tag:0];
        
        self.tabBarItem = tabItem;
        
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ContatoCell"
                                               bundle:[NSBundle mainBundle]]
                               forCellReuseIdentifier:@"ContatoCell"];
    
    
    self.tableView.rowHeight = 56;
    //self.tableView.backgroundColor = [UIColor lightGrayColor];
    
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
                                                   otherButtonTitles:@"Ligar",@"Enviar Email",@"Visualizar Site",@"Abrir Mapa",@"Twittar",@"Post Facebook", nil];
        
        [opcoes showFromTabBar:self.tabBarController.tabBar];
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
            
        case 4:
            [self enviaTwitter];
            break;
            
        case 5:
            [self enviaFacebook];
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
-(void)enviaTwitter{
    
    SLComposeViewController *envia = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [envia setInitialText:[NSString stringWithFormat:@"#ip67caelum @dchohfi @%@",contatoSelecionado.twitter]];
    [self presentViewController:envia animated:YES completion:nil];
}

-(void)enviaFacebook{
    
    SLComposeViewController *envia = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];

    [envia setInitialText:[NSString stringWithFormat:@"%@",contatoSelecionado.facebook]];
    [self presentViewController:envia animated:YES completion:nil];
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


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
    
    Contato *contato = [self.contatos objectAtIndex:fromIndexPath.row];
    
    [self.contatos removeObject:contato];
    [self.contatos insertObject:contato atIndex:toIndexPath.row];
   
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
    
    
    
    
    static NSString *cellIdentifier = @"ContatoCell";
    
    ContatoCell *cell = (ContatoCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if(!cell){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                      reuseIdentifier:cellIdentifier];
//        
//    }
    Contato *contato = [self.contatos objectAtIndex:indexPath.row];
//    cell.textLabel.text = contato.nome;

    [cell setContato:contato];
    
    return cell;

}

-(void)exibeFormulario{
    
    [self setEditing:NO animated:YES];
    
    FormularioContatoViewController  *form = [[FormularioContatoViewController alloc]init];
    
    form.contatos = _contatos;
    form.contexto = self.contexto;
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
