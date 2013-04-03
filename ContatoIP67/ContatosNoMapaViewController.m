//
//  ContatosNoMapaViewController.m
//  ContatoIP67
//
//  Created by ios3401 on 02/04/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import "ContatosNoMapaViewController.h"
#import <Mapkit/MKUserTrackingBarButtonItem.h>

@interface ContatosNoMapaViewController ()

@end

@implementation ContatosNoMapaViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        UIImage *imageTabItem = [UIImage imageNamed:@"mapa-contatos.png"];
        
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:imageTabItem tag:0];
        
        self.tabBarItem = tabItem;
        
        self.navigationItem.title = @"Localização";
        
    }
    return self;
}

-(void)viewDidLoad{
    MKUserTrackingBarButtonItem *botaoLocalizacao = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.leftBarButtonItem = botaoLocalizacao;
}

@end
