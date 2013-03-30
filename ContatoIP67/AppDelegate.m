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
    
    self.window.rootViewController = nav;
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void) applicationDidEnterBackground:(UIApplication *)application{
    [NSKeyedArchiver archiveRootObject:self.contatos toFile:self.arquivoContatos];
}



@end
