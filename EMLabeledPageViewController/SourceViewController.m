//
//  SourceViewController.m
//  EMLabeledPageViewController
//
//  Created by Erik Mathisen on 06/03/16.
//  Copyright © 2016 Erik Mathisen. All rights reserved.
//

#import "SourceViewController.h"

@interface SourceViewController ()

@end

@implementation SourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(presentNow) withObject:nil afterDelay:1.0];
}

-(void)presentNow
{
    UIViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"VC1"];
    UIViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"VC2"];
    UIViewController *vc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"VC3"];
    
    EMLabeledPageViewController *pageViewController = [[EMLabeledPageViewController alloc] initWithLeftTitle:@"Left"
                                                                                                 centerTitle:@"Center"
                                                                                                  rightTitle:@"Right"
                                                                                          leftViewController:vc1
                                                                                        centerViewController:vc2
                                                                                         rightViewController:vc3];
    
    [self presentViewController:pageViewController animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
