//
//  PageViewController.m
//  Dev_iOs_ObjC
//
//  Created by Tatiana Tsygankova on 30/05/2019.
//  Copyright © 2019 Tatiana Tsygankova. All rights reserved.
//

#import "PageViewController.h"
#import "ContentViewController.h"

@interface PageViewController ()

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *texts;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation PageViewController

- (instancetype)init
{
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self) {
        self.images = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"orders_map"], [UIImage imageNamed:@"orders_list"], [UIImage imageNamed:@"deliveries_list"], nil];
        self.texts = [[NSMutableArray alloc] initWithObjects:@"Определяйте адреса заказов, и свое местоположение на карте", @"Просматривайте список новых заказов, отмечайте доставку заказа", @"Просматривайте список доставленных заказов", nil];
        
        self.dataSource = self;
        self.delegate = self;
        
        ContentViewController *startVC = [self contentViewControllerAtIndex:0];
        [self setViewControllers:@[startVC]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:true completion:nil];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - 100, self.view.bounds.size.width,
                                                                            50)];
        [self.pageControl setNumberOfPages:[self.images count]];
        [self.pageControl setCurrentPage:0];
        [self.pageControl setPageIndicatorTintColor:[UIColor blackColor]];
        [self.pageControl setCurrentPageIndicatorTintColor:[UIColor blueColor]];
        [self.view addSubview:self.pageControl];
        
    }
    return self;
}

- (ContentViewController*)contentViewControllerAtIndex:(NSInteger)index {
    if (index < 0 || index >= [self.images count]) {
        return nil;
    }
    return [[ContentViewController alloc] initWithContent:[self.texts objectAtIndex:index]
                                                withImage:[self.images objectAtIndex:index]
                                                 forIndex:index];
}

#pragma mark - UIPageViewControllerDataSource -
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = ((ContentViewController*)viewController).index;
    index += 1;
    return [self contentViewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = ((ContentViewController*)viewController).index;
    index -= 1;
    return [self contentViewControllerAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate -

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        int index = ((ContentViewController*)[pageViewController.viewControllers firstObject]).index;
        [self.pageControl setCurrentPage:index];
    }
}

@end
