//
//  PushTransition.m
//  CustomTransitionAnimation
//
//  Created by 罗展 on 2017/1/17.
//  Copyright © 2017年 cass. All rights reserved.
//

#import "PopTransition.h"

//引入fromVC和toVC
#import "CollectionViewController.h"
#import "ViewController.h"

@implementation PopTransition
#pragma <UIViewControllerAnimatedTransitioning>

//指定动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

//具体动画执行方法
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //获取动画的原控制器和目标控制器
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CollectionViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = transitionContext.containerView;
    
    //创建一个imageview的截图,并把原本imageview隐藏,造成移动imageview的假象
    UIView *snapshotView = [fromVC.avatarImageView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = [container convertRect:fromVC.avatarImageView.frame fromView:fromVC.view];
    fromVC.avatarImageView.hidden = YES;
    
    //设置目标控制器位置,并把透明度设为0,在后面的动画中逐渐显示为1
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.seletorCell.hidden = YES;
    
    //都添加到container中
    [container insertSubview:toVC.view belowSubview:fromVC.view];
    [container addSubview:snapshotView];
    
    //执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //如有导航栏注意添加导航栏高度
        CGRect frame = toVC.seletorCell.frame;
        frame.origin.y = toVC.seletorCell.frame.origin.y;
        snapshotView.frame = frame;
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        toVC.seletorCell.hidden = NO;
        [snapshotView removeFromSuperview];
        fromVC.avatarImageView.hidden = NO;
    }];
    
    //动画执行完毕让系统管理
    [transitionContext completeTransition: ![transitionContext transitionWasCancelled]];
    
}


@end
