//
//  TGPostCollectionViewCell.h
//  Time Grid
//
//  Created by Jerome Thomere on 2/26/14.
//  Copyright (c) 2014 Jerome Thomere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGPostCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

-(void) setMessage:(NSString *)message;

@end
