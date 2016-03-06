//
//  EMNavigationView.h
//  EMLabeledPageViewController
//
//  Created by Erik Mathisen on 06/03/16.
//  Copyright © 2016 Erik Mathisen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMNavigationView : UIView

// initialization
-(id)initWithLeftTitle:(NSString *)leftTitle centerTitle:(NSString *)centerTitle rightTitle:(NSString *)rightTitle;

// Methods
-(void)setBoldIndex:(NSInteger)boldLabelIndex;

// Properties
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end
