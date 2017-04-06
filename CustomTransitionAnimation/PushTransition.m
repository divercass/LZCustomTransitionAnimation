//
//  PushTransition.m
//  CustomTransitionAnimation
//
//  Created by 罗展 on 2017/1/17.
//  Copyright © 2017年 cass. All rights reserved.
//

#import "PushTransition.h"

//引入fromVC和toVC
#import "CollectionViewController.h"
#import "ViewController.h"

@implementation PushTransition
#pragma <UIViewControllerAnimatedTransitioning>

//指定动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

//具体动画执行方法
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //获取动画的原控制器和目标控制器
    CollectionViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = transitionContext.containerView;
    
    //创建一个imageview的截图,并把原本imageview隐藏,造成移动imageview的假象
    UIView *snapshotView = [fromVC.seletorCell snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = [container convertRect:fromVC.seletorCell.frame fromView:fromVC.view];
    fromVC.seletorCell.hidden = YES;
    
    //设置目标控制器位置,并把透明度设为0,在后面的动画中逐渐显示为1
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    
    //都添加到container中
    [container addSubview:toVC.view];
    [container addSubview:snapshotView];
    
    //执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        snapshotView.frame = toVC.avatarImageView.frame;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromVC.seletorCell.hidden = NO;
        toVC.avatarImageView.image = fromVC.sourceImageView.image;
        [snapshotView removeFromSuperview];
    }];
    
    //动画执行完毕让系统管理
    [transitionContext completeTransition:YES];
    
}


@end
