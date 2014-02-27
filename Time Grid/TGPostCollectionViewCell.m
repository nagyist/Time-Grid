//
//  TGPostCollectionViewCell.m
//  Time Grid
//
//  Created by Jerome Thomere on 2/26/14.
//  Copyright (c) 2014 Jerome Thomere. All rights reserved.
//

#import "TGPostCollectionViewCell.h"

@implementation TGPostCollectionViewCell

-(void) setMessage:(NSString *)message {
    self.statusLabel.text = message;
}


@end
