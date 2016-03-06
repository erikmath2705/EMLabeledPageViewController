//
//  EMNavigationView.m
//  EMLabeledPageViewController
//
//  Created by Erik Mathisen on 06/03/16.
//  Copyright © 2016 Erik Mathisen. All rights reserved.
//

#import "EMNavigationView.h"

@implementation EMNavigationView

-(id)initWithLeftTitle:(NSString *)leftTitle centerTitle:(NSString *)centerTitle rightTitle:(NSString *)rightTitle
{
    if (self = [super init])
    {
        self.leftLabel = [UILabel new];
        self.centerLabel = [UILabel new];
        self.rightLabel = [UILabel new];
        
        [self.leftLabel setText:leftTitle];
        [self.centerLabel setText:centerTitle];
        [self.rightLabel setText:rightTitle];
        
        [self.leftLabel setTextColor:[UIColor whiteColor]];
        [self.centerLabel setTextColor:[UIColor whiteColor]];
        [self.rightLabel setTextColor:[UIColor whiteColor]];
        
        CGFloat fontSize = 15;
        [self.leftLabel setFont:[UIFont systemFontOfSize:fontSize weight:UIFontWeightLight]];
        [self.centerLabel setFont:[UIFont systemFontOfSize:fontSize weight:UIFontWeightBold]];
        [self.rightLabel setFont:[UIFont systemFontOfSize:fontSize weight:UIFontWeightLight]];
        
        [self addSubview:self.leftLabel];
        [self addSubview:self.centerLabel];
        [self addSubview:self.rightLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat controlWidth = self.bounds.size.width;
    CGSize leftLabelSize = [self.leftLabel.text sizeWithAttributes:@{NSFontAttributeName : self.leftLabel.font}];
    CGSize centerLabelSize = [self.centerLabel.text sizeWithAttributes:@{NSFontAttributeName : self.centerLabel.font}];
    CGSize rightLabelSize = [self.rightLabel.text sizeWithAttributes:@{NSFontAttributeName : self.rightLabel.font}];
    
    CGFloat leftX = 0.0f;
    CGFloat centerX = (controlWidth / 2) - (centerLabelSize.width / 2);
    CGFloat rightX = controlWidth - rightLabelSize.width;
    
    self.leftLabel.frame = CGRectMake(leftX, 0, leftLabelSize.width, leftLabelSize.height);
    self.centerLabel.frame = CGRectMake(centerX, 0, centerLabelSize.width, centerLabelSize.height);
    self.rightLabel.frame = CGRectMake(rightX, 0, rightLabelSize.width, rightLabelSize.height);
    
    [self setNeedsDisplay];
}

-(void)setBoldIndex:(NSInteger)boldLabelIndex
{
    CGFloat fontSize = 15;
    switch (boldLabelIndex) {
        case 0:
        {
            [self.leftLabel setFont:[UIFont systemFontOfSize:fontSize weight:UIFontWeightBold]];
            [self.centerLabel setFont:[UIFont systemFontOfSize:fontSize weight:UIFontWeightLight]];
            [self.rightLabel setFont:[UIFont systemFontOfSize:fontSize weight:UIFontWeightLight]];
        }
            break;
        case 1:
        {
            [self.leftLabel setFont:[UIFont systemFontOfSize:fontSize weight:UIFontWeightLight]];
            [self.centerLabel setFont:[UIFont systemFontOfSize:fontSize weight:UIFontWeightBold]];
            [self.rightLabel setFont:[UIFont systemFontOfSize:fontSize weight:UIFontWeightLight]];
        }
            break;
        case 2:
        {
            [self.leftLabel setFont:[UIFont systemFontOfSize:fontSize weight:UIFontWeightLight]];
            [self.centerLabel setFont:[UIFont systemFontOfSize:fontSize weight:UIFontWeightLight]];
            [self.rightLabel setFont:[UIFont systemFontOfSize:fontSize weight:UIFontWeightBold]];
        }
            break;
        default:
            break;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
