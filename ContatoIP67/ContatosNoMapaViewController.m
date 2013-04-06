//
//  ContatosNoMapaViewController.m
//  ContatoIP67
//
//  Created by ios3401 on 02/04/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import "ContatosNoMapaViewController.h"
#import <Mapkit/MKUserTrackingBarButtonItem.h>
#import "Contato.h"

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

-(void)viewDidAppear:(BOOL)animated{
    

    [self.mapa addAnnotations:self.contatos];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self.mapa addAnnotations:self.contatos];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    
    static NSString *identifier = @"pino";
    
    MKPinAnnotationView *pino = (MKPinAnnotationView *)[self.mapa dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if(!pino){
        pino = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
    }else{
        pino.annotation =annotation;
    }
    
    Contato *contato = (Contato *) annotation;
    
    pino.pinColor = MKPinAnnotationColorRed;
    pino.canShowCallout = YES;

    
    if(contato.foto){;
        UIImageView *imagemContato = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        imagemContato.image = contato.foto;
        pino.leftCalloutAccessoryView = imagemContato;
    }
    return pino;
    
}
@end
