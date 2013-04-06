//
//  Contato.m
//  ContatoIP67
//
//  Created by ios3401 on 26/03/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

@dynamic nome, telefone,email,endereco,site,twitter,facebook,latitude,longitude;
@synthesize foto;


//
//-(void)encodeWithCoder:(NSCoder *)aCoder {
//    
//    [aCoder encodeObject:_nome forKey:@"nome"];
//    [aCoder encodeObject:_telefone forKey:@"telefone"];
//    [aCoder encodeObject:_email forKey:@"email"];
//    [aCoder encodeObject:_endereco forKey:@"endereco"];
//    [aCoder encodeObject:_site forKey:@"site"];
//    [aCoder encodeObject:_twitter forKey:@"twitter"];
//    [aCoder encodeObject:_facebook forKey:@"facebook"];
//    [aCoder encodeObject:_foto forKey:@"foto"];
//    [aCoder encodeObject:_latitude forKey:@"latitude"];
//    [aCoder encodeObject:_longitude forKey:@"longitude"];
//    
//}
//
//-(id)initWithCoder:(NSCoder *)aDecoder{
//    self = [super init];
//    
//    if(self){
//        [self setNome:[aDecoder decodeObjectForKey:@"nome"]];
//        [self setTelefone:[aDecoder decodeObjectForKey:@"telefone"]];
//        [self setEmail:[aDecoder decodeObjectForKey:@"email"]];
//        [self setEndereco:[aDecoder decodeObjectForKey:@"endereco"]];
//        [self setSite:[aDecoder decodeObjectForKey:@"site"]];
//        [self setTwitter:[aDecoder decodeObjectForKey:@"twitter"]];
//        [self setFacebook:[aDecoder decodeObjectForKey:@"facebook"]];
//        [self setFoto:[aDecoder decodeObjectForKey:@"foto"]];
//        [self setLatitude:[aDecoder decodeObjectForKey:@"latitude"]];
//        [self setLongitude:[aDecoder decodeObjectForKey:@"longitude"]];
//    }
//    return self;
//
//}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"%@<%@>",self.nome,self.email];
}


-(CLLocationCoordinate2D)coordinate{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

-(NSString *)title{
    return self.nome;
}
-(NSString *)subtitle{
    return self.email;
}


@end
