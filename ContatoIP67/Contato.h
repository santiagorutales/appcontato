//
//  Contato.h
//  ContatoIP67
//
//  Created by ios3401 on 26/03/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>


//@interface Contato : NSObject<NSCoding,MKAnnotation>

@interface Contato : NSManagedObject<MKAnnotation>


@property(strong) NSString *nome;
@property(strong) NSString *telefone;
@property(strong) NSString *email;
@property(strong) NSString *endereco;
@property(strong) NSString *site;
@property(strong) NSString *twitter;
@property(strong) NSString *facebook;
@property(strong) NSNumber *latitude;
@property(strong) NSNumber *longitude;

@property(strong) UIImage *foto;

@end
