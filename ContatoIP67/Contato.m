//
//  Contato.m
//  ContatoIP67
//
//  Created by ios3401 on 26/03/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_nome forKey:@"nome"];
    [aCoder encodeObject:_telefone forKey:@"telefone"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_endereco forKey:@"endereco"];
    [aCoder encodeObject:_site forKey:@"site"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    
    if(self){
        [self setNome:[aDecoder decodeObjectForKey:@"nome"]];
        [self setTelefone:[aDecoder decodeObjectForKey:@"telefone"]];
        [self setEmail:[aDecoder decodeObjectForKey:@"email"]];
        [self setEndereco:[aDecoder decodeObjectForKey:@"endereco"]];
        [self setSite:[aDecoder decodeObjectForKey:@"site"]];
    }
    return self;

}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"%@<%@>",_nome,_email];
}




@end
