//
//  AppDelegate.m
//  ContatoIP67
//
//  Created by ios3401 on 26/03/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import "AppDelegate.h"
#import "FormularioContatoViewController.h"
#import "ListaContatosViewController.h"
#import "ContatosNoMapaViewController.h"



@implementation AppDelegate


@synthesize contexto = _contexto;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.contatos = [[NSMutableArray alloc]init];
    
    
    
    //NSArray *userDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documentDir = [userDirs objectAtIndex:0];
    
    //self.arquivoContatos = [NSString stringWithFormat:@"%@/ArquivoContatos",documentDir];
    
    //self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile:self.arquivoContatos];
    //if(!self.contatos){
    //    self.contatos = [[NSMutableArray alloc]init];
    //}
    
    [self inserirDados];
    [self buscarContatos];
        
    ListaContatosViewController *lista = [[ListaContatosViewController alloc]init];
    
    [lista performSelector:@selector(setContatos:) withObject:self.contatos];
    [lista performSelector:@selector(setContexto:) withObject:self.contexto];

    UINavigationController *nav = [[UINavigationController alloc]
                                   initWithRootViewController:lista];

    ContatosNoMapaViewController *contatosMapa = [[ContatosNoMapaViewController alloc]init];
    contatosMapa.contatos = self.contatos;
    
    
    
    UINavigationController *mapaNavigation = [[UINavigationController alloc]initWithRootViewController:contatosMapa];
    
    UITabBarController *tabBarController = [[UITabBarController alloc]init];

    tabBarController.viewControllers = @[nav, mapaNavigation];
    
    self.window.rootViewController = tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


-(void)salvaContexto{
    NSError *error;
    if( ![self.contexto save:&error]){
        
        NSDictionary *informacoes = [error userInfo];
        NSArray *multiplosErros = [informacoes objectForKey:NSDetailedErrorsKey];
        
        if(multiplosErros){
            for(NSError *erro in multiplosErros){
                NSLog(@"Ocorreu um problema: %@", [erro userInfo]);
            }
        }else{
            NSLog(@"Ocorreu um problema %@",informacoes);
        }
    }
}

-(void) inserirDados{
    NSUserDefaults *configuracoes = [NSUserDefaults standardUserDefaults];
    BOOL dadosInseridos = [configuracoes boolForKey:@"dados_inseridos"];
    if(!dadosInseridos){
        Contato *caelumSP = [NSEntityDescription insertNewObjectForEntityForName:@"Contato"
                                                          inManagedObjectContext:self.contexto];
        caelumSP.nome = @"Caelum Unidade Sao Paulo";
        caelumSP.email = @"contato@caelum.com.br";
        caelumSP.endereco = @"Sao Paulo , SP, Rua Vergueiro, 3184";
        caelumSP.telefone = @"1155712751";
        caelumSP.site = @"http://www.caelum.com.br";
        caelumSP.latitude = [NSNumber numberWithDouble:-23.5883034];
        caelumSP.latitude = [NSNumber numberWithDouble:-46.632369];
        
        [self salvaContexto];
        [configuracoes setBool:TRUE forKey:@"dados_inseridos"];
        [configuracoes synchronize];
    }
}
-(void) applicationDidEnterBackground:(UIApplication *)application{
    
    [self salvaContexto];
    //[NSKeyedArchiver archiveRootObject:self.contatos toFile:self.arquivoContatos];
}

-(NSURL*)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory
                                                  inDomains:NSUserDomainMask] lastObject];
    
}
-(NSManagedObjectModel *)managedObjectModel{
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Modelo_Contatos"
                                              withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    
    return managedObjectModel;
}

-(NSPersistentStoreCoordinator*)coordinator{
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *pastaDocuments = [self applicationDocumentsDirectory];
    NSURL *localBancoDeDados = [pastaDocuments URLByAppendingPathComponent:@"Contatos.sqlite"];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:localBancoDeDados
                                    options:nil
                                      error:nil];
    return coordinator;
}

-(NSManagedObjectContext *)contexto{
    if(_contexto != nil){
        return _contexto;
    }
    NSPersistentStoreCoordinator *coordinator = [self coordinator];
    
    _contexto = [[NSManagedObjectContext alloc]init];
    
    [self.contexto setPersistentStoreCoordinator:coordinator];
    return _contexto;
}

-(void)buscarContatos{
    NSFetchRequest *buscaContatos = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    NSSortDescriptor *ordenarPorNome = [NSSortDescriptor sortDescriptorWithKey:@"nome"
                                                                     ascending:YES];
    [buscaContatos setSortDescriptors:[NSArray arrayWithObject:ordenarPorNome]];
    
    NSArray *contatosImutaveis = [self.contexto executeFetchRequest:buscaContatos error:nil];
    
    self.contatos = [contatosImutaveis mutableCopy];
    

}
@end
