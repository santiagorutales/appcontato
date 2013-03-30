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
