//
//  ListaContatosViewController.h
//  ContatoIP67
//
//  Created by ios3401 on 27/03/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListaContatosProtocol.h"

@interface ListaContatosViewController : UITableViewController<ListaContatosProtocol>
{
    NSMutableArray *_contatos;
}
- (void) setContatos: (NSMutableArray *) contatos;

@end
