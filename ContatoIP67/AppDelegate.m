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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.contatos = [[NSMutableArray alloc]init];
    
    NSArray *userDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [userDirs objectAtIndex:0];
    
    self.arquivoContatos = [NSString stringWithFormat:@"%@/ArquivoContatos",documentDir];
    
    self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile:self.arquivoContatos];
    if(!self.contatos){
        self.contatos = [[NSMutableArray alloc]init];
    }
        
    ListaContatosViewController *lista = [[ListaContatosViewController alloc]init];
    
    [lista performSelector:@selector(setContatos:) withObject:self.contatos];

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

-(void) applicationDidEnterBackground:(UIApplication *)application{
    [NSKeyedArchiver archiveRootObject:self.contatos toFile:self.arquivoContatos];
}



@end
