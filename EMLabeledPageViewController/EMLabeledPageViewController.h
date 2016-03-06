//
//  EMLabeledPageViewController.h
//  EMLabeledPageViewController
//
//  Created by Erik Mathisen on 06/03/16.
//  Copyright © 2016 Erik Mathisen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMNavigationView.h"

@interface EMLabeledPageViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

// initialization
-(id)initWithLeftTitle:(NSString *)leftTitle
           centerTitle:(NSString *)centerTitle
            rightTitle:(NSString *)rightTitle
    leftViewController:(UIViewController *)leftViewController
  centerViewController:(UIViewController *)centerViewController
   rightViewController:(UIViewController *)rightViewController;

// Properies
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *navViewControllers;

// Control
@property (nonatomic, strong) EMNavigationView *navigationView;

// Navigation view properties
@property (nonatomic, strong) UIColor *navigationViewTextColor;
@property (nonatomic, strong) UIFont *navigationViewTextFont;

@end
