//
//  WrapperViewController.m
//  KuangJia
//
//  Created by pillar on 2018/11/4.
//  Copyright © 2018 yidezhang. All rights reserved.
//

#import "WrapperViewController.h"

@interface WrapperViewController ()

@end

@implementation WrapperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.subViewControllers) {
        self.selectedViewController = self.subViewControllers[self.selectedIndex];
        [self displayContentController:self.selectedViewController];
    }
    // Do any additional setup after loading the view.
}
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex == selectedIndex) {
        return;
    }
    NSUInteger count = self.subViewControllers.count;
    if (count == 0) {
        _selectedIndex = 0;
        return;
    }
    
    _selectedIndex = selectedIndex < 0 ? 0 : (selectedIndex > count - 1 ? count - 1 : selectedIndex);
    
    UIViewController* selectedViewController = self.subViewControllers[_selectedIndex];
    if (self.selectedViewController == nil) {
        [self displayContentController:selectedViewController];
        self.selectedViewController = selectedViewController;
    } else {
        [self cycleFromViewController:self.selectedViewController toViewController:selectedViewController];
    }
}

- (void) displayContentController: (UIViewController*) content {
    [self addChildViewController:content];
    content.view.frame = [self frameForContentController];
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
}
- (void) hideContentController: (UIViewController*) content {
    [content willMoveToParentViewController:nil];
    [content.view removeFromSuperview];
    [content removeFromParentViewController];
}
- (void)cycleFromViewController: (UIViewController*) oldVC
               toViewController: (UIViewController*) newVC {
    if (self.selectedViewController == newVC) {
        return;
    }
    // Prepare the two view controllers for the change.
    [oldVC willMoveToParentViewController:nil];
    [self addChildViewController:newVC];
    
    // Get the start frame of the new view controller and the end frame
    // for the old view controller. Both rectangles are offscreen.
    newVC.view.frame = [self frameForContentController];
    CGRect endFrame = [self frameForContentController];
    
    // Queue up the transition animation.
    [self transitionFromViewController: oldVC toViewController: newVC
                              duration: 0.1 options:0
                            animations:^{
                                // Animate the views to their final positions.
                                newVC.view.frame = oldVC.view.frame;
                                oldVC.view.frame = endFrame;
                            }
                            completion:^(BOOL finished) {
                                // Remove the old view controller and send the final
                                // notification to the new view controller.
                                [oldVC removeFromParentViewController];
                                [newVC didMoveToParentViewController:self];
                                self.selectedViewController = newVC;
                            }];
}

- (CGRect)frameForContentController {
    return self.view.bounds;
}

@end
