//
//  ContatoCell.m
//  ContatoIP67
//
//  Created by ios3401 on 03/04/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import "ContatoCell.h"

@implementation ContatoCell

-(void)setContato:(Contato*)contato{
    
    self.nome.text = contato.nome;
    self.email.text = contato.email;
    self.twitter.text = contato.twitter;
    
    if(contato.foto){
        
        self.Image.image = contato.foto;
        
    }else{
        UIImage *user = [UIImage imageNamed:@"1365051050_User-01.png"];
        self.Image.image = user;
        
    }
    
    
}

@end
