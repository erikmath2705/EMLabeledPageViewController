//
//  EMLabeledPageViewController.m
//  EMLabeledPageViewController
//
//  Created by Erik Mathisen on 06/03/16.
//  Copyright © 2016 Erik Mathisen. All rights reserved.
//

#import "EMLabeledPageViewController.h"

@interface EMLabeledPageViewController ()

@property (nonatomic, strong, readwrite) UIPageViewController *pageViewController;
@property (nonatomic, strong, readwrite) NSArray *navViewControllers;
@property (nonatomic, strong, readwrite) EMNavigationView *navigationView;

@end

@implementation EMLabeledPageViewController

@synthesize navigationViewTextColor = _navigationViewTextColor;
@synthesize navigationViewTextFont = _navigationViewTextFont;

#pragma mark - initialization

-(id)initWithLeftTitle:(NSString *)leftTitle
           centerTitle:(NSString *)centerTitle
            rightTitle:(NSString *)rightTitle
    leftViewController:(UIViewController *)leftViewController
  centerViewController:(UIViewController *)centerViewController
   rightViewController:(UIViewController *)rightViewController
{
    if (self = [super init])
    {
        
        if (
            [leftTitle isKindOfClass:[NSString class]]
            && [centerTitle isKindOfClass:[NSString class]]
            && [rightTitle isKindOfClass:[NSString class]]
            
            && [leftViewController isKindOfClass:[UIViewController class]]
            && [centerViewController isKindOfClass:[UIViewController class]]
            && [rightViewController isKindOfClass:[UIViewController class]]
            )
        {
            /* init pageViewController */
            self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
            self.pageViewController.dataSource = self;
            self.pageViewController.delegate = self;
            self.pageViewController.view.frame = self.view.frame;
            [self.pageViewController willMoveToParentViewController:self];
            [self addChildViewController:self.pageViewController];
            [self.view addSubview:self.pageViewController.view];
            [self.pageViewController didMoveToParentViewController:self];
            
            
            /* remove dots */
            NSArray *subviews = self.pageViewController.view.subviews;
            UIPageControl *bottomControl = nil;
            for (int i=0; i<[subviews count]; i++) {
                if ([[subviews objectAtIndex:i] isKindOfClass:[UIPageControl class]]) {
                    bottomControl = (UIPageControl *)[subviews objectAtIndex:i];
                }
            }
            bottomControl.hidden = true;
            self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+40);
            
            /* set viewcontrollers */
            self.navViewControllers = @[
                                        leftViewController,
                                        centerViewController,
                                        rightViewController
                                        ];
            
            [self.pageViewController setViewControllers:@[self.navViewControllers[1]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            
            /* create titles */
            CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
            CGFloat navigationViewMargin = 15.0f;
            CGFloat navigationViewWidth = screenWidth - (navigationViewMargin * 2);
            CGFloat navigationViewHeight = 18.0f;
            CGFloat navigationViewXPosition = navigationViewMargin;
            CGFloat navigationViewYPosition = 30.0f;
            CGRect navigationViewFrame = CGRectMake(navigationViewXPosition, navigationViewYPosition, navigationViewWidth, navigationViewHeight);
            
            self.navigationView = [[EMNavigationView alloc] initWithLeftTitle:(NSString *)leftTitle
                                                                  centerTitle:(NSString *)centerTitle
                                                                   rightTitle:(NSString *)rightTitle];
            self.navigationView.frame = navigationViewFrame;
            [self.view addSubview:self.navigationView];
        } else
        {
            // Invalid arguments
            [NSException raise:@"Invalid arguments" format:@"Expecting 3 strings and 3 viewcontroller subclasses"];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - page view controller data source

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger currentIndex = [self.navViewControllers indexOfObject:viewController];
    if (currentIndex != 0)
    {
        return self.navViewControllers[currentIndex - 1];
    } else
    {
        return nil;
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger currentIndex = [self.navViewControllers indexOfObject:viewController];
    if (currentIndex != ([self.navViewControllers count] - 1))
    {
        return self.navViewControllers[currentIndex + 1];
    } else
    {
        return nil;
    }
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.navViewControllers.count;
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        NSInteger newPageIndex = [self.navViewControllers indexOfObject:pageViewController.viewControllers[0]];
        CGFloat navigationViewWidth = self.navigationView.frame.size.width;
        CGFloat navigationViewHeight = self.navigationView.frame.size.height;
        CGFloat xPosition = 15.0f;
        
        switch (newPageIndex) {
            case 0:
            {
                xPosition = [[UIScreen mainScreen] bounds].size.width / 2;
                xPosition -= (self.navigationView.leftLabel.frame.size.width / 2);
            }
                break;
            case 1:
                xPosition = 15.0f;
                break;
            case 2:
                xPosition = [[UIScreen mainScreen] bounds].size.width / 2;
                xPosition -= navigationViewWidth;
                xPosition += self.navigationView.rightLabel.frame.size.width / 2;
                break;
            default:
                break;
        }
        [self.navigationView setBoldIndex:newPageIndex];
        [UIView animateWithDuration:0.5 animations:^{
            [self.navigationView setFrame:CGRectMake(xPosition, 30, navigationViewWidth, navigationViewHeight)];
        }];
    }
}

#pragma mark - custom setter methods

-(void)setNavigationViewTextFont:(UIFont *)navigationViewTextFont {
    _navigationViewTextFont = navigationViewTextFont;
    
    [self.navigationView.leftLabel setFont:navigationViewTextFont];
    [self.navigationView.centerLabel setFont:navigationViewTextFont];
    [self.navigationView.rightLabel setFont:navigationViewTextFont];
}

-(void)setNavigationViewTextColor:(UIColor *)navigationViewTextColor {
    _navigationViewTextColor = navigationViewTextColor;
    
    [self.navigationView.leftLabel setTextColor:navigationViewTextColor];
    [self.navigationView.centerLabel setTextColor:navigationViewTextColor];
    [self.navigationView.rightLabel setTextColor:navigationViewTextColor];
}

@end
