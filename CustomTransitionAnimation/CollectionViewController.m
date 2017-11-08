//
//  CollectionViewController.m
//  CustomTransitionAnimation
//
//  Created by 罗展 on 2017/1/17.
//  Copyright © 2017年 cass. All rights reserved.
//

#import "CollectionViewController.h"
#import "ViewController.h"
#import "PushTransition.h"
#import "PopTransition.h"

@interface CollectionViewController () <UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [[PushTransition alloc] init];
    } else if (operation == UINavigationControllerOperationPop) {
        return [[PopTransition alloc] init];
    } else {
        return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    self.sourceImageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    self.sourceImageView.image = [UIImage imageNamed:@"image.jpg"];
    self.sourceImageView.tag = indexPath.item;
    [cell.contentView addSubview:self.sourceImageView];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    self.seletorCell = cell;
    
    ViewController *vc = [[ViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    vc.view.backgroundColor = [UIColor cyanColor];
    vc.navigationItem.title = [NSString stringWithFormat:@"%ld",indexPath.item];
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
}

@end
