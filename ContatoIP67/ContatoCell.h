//
//  ContatoCell.h
//  ContatoIP67
//
//  Created by ios3401 on 03/04/13.
//  Copyright (c) 2013 br.com.caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"

@interface ContatoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *nome;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *twitter;

-(void)setContato:(Contato*)contato;

@end

