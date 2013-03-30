//
//  ListaContatosProtocol.h
//  ContatoIP67
//
//  Created by ios3401 on 29/03/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"
@protocol ListaContatosProtocol <NSObject>


-(void)contatoAtualizado:(Contato *)contato;
-(void)contatoAdicionado:(Contato *)contato;


@end
